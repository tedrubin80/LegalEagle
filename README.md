# Legal Estate Demo System

A comprehensive Legal Practice Management System with demo mode functionality, including daily data reset and automated user management.

## 🎭 Demo Features

- **Daily Data Reset**: Automatically resets at 3:00 AM UTC
- **Demo Users**: Pre-configured accounts with sample data
- **Limited Features**: Safe demo environment with restricted functionality
- **Visual Indicators**: Demo banners and watermarks
- **Production Switch**: Can switch to full production mode

## 📦 What's Included

### Core Application
- **Backend**: Node.js/Express API with PostgreSQL
- **Frontend**: React.js application with Tailwind CSS
- **Database**: Prisma ORM with PostgreSQL
- **Authentication**: JWT-based with role management

### Demo System
- **Daily Reset Scripts**: Automated data refresh
- **Demo User Management**: Pre-configured accounts
- **Cron Jobs**: Scheduled maintenance tasks
- **Demo UI Components**: Special demo mode interface

### Scripts & Automation
- **Setup Scripts**: Database initialization and user creation
- **Reset Scripts**: Daily demo data refresh
- **Management Scripts**: Demo system control
- **Production Scripts**: Switch between demo/production modes

## 🚀 Quick Start

### 1. Prerequisites
```bash
# Node.js 18+
node --version

# PostgreSQL 13+
psql --version

# Git
git --version
```

### 2. Installation
```bash
# Clone repository
git clone <repository-url>
cd legal-estate-demo-git

# Install backend dependencies
cd backend
npm install

# Install frontend dependencies
cd ../frontend
npm install
```

### 3. Database Setup
```bash
# Create database
createdb legal_estate

# Run migrations
cd backend
npx prisma migrate deploy

# Seed demo data
node scripts/create-demo-users.js
```

### 4. Environment Configuration
```bash
# Backend environment
cp backend/.env.demo backend/.env

# Frontend environment
cp frontend/.env.demo frontend/.env
```

### 5. Start Services
```bash
# Start backend (terminal 1)
cd backend
npm start

# Start frontend (terminal 2)
cd frontend
npm start
```

### 6. Install Cron Jobs
```bash
# Install demo reset cron job
crontab -e

# Add this line:
0 3 * * * /path/to/scripts/reset-demo.sh >> /var/www/html/logs/demo-reset.log 2>&1
```

## 🔐 Demo Accounts

### Demo Users (Reset Daily)
- **Admin**: demo@legalestate.tech / demo123
- **User**: user@legalestate.tech / user123
- **Client**: client@demo.tech / client123

### Production Users (Persistent)
- **System Admin**: admin@legalestate.tech / admin123
- **Attorney**: attorney@legalestate.tech / attorney123
- **Paralegal**: paralegal@legalestate.tech / paralegal123

## 📁 Project Structure

```
legal-estate-demo-git/
├── backend/                 # Node.js API server
│   ├── src/                 # Source code
│   ├── prisma/              # Database schema & migrations
│   ├── scripts/             # Database & user scripts
│   ├── .env.demo            # Demo environment config
│   ├── .env.production      # Production environment config
│   └── package.json         # Dependencies
├── frontend/                # React application
│   ├── src/                 # React source code
│   ├── public/              # Static assets
│   ├── .env.demo            # Demo frontend config
│   ├── .env.production      # Production frontend config
│   └── package.json         # Dependencies
├── scripts/                 # System management scripts
│   ├── reset-demo.sh        # Daily demo reset
│   ├── manage-demo.sh       # Demo management
│   ├── enable-production.sh # Switch to production
│   └── backup-cron.sh       # System backups
├── docs/                    # Documentation
├── cron-jobs.txt            # Cron job configurations
└── README.md                # This file
```

## 🔧 Management Scripts

### Demo Management
```bash
# Check demo status
./scripts/manage-demo.sh status

# Manual demo reset
./scripts/manage-demo.sh reset

# View demo credentials
./scripts/manage-demo.sh credentials
```

### Production Mode
```bash
# Switch to production mode
sudo ./scripts/enable-production.sh

# Test production readiness
./scripts/test-production-script.sh
```

### User Management
```bash
# Create demo users
node backend/scripts/create-demo-users.js

# Create production users
node backend/scripts/create-production-users.js

# Reset admin password
node backend/scripts/reset-admin-password.js
```

## 🔄 Demo Reset Process

The demo system automatically resets daily at 3:00 AM UTC:

1. **Database Reset**: Clears all user-generated data
2. **User Recreation**: Restores demo accounts
3. **File Cleanup**: Removes uploaded files
4. **Log Rotation**: Archives old logs
5. **Service Restart**: Refreshes application state

## 🏢 Production Mode

Switch to production mode for full functionality:

### Features Enabled in Production
- No data reset
- Full feature set
- No demo UI elements
- Enhanced security
- Production logging

### Switch Process
```bash
# Interactive switch
sudo ./scripts/enable-production.sh

# The script will:
# 1. Backup current demo config
# 2. Switch to production environment
# 3. Disable demo reset cron jobs
# 4. Restart services
# 5. Enable production monitoring
```

## 📊 Monitoring

### Health Checks
- **Backend**: GET /api/health
- **Database**: GET /api/monitoring/database
- **Demo Status**: ./scripts/manage-demo.sh status

### Log Files
- **Demo Reset**: logs/demo-reset.log
- **Backend**: logs/backend.log
- **Frontend**: logs/frontend.log
- **System**: /var/log/nginx/access.log

## 🔐 Security

### Demo Mode Security
- Limited file upload sizes
- Restricted admin functions
- Rate limiting enabled
- Demo data isolation

### Production Mode Security
- Full authentication
- Role-based permissions
- SSL/TLS encryption
- Audit logging

## 📞 Support

- **Documentation**: See docs/ directory
- **Issues**: Report via GitHub issues
- **Email**: support@legalestate.tech

## 📄 License

MIT License - See LICENSE file for details