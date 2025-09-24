const BaseController = require('./BaseController');
const { ErrorHandler } = require('../middleware/errorHandler');
const APIResponse = require('../lib/apiResponse');
const prisma = require('../lib/prisma');
const AuthUtils = require('../lib/authUtils');

class CaseController extends BaseController {
  constructor() {
    super(prisma.case, {
      allowedFilters: [
        'type', 'status', 'priority', 'stage', 'source', 'clientId', 'attorneyId', 
        'paralegalId', 'isActive', 'isArchived', 'dateOpened', 'statute', 'nextDeadline'
      ],
      allowedSortFields: [
        'caseNumber', 'title', 'type', 'status', 'priority', 'stage', 'dateOpened', 
        'statute', 'nextDeadline', 'estimatedValue', 'settlementAmount', 'createdAt', 'updatedAt'
      ],
      defaultSort: { createdAt: 'desc' },
      include: {
        client: {
          select: {
            id: true,
            firstName: true,
            lastName: true,
            email: true,
            phone: true,
            clientNumber: true
          }
        },
        attorney: {
          select: {
            id: true,
            name: true,
            email: true,
            role: true
          }
        },
        paralegal: {
          select: {
            id: true,
            name: true,
            email: true,
            role: true
          }
        },
        secondAttorney: {
          select: {
            id: true,
            name: true,
            email: true,
            role: true
          }
        },
        referringAttorney: {
          select: {
            id: true,
            name: true,
            email: true,
            role: true
          }
        },
        _count: {
          select: {
            documents: true,
            tasks: true,
            communications: true,
            timeEntries: true,
            expenses: true
          }
        }
      },
      searchFields: ['caseNumber', 'title', 'description'],
      requiredCreateFields: ['title', 'type', 'clientId'],
      allowedCreateFields: [
        'title', 'description', 'type', 'status', 'priority', 'stage', 'source',
        'consultationDate', 'retainerSignedDate', 'statute', 'nextDeadline', 'deadlineDescription',
        'clientId', 'attorneyId', 'paralegalId', 'secondAttorneyId', 'referringAttorneyId',
        'estimatedValue', 'demandAmount', 'contingencyRate', 'internalNotes', 'clientInstructions',
        'workflowTemplate', 'customFields'
      ],
      allowedUpdateFields: [
        'title', 'description', 'type', 'status', 'priority', 'stage', 'source',
        'consultationDate', 'retainerSignedDate', 'discoveryStartDate', 'discoveryEndDate',
        'mediationDate', 'trialDate', 'settlementDate', 'dateClosed', 'statute', 'nextDeadline', 
        'deadlineDescription', 'attorneyId', 'paralegalId', 'secondAttorneyId', 'referringAttorneyId',
        'estimatedValue', 'demandAmount', 'settlementAmount', 'attorneyFees', 'costs', 'netToClient',
        'contingencyRate', 'isActive', 'isArchived', 'internalNotes', 'clientInstructions',
        'workflowTemplate', 'customFields'
      ]
    });
  }

  // Override user filtering for case access control
  addUserFilter(where, user) {
    if (user.role === 'ADMIN') {
      return where;
    }
    
    // Non-admin users can only see cases where they are involved
    return {
      ...where,
      OR: [
        { attorneyId: user.userId },
        { paralegalId: user.userId },
        { secondAttorneyId: user.userId }
      ]
    };
  }

  // Override beforeCreate to generate case number and remove invalid fields
  async beforeCreate(data, req) {
    // Auto-generate case number if not provided
    if (!data.caseNumber) {
      const year = new Date().getFullYear();
      const lastCase = await prisma.case.findFirst({
        where: {
          caseNumber: {
            startsWith: `CS${year}`
          }
        },
        orderBy: { caseNumber: 'desc' }
      });

      let nextNumber = 1;
      if (lastCase) {
        const lastNumber = parseInt(lastCase.caseNumber.slice(-4));
        nextNumber = lastNumber + 1;
      }

      data.caseNumber = `CS${year}${nextNumber.toString().padStart(4, '0')}`;
    }

    // Remove userId as Case model doesn't have this field
    delete data.userId;

    return data;
  }

  // Override afterCreate for activity logging and initial status history
  async afterCreate(resource, req) {
    try {
      // Log case creation activity
      await prisma.activity.create({
        data: {
          id: AuthUtils.generateToken(16),
          action: 'CASE_CREATED',
          description: `Case created: ${resource.caseNumber} - ${resource.title}`,
          entityType: 'CASE',
          entityId: resource.id,
          userId: req.user?.userId,
          ipAddress: req.ip,
          userAgent: req.get('User-Agent')
        }
      });

      // Create initial status history record
      await prisma.caseStatusHistory.create({
        data: {
          id: AuthUtils.generateToken(16),
          caseId: resource.id,
          fromStatus: null,
          toStatus: resource.status || 'INTAKE',
          changedById: req.user?.userId,
          reason: 'Case created',
          notes: 'Initial case status'
        }
      });

      // Create initial case value if estimated value provided
      if (resource.estimatedValue) {
        await prisma.caseValue.create({
          data: {
            id: AuthUtils.generateToken(16),
            caseId: resource.id,
            valueType: 'INITIAL_ESTIMATE',
            amount: resource.estimatedValue,
            description: 'Initial estimated case value',
            enteredById: req.user?.userId
          }
        });
      }

    } catch (error) {
      console.error('Failed to log case creation:', error);
    }
  }

  // Override afterUpdate for activity logging and status history
  async afterUpdate(resource, originalData, req) {
    try {
      // Log case update activity
      await prisma.activity.create({
        data: {
          id: AuthUtils.generateToken(16),
          action: 'CASE_UPDATED',
          description: `Case updated: ${resource.caseNumber} - ${resource.title}`,
          entityType: 'CASE',
          entityId: resource.id,
          userId: req.user?.userId,
          ipAddress: req.ip,
          userAgent: req.get('User-Agent')
        }
      });

      // Track status changes
      if (originalData.status !== resource.status) {
        await prisma.caseStatusHistory.create({
          data: {
            id: AuthUtils.generateToken(16),
            caseId: resource.id,
            fromStatus: originalData.status,
            toStatus: resource.status,
            changedById: req.user?.userId,
            reason: req.body.statusChangeReason || 'Status updated',
            notes: req.body.statusChangeNotes
          }
        });
      }

    } catch (error) {
      console.error('Failed to log case update:', error);
    }
  }

  // Get case lifecycle/status history
  getCaseStatusHistory = ErrorHandler.asyncHandler(async (req, res) => {
    const { id } = req.params;

    // Verify case exists
    const case_ = await this.model.findUnique({
      where: { id },
      select: { id: true, caseNumber: true, title: true }
    });

    if (!case_) {
      const response = APIResponse.notFound('Case', id);
      return res.status(404).json(response);
    }

    const history = await prisma.caseStatusHistory.findMany({
      where: { caseId: id },
      include: {
        changedBy: {
          select: {
            id: true,
            name: true,
            email: true,
            role: true
          }
        }
      },
      orderBy: { changedAt: 'desc' }
    });

    const response = APIResponse.success(history, 'Case status history retrieved successfully');
    res.json(response);
  });

  // Get cases by attorney workload
  getAttorneyWorkload = ErrorHandler.asyncHandler(async (req, res) => {
    const { attorneyId } = req.params;
    const { includeArchived = false } = req.query;

    // Get attorney info
    const attorney = await prisma.user.findUnique({
      where: { id: attorneyId },
      select: { id: true, name: true, email: true, role: true }
    });

    if (!attorney) {
      const response = APIResponse.notFound('Attorney', attorneyId);
      return res.status(404).json(response);
    }

    // Build where clause
    const where = {
      OR: [
        { attorneyId },
        { paralegalId: attorneyId },
        { secondAttorneyId: attorneyId }
      ]
    };

    if (!includeArchived) {
      where.isArchived = false;
    }

    // Get cases and statistics
    const [cases, totalCases, activeCases, casesByStatus, casesByType] = await Promise.all([
      prisma.case.findMany({
        where,
        include: this.options.include,
        orderBy: [{ priority: 'desc' }, { nextDeadline: 'asc' }]
      }),
      prisma.case.count({ where }),
      prisma.case.count({ where: { ...where, isActive: true } }),
      prisma.case.groupBy({
        by: ['status'],
        where,
        _count: { id: true }
      }),
      prisma.case.groupBy({
        by: ['type'],
        where,
        _count: { id: true }
      })
    ]);

    const workload = {
      attorney,
      statistics: {
        totalCases,
        activeCases,
        byStatus: casesByStatus.reduce((acc, item) => {
          acc[item.status] = item._count.id;
          return acc;
        }, {}),
        byType: casesByType.reduce((acc, item) => {
          acc[item.type] = item._count.id;
          return acc;
        }, {})
      },
      cases
    };

    const response = APIResponse.success(workload, 'Attorney workload retrieved successfully');
    res.json(response);
  });

  // Get case deadlines and calendar overview
  getCaseDeadlines = ErrorHandler.asyncHandler(async (req, res) => {
    const { id } = req.params;
    const { upcoming = true } = req.query;

    // Verify case exists
    const case_ = await this.model.findUnique({
      where: { id },
      select: { id: true, caseNumber: true, title: true }
    });

    if (!case_) {
      const response = APIResponse.notFound('Case', id);
      return res.status(404).json(response);
    }

    // Build where clause for deadlines
    const where = { caseId: id };
    if (upcoming) {
      where.completed = false;
      where.dueDate = { gte: new Date() };
    }

    const deadlines = await prisma.caseDeadline.findMany({
      where,
      include: {
        completedBy: {
          select: {
            id: true,
            name: true,
            email: true
          }
        }
      },
      orderBy: { dueDate: 'asc' }
    });

    const response = APIResponse.success(deadlines, 'Case deadlines retrieved successfully');
    res.json(response);
  });

  // Create case deadline
  createCaseDeadline = ErrorHandler.asyncHandler(async (req, res) => {
    const { id } = req.params;
    const { title, description, dueDate, type, priority, isStatutory, reminderDays } = req.body;

    // Verify case exists
    const case_ = await this.model.findUnique({
      where: { id },
      select: { id: true, caseNumber: true }
    });

    if (!case_) {
      const response = APIResponse.notFound('Case', id);
      return res.status(404).json(response);
    }

    const deadline = await prisma.caseDeadline.create({
      data: {
        id: AuthUtils.generateToken(16),
        caseId: id,
        title,
        description,
        dueDate: new Date(dueDate),
        type,
        priority: priority || 'MEDIUM',
        isStatutory: isStatutory || false,
        reminderDays: reminderDays || [7, 1]
      },
      include: {
        completedBy: {
          select: {
            id: true,
            name: true,
            email: true
          }
        }
      }
    });

    // Update case next deadline if this is sooner
    const caseNextDeadline = await prisma.caseDeadline.findFirst({
      where: { caseId: id, completed: false },
      orderBy: { dueDate: 'asc' },
      select: { dueDate: true, title: true }
    });

    if (caseNextDeadline && (!case_.nextDeadline || caseNextDeadline.dueDate < case_.nextDeadline)) {
      await prisma.case.update({
        where: { id },
        data: {
          nextDeadline: caseNextDeadline.dueDate,
          deadlineDescription: caseNextDeadline.title
        }
      });
    }

    const response = APIResponse.created(deadline, 'Case deadline created successfully');
    res.status(201).json(response);
  });

  // Complete case deadline
  completeCaseDeadline = ErrorHandler.asyncHandler(async (req, res) => {
    const { id, deadlineId } = req.params;
    const { notes } = req.body;

    const deadline = await prisma.caseDeadline.findUnique({
      where: { id: deadlineId },
      select: { id: true, caseId: true, title: true }
    });

    if (!deadline || deadline.caseId !== id) {
      const response = APIResponse.notFound('Case deadline', deadlineId);
      return res.status(404).json(response);
    }

    const updated = await prisma.caseDeadline.update({
      where: { id: deadlineId },
      data: {
        completed: true,
        completedAt: new Date(),
        completedById: req.user.userId
      },
      include: {
        completedBy: {
          select: {
            id: true,
            name: true,
            email: true
          }
        }
      }
    });

    // Update case next deadline
    const nextDeadline = await prisma.caseDeadline.findFirst({
      where: { caseId: id, completed: false },
      orderBy: { dueDate: 'asc' },
      select: { dueDate: true, title: true }
    });

    await prisma.case.update({
      where: { id },
      data: {
        nextDeadline: nextDeadline?.dueDate || null,
        deadlineDescription: nextDeadline?.title || null
      }
    });

    const response = APIResponse.success(updated, 'Case deadline marked as complete');
    res.json(response);
  });

  // Get case value history
  getCaseValueHistory = ErrorHandler.asyncHandler(async (req, res) => {
    const { id } = req.params;

    // Verify case exists
    const case_ = await this.model.findUnique({
      where: { id },
      select: { id: true, caseNumber: true, title: true }
    });

    if (!case_) {
      const response = APIResponse.notFound('Case', id);
      return res.status(404).json(response);
    }

    const valueHistory = await prisma.caseValue.findMany({
      where: { caseId: id },
      include: {
        enteredBy: {
          select: {
            id: true,
            name: true,
            email: true
          }
        }
      },
      orderBy: { date: 'desc' }
    });

    const response = APIResponse.success(valueHistory, 'Case value history retrieved successfully');
    res.json(response);
  });

  // Add case value entry
  addCaseValue = ErrorHandler.asyncHandler(async (req, res) => {
    const { id } = req.params;
    const { valueType, amount, description } = req.body;

    // Verify case exists
    const case_ = await this.model.findUnique({
      where: { id },
      select: { id: true, caseNumber: true }
    });

    if (!case_) {
      const response = APIResponse.notFound('Case', id);
      return res.status(404).json(response);
    }

    // Deactivate previous value of same type
    await prisma.caseValue.updateMany({
      where: { caseId: id, valueType, isActive: true },
      data: { isActive: false }
    });

    // Create new value entry
    const caseValue = await prisma.caseValue.create({
      data: {
        id: AuthUtils.generateToken(16),
        caseId: id,
        valueType,
        amount: parseFloat(amount),
        description,
        enteredById: req.user.userId,
        isActive: true
      },
      include: {
        enteredBy: {
          select: {
            id: true,
            name: true,
            email: true
          }
        }
      }
    });

    // Update main case record with latest values
    const updateData = {};
    if (valueType === 'INITIAL_ESTIMATE') updateData.estimatedValue = parseFloat(amount);
    if (valueType === 'DEMAND') updateData.demandAmount = parseFloat(amount);
    if (valueType === 'SETTLEMENT') updateData.settlementAmount = parseFloat(amount);

    if (Object.keys(updateData).length > 0) {
      await prisma.case.update({
        where: { id },
        data: updateData
      });
    }

    const response = APIResponse.created(caseValue, 'Case value added successfully');
    res.status(201).json(response);
  });

  // Get case dashboard/overview with key metrics
  getCaseDashboard = ErrorHandler.asyncHandler(async (req, res) => {
    const { id } = req.params;

    // Get comprehensive case data
    const case_ = await this.model.findUnique({
      where: { id },
      include: {
        ...this.options.include,
        caseStatusHistory: {
          orderBy: { changedAt: 'desc' },
          take: 5,
          include: {
            changedBy: {
              select: { name: true }
            }
          }
        },
        caseDeadlines: {
          where: { completed: false },
          orderBy: { dueDate: 'asc' },
          take: 5
        },
        caseValues: {
          where: { isActive: true },
          orderBy: { date: 'desc' }
        },
        communications: {
          orderBy: { dateTime: 'desc' },
          take: 5,
          select: {
            id: true,
            type: true,
            subject: true,
            dateTime: true
          }
        },
        tasks: {
          where: { status: { not: 'COMPLETED' } },
          orderBy: { dueDate: 'asc' },
          take: 5,
          select: {
            id: true,
            title: true,
            dueDate: true,
            priority: true,
            status: true
          }
        },
        timeEntries: {
          orderBy: { date: 'desc' },
          take: 10,
          select: {
            id: true,
            description: true,
            hours: true,
            date: true,
            user: {
              select: { name: true }
            }
          }
        }
      }
    });

    if (!case_) {
      const response = APIResponse.notFound('Case', id);
      return res.status(404).json(response);
    }

    // Calculate key metrics
    const [totalTimeEntries, totalExpenses, documentCount, communicationCount] = await Promise.all([
      prisma.timeEntry.aggregate({
        where: { caseId: id },
        _sum: { hours: true, amount: true }
      }),
      prisma.expense.aggregate({
        where: { caseId: id },
        _sum: { amount: true }
      }),
      prisma.document.count({ where: { caseId: id } }),
      prisma.communication.count({ where: { caseId: id } })
    ]);

    const dashboard = {
      case: case_,
      metrics: {
        totalHours: totalTimeEntries._sum.hours || 0,
        totalBilled: totalTimeEntries._sum.amount || 0,
        totalExpenses: totalExpenses._sum.amount || 0,
        documentCount,
        communicationCount,
        daysOpen: Math.floor((new Date() - case_.dateOpened) / (1000 * 60 * 60 * 24))
      }
    };

    const response = APIResponse.success(dashboard, 'Case dashboard retrieved successfully');
    res.json(response);
  });

  // Get case statistics overview for reporting
  getCaseStats = ErrorHandler.asyncHandler(async (req, res) => {
    const { dateFrom, dateTo, attorneyId, type, status } = req.query;

    let where = {};
    if (attorneyId) where.attorneyId = attorneyId;
    if (type) where.type = type;
    if (status) where.status = status;
    if (dateFrom || dateTo) {
      where.dateOpened = {};
      if (dateFrom) where.dateOpened.gte = new Date(dateFrom);
      if (dateTo) where.dateOpened.lte = new Date(dateTo);
    }

    const [
      totalCases,
      activeCases,
      closedCases,
      byStatus,
      byType,
      byPriority,
      byStage,
      avgTimeToClose,
      totalSettlements,
      upcomingDeadlines
    ] = await Promise.all([
      prisma.case.count({ where }),
      prisma.case.count({ where: { ...where, isActive: true } }),
      prisma.case.count({ where: { ...where, status: 'CLOSED' } }),
      prisma.case.groupBy({
        by: ['status'],
        where,
        _count: { id: true }
      }),
      prisma.case.groupBy({
        by: ['type'],
        where,
        _count: { id: true }
      }),
      prisma.case.groupBy({
        by: ['priority'],
        where,
        _count: { id: true }
      }),
      prisma.case.groupBy({
        by: ['stage'],
        where,
        _count: { id: true }
      }),
      prisma.case.aggregate({
        where: { ...where, dateClosed: { not: null } },
        _avg: {
          // This would need a computed field for days between open and closed
        }
      }),
      prisma.case.aggregate({
        where: { ...where, settlementAmount: { not: null } },
        _sum: { settlementAmount: true },
        _avg: { settlementAmount: true },
        _count: { settlementAmount: true }
      }),
      prisma.caseDeadline.count({
        where: {
          case: where,
          completed: false,
          dueDate: { gte: new Date(), lte: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000) }
        }
      })
    ]);

    const stats = {
      summary: {
        totalCases,
        activeCases,
        closedCases,
        upcomingDeadlines
      },
      distributions: {
        byStatus: byStatus.reduce((acc, item) => {
          acc[item.status] = item._count.id;
          return acc;
        }, {}),
        byType: byType.reduce((acc, item) => {
          acc[item.type] = item._count.id;
          return acc;
        }, {}),
        byPriority: byPriority.reduce((acc, item) => {
          acc[item.priority] = item._count.id;
          return acc;
        }, {}),
        byStage: byStage.reduce((acc, item) => {
          acc[item.stage] = item._count.id;
          return acc;
        }, {})
      },
      settlements: {
        totalAmount: totalSettlements._sum.settlementAmount || 0,
        averageAmount: totalSettlements._avg.settlementAmount || 0,
        count: totalSettlements._count.settlementAmount || 0
      }
    };

    const response = APIResponse.success(stats, 'Case statistics retrieved successfully');
    res.json(response);
  });

  // Method aliases for route compatibility
  getCases = this.getAll;
  createCase = this.create;
  getCaseById = this.getById;
  updateCase = this.update;
  deleteCase = this.delete;

  // Additional case-specific methods
  updateCaseStatus = ErrorHandler.asyncHandler(async (req, res) => {
    const { id } = req.params;
    const { status } = req.body;

    if (!status) {
      throw new APIError('Status is required', 400);
    }

    const existingCase = await this.model.findUnique({ where: { id } });
    if (!existingCase) {
      const response = APIResponse.notFound('Case', id);
      return res.status(404).json(response);
    }

    this.checkOwnership(existingCase, req.user);

    const updatedCase = await this.model.update({
      where: { id },
      data: { status },
      include: this.include
    });

    const response = APIResponse.success(updatedCase, 'Case status updated successfully');
    res.json(response);
  });

  getCaseTimeline = ErrorHandler.asyncHandler(async (req, res) => {
    const { id } = req.params;

    const case_ = await this.model.findUnique({ where: { id } });
    if (!case_) {
      const response = APIResponse.notFound('Case', id);
      return res.status(404).json(response);
    }

    this.checkOwnership(case_, req.user);

    const timeline = [
      {
        type: 'case_created',
        date: case_.createdAt,
        title: 'Case Created',
        description: `Case ${case_.caseNumber} was created`
      }
    ];

    const response = APIResponse.success(timeline, 'Case timeline retrieved successfully');
    res.json(response);
  });

  recordSettlement = ErrorHandler.asyncHandler(async (req, res) => {
    const { id: caseId } = req.params;
    const settlementData = req.body;

    const case_ = await this.model.findUnique({ where: { id: caseId } });
    if (!case_) {
      const response = APIResponse.notFound('Case', caseId);
      return res.status(404).json(response);
    }

    this.checkOwnership(case_, req.user);

    const settlement = await prisma.settlement.create({
      data: {
        ...settlementData,
        caseId
      }
    });

    const response = APIResponse.success(settlement, 'Settlement recorded successfully', { statusCode: 201 });
    res.status(201).json(response);
  });
}

module.exports = new CaseController();