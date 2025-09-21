const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();

// Generate case number
const generateCaseNumber = () => {
  const year = new Date().getFullYear();
  const random = Math.floor(Math.random() * 10000).toString().padStart(4, '0');
  return `${year}-${random}`;
};

// Get all cases
exports.getCases = async (req, res) => {
  try {
    const { 
      status, 
      type, 
      attorneyId, 
      paralegalId,
      search,
      page = 1, 
      limit = 10 
    } = req.query;
    const skip = (page - 1) * limit;

    let where = {};
    
    if (status) where.status = status;
    if (type) where.type = type;
    if (attorneyId) where.attorneyId = attorneyId;
    if (paralegalId) where.paralegalId = paralegalId;
    
    if (search) {
      where.OR = [
        { title: { contains: search, mode: 'insensitive' } },
        { caseNumber: { contains: search, mode: 'insensitive' } },
        { client: { 
          firstName: { contains: search, mode: 'insensitive' } 
        }},
        { client: { 
          lastName: { contains: search, mode: 'insensitive' } 
        }}
      ];
    }

    const cases = await prisma.case.findMany({
      where,
      skip: parseInt(skip),
      take: parseInt(limit),
      include: {
        client: {
          select: {
            firstName: true,
            lastName: true,
            email: true,
            phone: true
          }
        },
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
      },
      orderBy: {
        createdAt: 'desc'
      }
    });

    const total = await prisma.case.count({ where });

    res.json({
      cases,
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

// Get case by ID
exports.getCaseById = async (req, res) => {
  try {
    const { id } = req.params;

    const caseData = await prisma.case.findUnique({
      where: { id },
      include: {
        client: true,
        attorney: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            email: true,
            phone: true
          }
        },
        paralegal: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            email: true,
            phone: true
          }
        },
        incidents: true,
        medicalRecords: {
          include: {
            provider: true
          }
        },
        insurance: true,
        documents: {
          include: {
            uploadedBy: {
              select: {
                firstName: true,
                lastName: true
              }
            }
          }
        },
        tasks: {
          include: {
            assignedTo: {
              select: {
                firstName: true,
                lastName: true
              }
            }
          },
          orderBy: {
            dueDate: 'asc'
          }
        },
        timeEntries: {
          include: {
            user: {
              select: {
                firstName: true,
                lastName: true
              }
            }
          },
          orderBy: {
            date: 'desc'
          }
        },
        communications: {
          include: {
            user: {
              select: {
                firstName: true,
                lastName: true
              }
            }
          },
          orderBy: {
            dateTime: 'desc'
          },
          take: 10
        },
        notes: {
          include: {
            createdBy: {
              select: {
                firstName: true,
                lastName: true
              }
            }
          },
          orderBy: {
            createdAt: 'desc'
          }
        },
        expenses: {
          orderBy: {
            date: 'desc'
          }
        }
      }
    });

    if (!caseData) {
      return res.status(404).json({ error: 'Case not found' });
    }

    res.json(caseData);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Create case
exports.createCase = async (req, res) => {
  try {
    const {
      title,
      description,
      type,
      clientId,
      attorneyId,
      paralegalId,
      statute
    } = req.body;

    const caseNumber = generateCaseNumber();

    const caseData = await prisma.case.create({
      data: {
        caseNumber,
        title,
        description,
        type,
        clientId,
        attorneyId,
        paralegalId,
        statute: statute ? new Date(statute) : null
      },
      include: {
        client: {
          select: {
            firstName: true,
            lastName: true,
            email: true
          }
        },
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
    });

    // Log activity
    await prisma.activity.create({
      data: {
        action: 'CREATE',
        description: `Created case: ${title}`,
        entityType: 'CASE',
        entityId: caseData.id,
        userId: req.user.id,
        ipAddress: req.ip,
        userAgent: req.get('User-Agent')
      }
    });

    res.status(201).json(caseData);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Update case
exports.updateCase = async (req, res) => {
  try {
    const { id } = req.params;
    const updateData = { ...req.body };

    if (updateData.statute) {
      updateData.statute = new Date(updateData.statute);
    }
    if (updateData.dateClosed) {
      updateData.dateClosed = new Date(updateData.dateClosed);
    }

    const caseData = await prisma.case.update({
      where: { id },
      data: updateData,
      include: {
        client: {
          select: {
            firstName: true,
            lastName: true
          }
        },
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
    });

    // Log activity
    await prisma.activity.create({
      data: {
        action: 'UPDATE',
        description: `Updated case: ${caseData.title}`,
        entityType: 'CASE',
        entityId: caseData.id,
        userId: req.user.id,
        ipAddress: req.ip,
        userAgent: req.get('User-Agent')
      }
    });

    res.json(caseData);
  } catch (error) {
    if (error.code === 'P2025') {
      return res.status(404).json({ error: 'Case not found' });
    }
    res.status(500).json({ error: error.message });
  }
};

// Update case status
exports.updateCaseStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.body;

    const updateData = { status };
    if (status === 'CLOSED' || status === 'SETTLED') {
      updateData.dateClosed = new Date();
    }

    const caseData = await prisma.case.update({
      where: { id },
      data: updateData,
      include: {
        client: {
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
        action: 'STATUS_UPDATE',
        description: `Changed case status to ${status}`,
        entityType: 'CASE',
        entityId: caseData.id,
        userId: req.user.id,
        ipAddress: req.ip,
        userAgent: req.get('User-Agent')
      }
    });

    res.json(caseData);
  } catch (error) {
    if (error.code === 'P2025') {
      return res.status(404).json({ error: 'Case not found' });
    }
    res.status(500).json({ error: error.message });
  }
};

// Get case timeline
exports.getCaseTimeline = async (req, res) => {
  try {
    const { id } = req.params;

    // Get all activities for this case
    const activities = await prisma.activity.findMany({
      where: {
        entityType: 'CASE',
        entityId: id
      },
      include: {
        user: {
          select: {
            firstName: true,
            lastName: true
          }
        }
      },
      orderBy: {
        createdAt: 'desc'
      }
    });

    // Get case communications
    const communications = await prisma.communication.findMany({
      where: { caseId: id },
      include: {
        user: {
          select: {
            firstName: true,
            lastName: true
          }
        }
      },
      orderBy: {
        dateTime: 'desc'
      }
    });

    // Get case tasks
    const tasks = await prisma.task.findMany({
      where: { caseId: id },
      include: {
        assignedTo: {
          select: {
            firstName: true,
            lastName: true
          }
        }
      },
      orderBy: {
        createdAt: 'desc'
      }
    });

    // Combine and sort all timeline events
    const timeline = [
      ...activities.map(activity => ({
        type: 'activity',
        date: activity.createdAt,
        data: activity
      })),
      ...communications.map(comm => ({
        type: 'communication',
        date: comm.dateTime,
        data: comm
      })),
      ...tasks.map(task => ({
        type: 'task',
        date: task.createdAt,
        data: task
      }))
    ].sort((a, b) => new Date(b.date) - new Date(a.date));

    res.json(timeline);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Record settlement
exports.recordSettlement = async (req, res) => {
  try {
    const { id } = req.params;
    const { settlementAmount, attorneyFees, costs } = req.body;

    const netToClient = parseFloat(settlementAmount) - parseFloat(attorneyFees || 0) - parseFloat(costs || 0);

    const caseData = await prisma.case.update({
      where: { id },
      data: {
        settlementAmount: parseFloat(settlementAmount),
        attorneyFees: parseFloat(attorneyFees || 0),
        costs: parseFloat(costs || 0),
        netToClient,
        status: 'SETTLED',
        dateClosed: new Date()
      },
      include: {
        client: {
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
        action: 'SETTLEMENT',
        description: `Recorded settlement of $${settlementAmount}`,
        entityType: 'CASE',
        entityId: caseData.id,
        userId: req.user.id,
        ipAddress: req.ip,
        userAgent: req.get('User-Agent')
      }
    });

    res.json(caseData);
  } catch (error) {
    if (error.code === 'P2025') {
      return res.status(404).json({ error: 'Case not found' });
    }
    res.status(500).json({ error: error.message });
  }
};