const express = require('express');
const cors = require('cors');
const jwt = require('jsonwebtoken');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3001;

// CORS configuration
app.use(cors({
  origin: true,
  credentials: true
}));

app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));

// Request logging
app.use((req, res, next) => {
  console.log(`${new Date().toISOString()} - ${req.method} ${req.path}`);
  next();
});

// Health check
app.get('/health', (req, res) => {
  res.json({
    status: 'healthy',
    timestamp: new Date().toISOString(),
    environment: process.env.NODE_ENV || 'demo',
    version: '1.0.0-demo'
  });
});

// Root endpoint
app.get('/', (req, res) => {
  res.json({
    message: 'Legal Estate Demo API',
    status: 'Running',
    version: '1.0.0-demo',
    demoMode: true,
    endpoints: {
      health: '/health',
      api: '/api',
      auth: '/api/auth/login'
    }
  });
});

// API root
app.get('/api', (req, res) => {
  res.json({
    message: 'Legal Estate Demo API',
    status: 'Running',
    version: '1.0.0-demo',
    packageType: 'demo',
    endpoints: {
      health: '/health',
      auth: '/api/auth',
      users: '/api/users',
      cases: '/api/cases',
      documents: '/api/documents'
    },
    demoMode: true,
    resetTime: '03:00 UTC',
    demoCredentials: {
      admin: 'demo@legalestate.tech / demo123',
      user: 'user@legalestate.tech / user123'
    }
  });
});

// Authentication endpoint
app.post('/api/auth/login', async (req, res) => {
  const { email, password } = req.body;

  // Demo credentials
  const demoUsers = [
    {
      email: 'demo@legalestate.tech',
      password: 'demo123',
      firstName: 'Demo',
      lastName: 'Admin',
      role: 'admin',
      id: '1'
    },
    {
      email: 'user@legalestate.tech',
      password: 'user123',
      firstName: 'User',
      lastName: 'Demo',
      role: 'user',
      id: '2'
    }
  ];

  const user = demoUsers.find(u => u.email === email && u.password === password);

  if (user) {
    const token = jwt.sign(
      { id: user.id, email: user.email, role: user.role },
      process.env.JWT_SECRET || 'demo-secret-key',
      { expiresIn: '24h' }
    );

    res.json({
      success: true,
      token: token,
      user: {
        id: user.id,
        email: user.email,
        firstName: user.firstName,
        lastName: user.lastName,
        role: user.role
      },
      message: 'Demo login successful'
    });
  } else {
    res.status(401).json({
      success: false,
      message: 'Invalid demo credentials. Use demo@legalestate.tech / demo123'
    });
  }
});

// Demo user profile
app.get('/api/users/profile', (req, res) => {
  res.json({
    id: '1',
    email: 'demo@legalestate.tech',
    firstName: 'Demo',
    lastName: 'User',
    role: 'admin',
    createdAt: new Date().toISOString()
  });
});

// Demo cases
app.get('/api/cases', (req, res) => {
  res.json({
    success: true,
    cases: [
      {
        id: '1',
        caseNumber: 'DEMO-2024-001',
        title: 'Sample Personal Injury Case',
        status: 'active',
        priority: 'high',
        clientName: 'John Doe',
        createdAt: '2024-01-15T10:00:00Z'
      },
      {
        id: '2',
        caseNumber: 'DEMO-2024-002',
        title: 'Sample Contract Dispute',
        status: 'pending',
        priority: 'medium',
        clientName: 'Jane Smith',
        createdAt: '2024-02-20T14:30:00Z'
      },
      {
        id: '3',
        caseNumber: 'DEMO-2024-003',
        title: 'Sample Real Estate Transaction',
        status: 'closed',
        priority: 'low',
        clientName: 'Robert Johnson',
        createdAt: '2024-03-10T09:15:00Z'
      }
    ],
    total: 3
  });
});

// Demo documents
app.get('/api/documents', (req, res) => {
  res.json({
    success: true,
    documents: [
      {
        id: '1',
        name: 'Sample Contract.pdf',
        type: 'contract',
        size: 245000,
        caseId: '1',
        uploadedAt: '2024-03-01T09:15:00Z'
      },
      {
        id: '2',
        name: 'Legal Brief.docx',
        type: 'brief',
        size: 180000,
        caseId: '2',
        uploadedAt: '2024-03-05T11:45:00Z'
      },
      {
        id: '3',
        name: 'Evidence Photos.zip',
        type: 'evidence',
        size: 5420000,
        caseId: '1',
        uploadedAt: '2024-03-08T14:20:00Z'
      }
    ],
    total: 3
  });
});

// Demo dashboard stats
app.get('/api/dashboard', (req, res) => {
  res.json({
    stats: {
      totalCases: 12,
      activeCases: 8,
      totalClients: 45,
      totalDocuments: 234,
      upcomingDeadlines: 5,
      recentActivities: [
        {
          id: '1',
          type: 'case_created',
          description: 'New case created: DEMO-2024-004',
          timestamp: new Date(Date.now() - 3600000).toISOString()
        },
        {
          id: '2',
          type: 'document_uploaded',
          description: 'Document uploaded: Settlement Agreement.pdf',
          timestamp: new Date(Date.now() - 7200000).toISOString()
        },
        {
          id: '3',
          type: 'case_updated',
          description: 'Case status updated: DEMO-2024-002',
          timestamp: new Date(Date.now() - 10800000).toISOString()
        }
      ]
    }
  });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({
    success: false,
    message: 'Endpoint not found',
    path: req.path
  });
});

// Error handler
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({
    success: false,
    message: 'Internal server error',
    error: process.env.NODE_ENV === 'development' ? err.message : undefined
  });
});

// Start server
app.listen(PORT, '0.0.0.0', () => {
  console.log(`
╔═══════════════════════════════════════════════════════════════╗
║           Legal Estate Demo Backend Server                    ║
╠═══════════════════════════════════════════════════════════════╣
║  Status:      Running                                         ║
║  Port:        ${PORT}                                            ║
║  Environment: ${process.env.NODE_ENV || 'demo'}                              ║
║  API URL:     http://localhost:${PORT}/api                       ║
║  Health:      http://localhost:${PORT}/health                    ║
║                                                               ║
║  Demo Mode:   ENABLED                                         ║
║  Reset Time:  Daily at 03:00 UTC                             ║
║                                                               ║
║  Demo Credentials:                                           ║
║  Admin: demo@legalestate.tech / demo123                      ║
║  User:  user@legalestate.tech / user123                      ║
╚═══════════════════════════════════════════════════════════════╝
  `);
});

module.exports = app;