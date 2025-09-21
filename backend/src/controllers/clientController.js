const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();

// Get all clients
exports.getClients = async (req, res) => {
  try {
    const { search, page = 1, limit = 10 } = req.query;
    const skip = (page - 1) * limit;

    let where = {};
    if (search) {
      where = {
        OR: [
          { firstName: { contains: search, mode: 'insensitive' } },
          { lastName: { contains: search, mode: 'insensitive' } },
          { email: { contains: search, mode: 'insensitive' } },
          { phone: { contains: search } }
        ]
      };
    }

    const clients = await prisma.client.findMany({
      where,
      skip: parseInt(skip),
      take: parseInt(limit),
      include: {
        createdBy: {
          select: {
            firstName: true,
            lastName: true
          }
        },
        _count: {
          select: {
            cases: true,
            communications: true,
            documents: true
          }
        }
      },
      orderBy: {
        createdAt: 'desc'
      }
    });

    const total = await prisma.client.count({ where });

    res.json({
      clients,
      pagination: {
        page: parseInt(page),
        limit: parseInt(limit),
        total,
        pages: Math.ceil(total / limit)
      }
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Get client by ID
exports.getClientById = async (req, res) => {
  try {
    const { id } = req.params;

    const client = await prisma.client.findUnique({
      where: { id },
      include: {
        createdBy: {
          select: {
            firstName: true,
            lastName: true,
            email: true
          }
        },
        cases: {
          include: {
            attorney: {
              select: {
                firstName: true,
                lastName: true
              }
            },
            paralegal: {
              select: {
                firstName: true,
                lastName: true
              }
            }
          }
        },
        communications: {
          take: 5,
          orderBy: {
            dateTime: 'desc'
          }
        },
        documents: {
          take: 5,
          orderBy: {
            createdAt: 'desc'
          }
        }
      }
    });

    if (!client) {
      return res.status(404).json({ error: 'Client not found' });
    }

    res.json(client);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Create client
exports.createClient = async (req, res) => {
  try {
    const {
      firstName,
      lastName,
      email,
      phone,
      address,
      city,
      state,
      zipCode,
      dateOfBirth,
      emergencyContact,
      emergencyPhone,
      notes,
      source
    } = req.body;

    const client = await prisma.client.create({
      data: {
        firstName,
        lastName,
        email,
        phone,
        address,
        city,
        state,
        zipCode,
        dateOfBirth: dateOfBirth ? new Date(dateOfBirth) : null,
        emergencyContact,
        emergencyPhone,
        notes,
        source,
        createdById: req.user?.userId || req.user?.id || 'system'
      },
      include: {
        createdBy: {
          select: {
            firstName: true,
            lastName: true
          }
        }
      }
    });

    // Log activity
    await prisma.activity.create({
      data: {
        action: 'CREATE',
        description: `Created client: ${firstName} ${lastName}`,
        entityType: 'CLIENT',
        entityId: client.id,
        userId: req.user?.userId || req.user?.id || 'system',
        ipAddress: req.ip,
        userAgent: req.get('User-Agent')
      }
    });

    res.status(201).json(client);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Update client
exports.updateClient = async (req, res) => {
  try {
    const { id } = req.params;
    const updateData = { ...req.body };

    if (updateData.dateOfBirth) {
      updateData.dateOfBirth = new Date(updateData.dateOfBirth);
    }

    const client = await prisma.client.update({
      where: { id },
      data: updateData,
      include: {
        createdBy: {
          select: {
            firstName: true,
            lastName: true
          }
        }
      }
    });

    // Log activity
    await prisma.activity.create({
      data: {
        action: 'UPDATE',
        description: `Updated client: ${client.firstName} ${client.lastName}`,
        entityType: 'CLIENT',
        entityId: client.id,
        userId: req.user?.userId || req.user?.id || 'system',
        ipAddress: req.ip,
        userAgent: req.get('User-Agent')
      }
    });

    res.json(client);
  } catch (error) {
    if (error.code === 'P2025') {
      return res.status(404).json({ error: 'Client not found' });
    }
    res.status(500).json({ error: error.message });
  }
};

// Delete client
exports.deleteClient = async (req, res) => {
  try {
    const { id } = req.params;

    const client = await prisma.client.findUnique({ where: { id } });
    if (!client) {
      return res.status(404).json({ error: 'Client not found' });
    }

    await prisma.client.delete({
      where: { id }
    });

    // Log activity
    await prisma.activity.create({
      data: {
        action: 'DELETE',
        description: `Deleted client: ${client.firstName} ${client.lastName}`,
        entityType: 'CLIENT',
        entityId: client.id,
        userId: req.user?.userId || req.user?.id || 'system',
        ipAddress: req.ip,
        userAgent: req.get('User-Agent')
      }
    });

    res.json({ message: 'Client deleted successfully' });
  } catch (error) {
    if (error.code === 'P2025') {
      return res.status(404).json({ error: 'Client not found' });
    }
    res.status(500).json({ error: error.message });
  }
};

// Get client cases
exports.getClientCases = async (req, res) => {
  try {
    const { id } = req.params;

    const cases = await prisma.case.findMany({
      where: { clientId: id },
      include: {
        attorney: {
          select: {
            firstName: true,
            lastName: true
          }
        },
        paralegal: {
          select: {
            firstName: true,
            lastName: true
          }
        },
        _count: {
          documents: true,
          tasks: true,
          timeEntries: true
        }
      },
      orderBy: {
        createdAt: 'desc'
      }
    });

    res.json(cases);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Get client communications
exports.getClientCommunications = async (req, res) => {
  try {
    const { id } = req.params;
    const { page = 1, limit = 20 } = req.query;
    const skip = (page - 1) * limit;

    const communications = await prisma.communication.findMany({
      where: { clientId: id },
      skip: parseInt(skip),
      take: parseInt(limit),
      include: {
        user: {
          select: {
            firstName: true,
            lastName: true
          }
        },
        case: {
          select: {
            title: true,
            caseNumber: true
          }
        }
      },
      orderBy: {
        dateTime: 'desc'
      }
    });

    const total = await prisma.communication.count({
      where: { clientId: id }
    });

    res.json({
      communications,
      pagination: {
        page: parseInt(page),
        limit: parseInt(limit),
        total,
        pages: Math.ceil(total / limit)
      }
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};