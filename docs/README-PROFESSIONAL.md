# Legal Estate Professional Package

The Professional Package is designed for law firms with 2-25 attorneys who need advanced team collaboration, multi-provider AI integration, and comprehensive case management features.

## 📦 Package Overview

### Target Audience
- Small to medium law firms (2-25 attorneys)
- Firms requiring team collaboration
- Practices needing advanced AI capabilities
- Organizations wanting role-based permissions

### Key Features
- **Team Collaboration**: Role-based permissions, task delegation, document sharing
- **Multi-Provider AI**: OpenAI, Anthropic, and Ollama integration with intelligent routing
- **Advanced Case Management**: Team assignments, case permissions, workload distribution
- **Professional Billing**: Time tracking, cost management, client portal
- **Real-time Communication**: Team messaging, notifications, collaboration tools

## 🏗️ Architecture

### Database
- **PostgreSQL**: Production-grade relational database
- **Enhanced Schema**: Team collaboration tables, permissions, AI usage tracking
- **User Limit**: 25 maximum active users

### AI Integration
- **OpenAI**: Premium document generation and analysis
- **Anthropic**: Advanced legal analysis and reasoning
- **Ollama**: Local AI for cost-effective operations
- **Intelligent Routing**: Automatic provider selection based on task type
- **Cost Tracking**: Comprehensive usage and cost monitoring

### Ports
- **Backend**: 3030
- **Frontend**: 3031

## 🚀 Installation

### Prerequisites
- Ubuntu 20.04+ or similar Linux distribution
- VPS or dedicated server (minimum 4GB RAM, 2 vCPU, 40GB SSD)
- Domain name (optional but recommended)
- Email service (for notifications)

### Quick Install
```bash
# Download and run the installer
wget https://github.com/yourusername/legal-estate/raw/main/install-professional.sh
chmod +x install-professional.sh
sudo ./install-professional.sh
```

### Manual Installation

#### 1. System Dependencies
```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install required packages
sudo apt install -y curl wget git build-essential python3 python3-pip \
  postgresql postgresql-contrib nginx certbot python3-certbot-nginx \
  ufw fail2ban htop unzip redis-server

# Install Node.js 18+
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Docker and Docker Compose
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Install Ollama
curl -fsSL https://ollama.ai/install.sh | sh
```

#### 2. Database Setup
```bash
# Create database
sudo -u postgres createuser legalestate_professional
sudo -u postgres createdb legal_estate_professional -O legalestate_professional
sudo -u postgres psql -c "ALTER USER legalestate_professional PASSWORD 'your_secure_password';"
```

#### 3. Application Setup
```bash
# Clone repository
git clone https://github.com/yourusername/legal-estate.git
cd legal-estate

# Checkout Professional branch
git checkout package/professional

# Backend setup
cd backend
cp .env.professional .env

# Update database URL in .env
# DATABASE_URL="postgresql://legalestate_professional:your_password@localhost:5432/legal_estate_professional"

# Install dependencies
npm install

# Generate Prisma client and setup database
npx prisma generate --schema=./prisma/schema.professional.prisma
npx prisma db push --schema=./prisma/schema.professional.prisma

# Frontend setup
cd ../frontend
npm install
npm run build
```

#### 4. AI Models Setup
```bash
# Download Ollama models
ollama pull llama3:8b
ollama pull mistral:7b-instruct
ollama pull codellama:7b
```

#### 5. Service Configuration
```bash
# Create systemd service
sudo tee /etc/systemd/system/legal-estate-professional.service > /dev/null <<EOF
[Unit]
Description=Legal Estate Professional Backend
After=network.target postgresql.service redis.service

[Service]
Type=simple
User=$USER
WorkingDirectory=/path/to/legal-estate/backend
Environment=NODE_ENV=production
ExecStart=/usr/bin/node server-professional.js
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

# Enable and start service
sudo systemctl daemon-reload
sudo systemctl enable legal-estate-professional
sudo systemctl start legal-estate-professional
```

## ⚙️ Configuration

### Environment Variables (.env.professional)

#### Core Settings
```bash
NODE_ENV=production
PORT=3030
PACKAGE_TYPE=PROFESSIONAL
MAX_USERS=25
```

#### Database
```bash
DATABASE_URL="postgresql://user:password@localhost:5432/legal_estate_professional"
```

#### Security
```bash
JWT_SECRET=your_jwt_secret_here
SESSION_SECRET=your_session_secret_here
SESSION_TIMEOUT=28800000  # 8 hours
```

#### AI Providers
```bash
# OpenAI Configuration
OPENAI_API_KEY=your_openai_api_key
OPENAI_MODEL=gpt-4-turbo-preview

# Anthropic Configuration
ANTHROPIC_API_KEY=your_anthropic_api_key
ANTHROPIC_MODEL=claude-3-opus-20240229

# Ollama Configuration
OLLAMA_BASE_URL=http://localhost:11434
OLLAMA_MODEL_GENERAL=mistral:7b-instruct
OLLAMA_MODEL_COMPLEX=llama3:8b
OLLAMA_MODEL_REASONING=llama3:8b

# Provider Priority
AI_PROVIDER_PRIORITY=openai,anthropic,ollama
AI_COST_TRACKING=true
```

#### Team Features
```bash
ENABLE_TEAMS=true
ENABLE_COLLABORATION=true
ENABLE_TASK_DELEGATION=true
ENABLE_DOCUMENT_SHARING=true
ENABLE_TIME_TRACKING=true
ENABLE_BILLING=true
ENABLE_CLIENT_PORTAL=true
```

#### Email Service
```bash
RESEND_API_KEY=your_resend_api_key
FROM_EMAIL=Professional Practice <noreply@yourfirm.com>
ENABLE_EMAIL_NOTIFICATIONS=true
```

#### Cloud Storage (Optional)
```bash
CLOUD_STORAGE_ENABLED=true
CLOUD_STORAGE_PROVIDER=aws
AWS_S3_BUCKET=legal-estate-professional-docs
AWS_REGION=us-east-1
```

## 👥 User Management

### Roles and Permissions

#### SUPER_ADMIN
- Full system access
- User management
- System configuration
- All case and client access

#### ADMIN
- User management (non-admin users)
- Case and client management
- Billing oversight
- Team management

#### ATTORNEY
- Case creation and management
- Client management
- Task assignment
- Document generation
- Billing access

#### PARALEGAL
- Assigned case access
- Document preparation
- Task management
- Limited client interaction

#### ASSISTANT
- Administrative tasks
- Calendar management
- Basic case support
- Document organization

### Adding Team Members

#### Via API
```bash
curl -X POST http://your-domain:3030/api/team/users \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "john.doe@lawfirm.com",
    "name": "John Doe",
    "firstName": "John",
    "lastName": "Doe",
    "role": "ATTORNEY",
    "department": "Litigation",
    "title": "Senior Associate",
    "phone": "+1-555-0123"
  }'
```

#### Via Admin Interface
1. Login as SUPER_ADMIN or ADMIN
2. Navigate to Team Management
3. Click "Add Team Member"
4. Fill in user details
5. Assign role and permissions
6. Send invitation email

## 🤖 AI Integration

### Provider Selection Strategy

#### Automatic Routing
- **Legal Analysis**: Anthropic (Claude) preferred for legal reasoning
- **Document Generation**: OpenAI (GPT-4) preferred for structured output
- **Case Summaries**: Ollama (local) for cost efficiency
- **General Queries**: Follow priority order

#### Manual Provider Selection
```javascript
// Force specific provider
const result = await fetch('/api/ai-professional/chat', {
  method: 'POST',
  headers: {
    'Authorization': `Bearer ${token}`,
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    message: "Analyze this contract",
    provider: "anthropic"  // Force Anthropic
  })
});
```

### AI Features

#### Document Analysis
```bash
curl -X POST http://your-domain:3030/api/ai-professional/analyze-document \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "content": "Document content here...",
    "analysisType": "contract"
  }'
```

#### Case Summary Generation
```bash
curl -X POST http://your-domain:3030/api/ai-professional/generate-case-summary \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "caseId": "case_id_here",
    "summaryType": "executive"
  }'
```

#### Document Generation
```bash
curl -X POST http://your-domain:3030/api/ai-professional/generate-document \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "documentType": "demand_letter",
    "parameters": {
      "clientName": "John Smith",
      "incidentDate": "2024-01-15",
      "demandAmount": "$50000"
    }
  }'
```

### Cost Management

#### Usage Monitoring
- Real-time cost tracking
- Provider-specific usage statistics
- Request type breakdown
- Monthly/weekly reports

#### Cost Optimization
- Automatic provider selection based on cost
- Local model prioritization for simple tasks
- Usage alerts and limits
- Detailed billing reports

## 👥 Team Collaboration

### Case Team Management

#### Assigning Team Members
```bash
curl -X POST http://your-domain:3030/api/team/assignments \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "caseId": "case_id_here",
    "userId": "user_id_here",
    "role": "member",
    "permissions": ["READ", "WRITE", "SHARE"]
  }'
```

#### Workload Analytics
- Active case distribution
- Task assignments per user
- Overdue task tracking
- Workload balancing recommendations

### Document Sharing

#### Permission Levels
- **READ**: View documents
- **WRITE**: Edit documents
- **SHARE**: Share with others
- **DELETE**: Remove documents
- **ADMIN**: Full document control

#### Collaboration Features
- Real-time document editing
- Comment threads
- Version history
- Change notifications

### Communication Tools

#### Team Messaging
- Direct messages
- Group channels
- Case-specific discussions
- File sharing in conversations

#### Notifications
- Real-time alerts
- Email summaries
- Task reminders
- Deadline notifications

## 📊 Reporting and Analytics

### Team Performance
- Case resolution times
- Billable hours per user
- Task completion rates
- Client satisfaction metrics

### Financial Reports
- Revenue by attorney
- Cost per case analysis
- AI usage costs
- Billing efficiency

### Operational Insights
- Case pipeline analysis
- Resource utilization
- Collaboration patterns
- System usage statistics

## 🔧 Administration

### System Monitoring

#### Health Checks
```bash
# Overall system health
curl http://your-domain:3030/api/health

# AI providers status
curl -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  http://your-domain:3030/api/ai-professional/health
```

#### Log Monitoring
```bash
# Application logs
sudo journalctl -u legal-estate-professional -f

# Nginx logs
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log

# Database logs
sudo tail -f /var/log/postgresql/postgresql-*.log
```

### Backup and Recovery

#### Automated Backups
- Daily database backups
- File system snapshots
- Configuration backups
- Cloud storage integration

#### Manual Backup
```bash
# Database backup
pg_dump -h localhost -U legalestate_professional legal_estate_professional > backup.sql

# File backup
tar -czf files_backup.tar.gz /path/to/legal-estate/backend/uploads/

# Configuration backup
cp /path/to/legal-estate/backend/.env config_backup.env
```

### Security Configuration

#### Firewall Setup
```bash
sudo ufw enable
sudo ufw allow ssh
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 3030/tcp  # Backend
sudo ufw allow 3031/tcp  # Frontend
```

#### SSL Configuration
```bash
# Obtain SSL certificate
sudo certbot --nginx -d your-domain.com

# Auto-renewal
sudo crontab -e
# Add: 0 12 * * * /usr/bin/certbot renew --quiet
```

## 📈 Scaling and Performance

### Recommended Infrastructure

#### Small Firm (2-5 users)
- **VPS**: 4GB RAM, 2 vCPU, 80GB SSD
- **Database**: PostgreSQL on same server
- **AI**: Ollama local + occasional cloud

#### Medium Firm (6-15 users)
- **VPS**: 8GB RAM, 4 vCPU, 160GB SSD
- **Database**: Dedicated PostgreSQL server
- **AI**: Balanced cloud and local usage

#### Large Firm (16-25 users)
- **Server**: 16GB RAM, 8 vCPU, 320GB SSD
- **Database**: High-performance PostgreSQL
- **AI**: Primarily cloud providers with local backup

### Performance Optimization

#### Database Optimization
```sql
-- Index optimization
CREATE INDEX CONCURRENTLY idx_cases_team_assignment ON cases(assigned_team_id);
CREATE INDEX CONCURRENTLY idx_users_department ON users(department);
CREATE INDEX CONCURRENTLY idx_team_members_case ON case_team_members(case_id);
```

#### Caching Strategy
- Redis for session storage
- Database query caching
- AI response caching
- File system caching

## 🛠️ Troubleshooting

### Common Issues

#### User Limit Exceeded
```bash
# Check current user count
curl -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  http://your-domain:3030/api/team/config

# Deactivate unused users
curl -X PUT -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  http://your-domain:3030/api/team/users/USER_ID \
  -d '{"isActive": false}'
```

#### AI Provider Issues
```bash
# Check provider health
curl -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  http://your-domain:3030/api/ai-professional/health

# Test specific provider
curl -X POST -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  http://your-domain:3030/api/ai-professional/chat \
  -d '{"message": "test", "provider": "ollama"}'
```

#### Database Connection Issues
```bash
# Check PostgreSQL status
sudo systemctl status postgresql

# Test connection
psql -h localhost -U legalestate_professional -d legal_estate_professional -c "SELECT version();"

# Check connection limits
psql -h localhost -U legalestate_professional -d legal_estate_professional \
  -c "SELECT count(*) FROM pg_stat_activity;"
```

### Log Analysis

#### Application Errors
```bash
# Recent errors
sudo journalctl -u legal-estate-professional --since "1 hour ago" | grep ERROR

# AI service errors
grep "AI.*error" /var/log/legal-estate/application.log

# Team operation errors
grep "team.*error" /var/log/legal-estate/application.log
```

#### Performance Issues
```bash
# High CPU usage
top -p $(pgrep -f legal-estate-professional)

# Memory usage
ps aux | grep legal-estate-professional

# Database performance
sudo -u postgres psql -d legal_estate_professional \
  -c "SELECT query, calls, total_time, mean_time FROM pg_stat_statements ORDER BY total_time DESC LIMIT 10;"
```

## 🔄 Updates and Maintenance

### Update Process
```bash
# Stop service
sudo systemctl stop legal-estate-professional

# Backup current version
cp -r /path/to/legal-estate /path/to/legal-estate-backup

# Pull updates
cd /path/to/legal-estate
git pull origin package/professional

# Update dependencies
cd backend && npm install
cd ../frontend && npm install && npm run build

# Run migrations if needed
cd ../backend
npx prisma migrate deploy --schema=./prisma/schema.professional.prisma

# Restart service
sudo systemctl start legal-estate-professional
```

### Maintenance Schedule
- **Daily**: Automated backups, log rotation
- **Weekly**: System updates, performance monitoring
- **Monthly**: Security patches, capacity planning
- **Quarterly**: Full system review, disaster recovery testing

## 📞 Support

### Professional Package Support
- **Email**: professional-support@legalestate.tech
- **Documentation**: https://docs.legalestate.tech/professional
- **Community**: https://community.legalestate.tech
- **Premium Support**: Available for enterprise customers

### Training Resources
- **Video Tutorials**: Team management, AI features
- **Webinars**: Monthly training sessions
- **Documentation**: Comprehensive user guides
- **One-on-one**: Available for new implementations

## 📄 License

The Professional Package includes:
- Commercial license for up to 25 users
- Priority support
- Advanced features access
- Regular updates and security patches

For licensing inquiries: licensing@legalestate.tech

---

**Legal Estate Professional Package** - Empowering law firms with advanced collaboration and AI-driven legal technology.