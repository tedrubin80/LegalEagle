// Demo Task Service - Provides mock task data for demo mode
export class DemoTaskService {
  constructor() {
    this.isDemo = process.env.REACT_APP_DEMO_MODE === 'true';
    this.tasks = this.generateMockTasks();
  }

  generateMockTasks() {
    const priorities = ['HIGH', 'MEDIUM', 'LOW'];
    const statuses = ['PENDING', 'IN_PROGRESS', 'COMPLETED'];
    const taskTypes = [
      'Review contract documents',
      'Prepare settlement agreement',
      'Schedule client deposition',
      'File motion with court',
      'Research case precedents',
      'Update case timeline',
      'Coordinate with expert witness',
      'Prepare discovery requests',
      'Review medical records',
      'Draft demand letter',
      'Conduct client interview',
      'Analyze opposing counsel arguments'
    ];

    const tasks = [];
    for (let i = 1; i <= 15; i++) {
      const dueDate = new Date();
      dueDate.setDate(dueDate.getDate() + Math.floor(Math.random() * 30) - 10);

      tasks.push({
        id: `demo-task-${i}`,
        title: taskTypes[Math.floor(Math.random() * taskTypes.length)],
        description: `Demo task description for task ${i}. This includes all necessary details and requirements for completion.`,
        status: statuses[Math.floor(Math.random() * statuses.length)],
        priority: priorities[Math.floor(Math.random() * priorities.length)],
        dueDate: dueDate.toISOString(),
        assignedToId: `demo-user-${Math.floor(Math.random() * 3) + 1}`,
        assignedTo: {
          firstName: ['John', 'Jane', 'Mike'][Math.floor(Math.random() * 3)],
          lastName: ['Smith', 'Johnson', 'Williams'][Math.floor(Math.random() * 3)]
        },
        caseId: `demo-case-${Math.floor(Math.random() * 5) + 1}`,
        case: {
          caseNumber: `CASE-2024-${String(Math.floor(Math.random() * 1000)).padStart(3, '0')}`,
          title: 'Demo Legal Case'
        },
        createdAt: new Date(Date.now() - Math.random() * 30 * 24 * 60 * 60 * 1000).toISOString(),
        updatedAt: new Date().toISOString(),
        isDemo: true
      });
    }

    return tasks;
  }

  async getTasks(params = {}) {
    if (!this.isDemo) {
      throw new Error('Demo Task Service should only be used in demo mode');
    }

    // Simulate API delay
    await new Promise(resolve => setTimeout(resolve, 500));

    let filteredTasks = [...this.tasks];

    // Apply filters
    if (params.status) {
      filteredTasks = filteredTasks.filter(task => task.status === params.status);
    }

    if (params.priority) {
      filteredTasks = filteredTasks.filter(task => task.priority === params.priority);
    }

    if (params.assignedToId) {
      filteredTasks = filteredTasks.filter(task => task.assignedToId === params.assignedToId);
    }

    if (params.search) {
      const searchLower = params.search.toLowerCase();
      filteredTasks = filteredTasks.filter(task =>
        task.title.toLowerCase().includes(searchLower) ||
        task.description.toLowerCase().includes(searchLower)
      );
    }

    if (params.overdue === 'true') {
      const now = new Date();
      filteredTasks = filteredTasks.filter(task =>
        task.dueDate && new Date(task.dueDate) < now && task.status !== 'COMPLETED'
      );
    }

    return {
      success: true,
      data: {
        tasks: filteredTasks,
        total: filteredTasks.length,
        page: 1,
        limit: 50
      }
    };
  }

  async updateTask(taskId, updates) {
    if (!this.isDemo) {
      throw new Error('Demo Task Service should only be used in demo mode');
    }

    // Simulate API delay
    await new Promise(resolve => setTimeout(resolve, 300));

    const taskIndex = this.tasks.findIndex(task => task.id === taskId);
    if (taskIndex === -1) {
      throw new Error('Task not found');
    }

    this.tasks[taskIndex] = {
      ...this.tasks[taskIndex],
      ...updates,
      updatedAt: new Date().toISOString()
    };

    return {
      success: true,
      data: this.tasks[taskIndex]
    };
  }

  async createTask(taskData) {
    if (!this.isDemo) {
      throw new Error('Demo Task Service should only be used in demo mode');
    }

    // Simulate API delay
    await new Promise(resolve => setTimeout(resolve, 400));

    const newTask = {
      id: `demo-task-${Date.now()}`,
      ...taskData,
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
      assignedTo: {
        firstName: 'Demo',
        lastName: 'User'
      },
      case: {
        caseNumber: 'DEMO-CASE-001',
        title: 'Demo Case'
      },
      isDemo: true
    };

    this.tasks.unshift(newTask);

    return {
      success: true,
      data: newTask
    };
  }

  async deleteTask(taskId) {
    if (!this.isDemo) {
      throw new Error('Demo Task Service should only be used in demo mode');
    }

    // Simulate API delay
    await new Promise(resolve => setTimeout(resolve, 300));

    const taskIndex = this.tasks.findIndex(task => task.id === taskId);
    if (taskIndex === -1) {
      throw new Error('Task not found');
    }

    this.tasks.splice(taskIndex, 1);

    return {
      success: true,
      message: 'Task deleted successfully'
    };
  }

  isDemoMode() {
    return this.isDemo;
  }

  getTaskStatistics() {
    const total = this.tasks.length;
    const pending = this.tasks.filter(t => t.status === 'PENDING').length;
    const inProgress = this.tasks.filter(t => t.status === 'IN_PROGRESS').length;
    const completed = this.tasks.filter(t => t.status === 'COMPLETED').length;

    const now = new Date();
    const overdue = this.tasks.filter(t =>
      t.dueDate && new Date(t.dueDate) < now && t.status !== 'COMPLETED'
    ).length;

    return {
      total,
      pending,
      inProgress,
      completed,
      overdue,
      completionRate: total > 0 ? Math.round((completed / total) * 100) : 0
    };
  }
}

export default new DemoTaskService();