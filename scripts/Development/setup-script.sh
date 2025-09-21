#!/bin/bash
# Legal Software - Complete Setup Script
# This script sets up the entire development environment

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_step() {
    echo -e "${BLUE}==>${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}!${NC} $1"
}

# Header
echo -e "${BLUE}╔══════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     Legal Software Setup Script          ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════╝${NC}"
echo ""

# Check prerequisites
print_step "Checking prerequisites..."

# Node.js check
if ! command -v node &> /dev/null; then
    print_error "Node.js is not installed!"
    echo "Please install Node.js 18 or higher from https://nodejs.org"
    exit 1
fi

NODE_VERSION=$(node -v | cut -d 'v' -f 2 | cut -d '.' -f 1)
if [ "$NODE_VERSION" -lt 18 ]; then
    print_error "Node.js version 18 or higher is required (found: $(node -v))"
    exit 1
fi
print_success "Node.js $(node -v) found"

# npm check
if ! command -v npm &> /dev/null; then
    print_error "npm is not installed!"
    exit 1
fi
print_success "npm $(npm -v) found"

# Docker check (optional)
if command -v docker &> /dev/null; then
    print_success "Docker found (optional)"
else
    print_warning "Docker not found - Docker deployment will not be available"
fi

# Create directory structure
print_step "Creating directory structure..."
mkdir -p backend/{src/{controllers,middleware,routes,utils,types},prisma,tests,dist}
mkdir -p frontend/{src/{components,services,types,utils,styles},public,build}
mkdir -p scripts/{deployment,database,development,maintenance}
mkdir -p docs/{api,user-guide,development,deployment}
mkdir -p tests/{integration,e2e,fixtures}
print_success "Directory structure created"

# Setup Backend
print_step "Setting up Backend..."
cd backend

# Check if package.json exists
if [ ! -f "package.json" ]; then
    print_step "Initializing backend package.json..."
    npm init -y
    
    # Update package.json
    npm pkg set name="legal-software-backend"
    npm pkg set version="1.0.0"
    npm pkg set description="Legal Practice Management Software - Backend API"
    npm pkg set main="dist/server.js"
    npm pkg set scripts.dev="ts-node-dev --respawn --transpile-only src/server.ts"
    npm pkg set scripts.build="tsc"
    npm pkg set scripts.start="node dist/server.js"
    npm pkg set scripts.test="jest"
    npm pkg set scripts.prisma:generate="prisma generate"
    npm pkg set scripts.prisma:migrate="prisma migrate dev"
    npm pkg set scripts.prisma:studio="prisma studio"
fi

# Install backend dependencies
print_step "Installing backend dependencies..."
npm install express cors helmet morgan compression dotenv bcryptjs jsonwebtoken
npm install @prisma/client express-async-errors express-rate-limit
npm install --save-dev typescript @types/node @types/express @types/cors @types/bcryptjs
npm install --save-dev @types/jsonwebtoken ts-node-dev prisma jest @types/jest ts-jest
npm install --save-dev @types/morgan @types/compression

print_success "Backend dependencies installed"

# Create tsconfig.json if not exists
if [ ! -f "tsconfig.json" ]; then
    print_step "Creating TypeScript configuration..."
    cat > tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "lib": ["ES2020"],
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "moduleResolution": "node",
    "allowJs": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true,
    "declaration": true,
    "declarationMap": true,
    "sourceMap": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist", "tests"]
}
EOF
    print_success "TypeScript configuration created"
fi

# Create .env if not exists
if [ ! -f ".env" ]; then
    print_step "Creating backend .env file..."
    cat > .env << 'EOF'
# Database Configuration
DATABASE_URL="postgresql://neondb_owner:npg_VWySqE6HnUm9@ep-fancy-tooth-a5z610oe-pooler.us-east-2.aws.neon.tech/neondb?sslmode=require"

# JWT Configuration
JWT_SECRET="your-super-secret-jwt-key-change-this-in-production"
JWT_EXPIRES_IN="24h"

# Server Configuration
PORT=3000
NODE_ENV="development"

# Frontend URL (for CORS)
FRONTEND_URL="http://localhost:3000"

# Email Configuration (optional)
SMTP_HOST=""
SMTP_PORT=""
SMTP_USER=""
SMTP_PASS=""
EOF
    print_success "Backend .env file created"
    print_warning "Please update the JWT_SECRET in .env before production use!"
fi

cd ..

# Setup Frontend
print_step "Setting up Frontend..."
cd frontend

# Check if package.json exists
if [ ! -f "package.json" ]; then
    print_step "Initializing frontend package.json..."
    npm init -y
    
    # Update package.json
    npm pkg set name="legal-software-frontend"
    npm pkg set version="1.0.0"
    npm pkg set description="Legal Practice Management Software - Frontend"
    npm pkg set scripts.start="react-scripts start"
    npm pkg set scripts.build="react-scripts build"
    npm pkg set scripts.test="react-scripts test"
    npm pkg set scripts.eject="react-scripts eject"
fi

# Install frontend dependencies
print_step "Installing frontend dependencies..."
npm install react react-dom react-router-dom axios
npm install @types/react @types/react-dom @types/react-router-dom
npm install react-query @tanstack/react-query
npm install react-hook-form yup @hookform/resolvers
npm install react-toastify date-fns
npm install --save-dev typescript react-scripts @types/node

print_success "Frontend dependencies installed"

# Create .env if not exists
if [ ! -f ".env" ]; then
    print_step "Creating frontend .env file..."
    cat > .env << 'EOF'
# API Configuration
REACT_APP_API_URL=http://localhost:3001

# App Configuration
REACT_APP_NAME=Legal Practice Management
REACT_APP_VERSION=1.0.0
EOF
    print_success "Frontend .env file created"
fi

cd ..

# Setup Prisma
print_step "Setting up Prisma..."
cd backend

if [ ! -f "prisma/schema.prisma" ]; then
    print_step "Initializing Prisma..."
    npx prisma init
    
    # Replace the default schema with legal software schema
    cat > prisma/schema.prisma << 'EOF'
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

model User {
  id               String         @id @default(cuid())
  email            String         @unique
  password         String
  firstName        String
  lastName         String
  role             UserRole       @default(PARALEGAL)
  isActive         Boolean        @default(true)
  createdAt        DateTime       @default(now())
  updatedAt        DateTime       @updatedAt
  lastLogin        DateTime?
  
  clients          Client[]       @relation("AttorneyClients")
  casesAsAttorney  Case[]         @relation("CaseAttorney")
  casesAsParalegal Case[]         @relation("CaseParalegal")
  tasks            Task[]
  timeEntries      TimeEntry[]
  documents        Document[]
  activities       Activity[]
  
  @@index([email])
  @@index([role])
}

model Client {
  id               String         @id @default(cuid())
  firstName        String
  lastName         String
  email            String?
  phone            String?
  address          String?
  dateOfBirth      DateTime?
  notes            String?
  attorney         User           @relation("AttorneyClients", fields: [attorneyId], references: [id])
  attorneyId       String
  createdAt        DateTime       @default(now())
  updatedAt        DateTime       @updatedAt
  
  cases            Case[]
  documents        Document[]
  
  @@index([attorneyId])
  @@index([lastName, firstName])
}

model Case {
  id               String         @id @default(cuid())
  caseNumber       String         @unique
  title            String
  description      String?
  type             CaseType
  status           CaseStatus     @default(OPEN)
  priority         Priority       @default(MEDIUM)
  client           Client         @relation(fields: [clientId], references: [id])
  clientId         String
  attorney         User           @relation("CaseAttorney", fields: [attorneyId], references: [id])
  attorneyId       String
  paralegal        User?          @relation("CaseParalegal", fields: [paralegalId], references: [id])
  paralegalId      String?
  openedDate       DateTime       @default(now())
  closedDate       DateTime?
  deadlineDate     DateTime?
  createdAt        DateTime       @default(now())
  updatedAt        DateTime       @updatedAt
  
  tasks            Task[]
  documents        Document[]
  timeEntries      TimeEntry[]
  activities       Activity[]
  
  @@index([caseNumber])
  @@index([clientId])
  @@index([attorneyId])
  @@index([status])
}

model Task {
  id               String         @id @default(cuid())
  title            String
  description      String?
  status           TaskStatus     @default(PENDING)
  priority         Priority       @default(MEDIUM)
  dueDate          DateTime?
  completedDate    DateTime?
  assignedTo       User           @relation(fields: [assignedToId], references: [id])
  assignedToId     String
  case             Case           @relation(fields: [caseId], references: [id])
  caseId           String
  createdAt        DateTime       @default(now())
  updatedAt        DateTime       @updatedAt
  
  @@index([assignedToId])
  @@index([caseId])
  @@index([status])
  @@index([dueDate])
}

model Document {
  id               String         @id @default(cuid())
  title            String
  description      String?
  fileName         String
  fileUrl          String
  fileSize         Int
  mimeType         String
  case             Case?          @relation(fields: [caseId], references: [id])
  caseId           String?
  client           Client?        @relation(fields: [clientId], references: [id])
  clientId         String?
  uploadedBy       User           @relation(fields: [uploadedById], references: [id])
  uploadedById     String
  createdAt        DateTime       @default(now())
  updatedAt        DateTime       @updatedAt
  
  @@index([caseId])
  @@index([clientId])
  @@index([uploadedById])
}

model TimeEntry {
  id               String         @id @default(cuid())
  description      String
  hours            Float
  rate             Float
  date             DateTime
  billable         Boolean        @default(true)
  billed           Boolean        @default(false)
  user             User           @relation(fields: [userId], references: [id])
  userId           String
  case             Case           @relation(fields: [caseId], references: [id])
  caseId           String
  createdAt        DateTime       @default(now())
  updatedAt        DateTime       @updatedAt
  
  @@index([userId])
  @@index([caseId])
  @@index([date])
  @@index([billed])
}

model Activity {
  id               String         @id @default(cuid())
  type             ActivityType
  description      String
  metadata         Json?
  user             User           @relation(fields: [userId], references: [id])
  userId           String
  case             Case?          @relation(fields: [caseId], references: [id])
  caseId           String?
  ipAddress        String?
  userAgent        String?
  createdAt        DateTime       @default(now())
  
  @@index([userId])
  @@index([caseId])
  @@index([type])
  @@index([createdAt])
}

enum UserRole {
  ADMIN
  ATTORNEY
  PARALEGAL
  SECRETARY
}

enum CaseType {
  CRIMINAL
  CIVIL
  FAMILY
  CORPORATE
  REAL_ESTATE
  IMMIGRATION
  BANKRUPTCY
  PERSONAL_INJURY
  OTHER
}

enum CaseStatus {
  OPEN
  IN_PROGRESS
  ON_HOLD
  CLOSED
  ARCHIVED
}

enum TaskStatus {
  PENDING
  IN_PROGRESS
  COMPLETED
  CANCELLED
}

enum Priority {
  LOW
  MEDIUM
  HIGH
  URGENT
}

enum ActivityType {
  USER_LOGIN
  USER_LOGOUT
  CASE_CREATED
  CASE_UPDATED
  CASE_CLOSED
  CLIENT_CREATED
  CLIENT_UPDATED
  DOCUMENT_UPLOADED
  DOCUMENT_DOWNLOADED
  TASK_CREATED
  TASK_COMPLETED
  TIME_ENTRY_CREATED
}
EOF
    print_success "Prisma schema created"
fi

# Generate Prisma client
print_step "Generating Prisma client..."
npx prisma generate
print_success "Prisma client generated"

cd ..

# Create a simple test file
print_step "Creating test files..."
cat > backend/src/server.ts << 'EOF'
import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import morgan from 'morgan';
import compression from 'compression';
import dotenv from 'dotenv';

// Load environment variables
dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(helmet());
app.use(cors({
  origin: process.env.FRONTEND_URL || 'http://localhost:3000',
  credentials: true
}));
app.use(compression());
app.use(morgan('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Health check route
app.get('/health', (req, res) => {
  res.json({ status: 'OK', timestamp: new Date().toISOString() });
});

// Start server
app.listen(PORT, () => {
  console.log(`🚀 Server running on http://localhost:${PORT}`);
  console.log(`📍 Environment: ${process.env.NODE_ENV}`);
});
EOF

print_success "Test server file created"

# Final summary
echo ""
echo -e "${GREEN}╔══════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║       Setup Complete! 🎉                 ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Next Steps:${NC}"
echo "1. Update the DATABASE_URL in backend/.env with your Neon credentials"
echo "2. Run database migrations: cd backend && npm run prisma:migrate"
echo "3. Start the backend: cd backend && npm run dev"
echo "4. Start the frontend: cd frontend && npm start"
echo ""
echo -e "${YELLOW}Quick Commands:${NC}"
echo "  Backend:  cd backend && npm run dev"
echo "  Frontend: cd frontend && npm start"
echo "  Prisma Studio: cd backend && npm run prisma:studio"
echo ""
echo -e "${GREEN}Happy coding! 🚀${NC}"