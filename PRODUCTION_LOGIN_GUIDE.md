# Production Login Guide

## ✅ Login Status: WORKING

All production authentication has been verified and is functioning correctly.

## Production Accounts

### 🔑 System Administrator
- **Email:** admin@legalestate.tech
- **Password:** admin123
- **Role:** SUPER_ADMIN
- **Access:** Full system access, user management, configuration

### 👨‍⚖️ Attorney Account
- **Email:** attorney@legalestate.tech
- **Password:** attorney123
- **Role:** ADMIN
- **Access:** Case management, client management, documents

### 👩‍💼 Paralegal Account
- **Email:** paralegal@legalestate.tech
- **Password:** paralegal123
- **Role:** PARALEGAL
- **Access:** Case assistance, document preparation, client communication

### 👤 Client Account
- **Email:** client@legalestate.tech
- **Password:** client123
- **Role:** CLIENT
- **Access:** View own cases, documents, communication

## Login URLs

### Production Mode
- Admin/Staff Login: https://legalestate.tech/admin/login
- Client Portal: https://legalestate.tech/client/login

### Demo Mode
- Demo Login: https://legalestate.tech/login
- Shows demo credentials prominently

## API Endpoints

### Authentication
- **Login:** POST /api/auth/login
  ```json
  {
    "email": "admin@legalestate.tech",
    "password": "admin123"
  }
  ```

- **Verify Token:** GET /api/auth/verify
  - Headers: `Authorization: Bearer <token>`

- **Logout:** POST /api/auth/logout

## Testing Production Login

### 1. Quick Test Script
```bash
/var/www/html/scripts/verify-production-login.sh
```

### 2. Manual Test
```bash
curl -X POST http://localhost:3001/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@legalestate.tech","password":"admin123"}'
```

### 3. Browser Test
1. Navigate to https://legalestate.tech/admin/login
2. Enter credentials
3. Verify successful login and redirect to dashboard

## Troubleshooting

### Login Issues Fixed
- ✅ Password hashing properly configured (bcrypt with salt rounds 10)
- ✅ Database User table properly structured
- ✅ JWT token generation working
- ✅ CORS configuration allows authentication
- ✅ Frontend API calls properly configured

### If Login Fails
1. Check backend is running: `systemctl status legal-estate-backend`
2. Verify database connection: `psql -U legalestate_admin -d legal_estate`
3. Reset user password: `node /var/www/html/backend/scripts/reset-admin-password.js`
4. Check logs: `tail -f /var/www/html/logs/backend.log`

## Security Recommendations

### For Production Deployment
1. **Change all default passwords immediately**
2. **Enable 2FA for admin accounts**
3. **Set strong JWT secret in .env**
4. **Configure SSL/TLS properly**
5. **Enable rate limiting on auth endpoints**
6. **Set up audit logging**
7. **Configure session timeout**
8. **Enable CSRF protection**

### Password Policy
- Minimum 8 characters
- Include uppercase, lowercase, numbers, special characters
- Enforce password rotation every 90 days
- Prevent password reuse (last 5 passwords)

## Scripts Available

### User Management
- **Create Users:** `/var/www/html/backend/scripts/create-production-users.js`
- **Reset Password:** `/var/www/html/backend/scripts/reset-admin-password.js`
- **Verify Logins:** `/var/www/html/scripts/verify-production-login.sh`

### System Management
- **Enable Production:** `/var/www/html/scripts/enable-production.sh`
- **Check Status:** `/var/www/html/scripts/manage-production.sh status`

## Environment Variables

Ensure these are set in production:

```env
NODE_ENV=production
JWT_SECRET=<secure-random-string-min-32-chars>
SESSION_SECRET=<secure-random-string-min-32-chars>
DATABASE_URL=postgresql://user:pass@host:5432/legal_estate
FRONTEND_URL=https://legalestate.tech
```

## Monitoring

### Health Check Endpoints
- Backend Health: GET /api/health
- Auth Status: GET /api/auth/status
- Database Status: GET /api/monitoring/database

### Log Files
- Authentication logs: `/var/www/html/logs/auth.log`
- Error logs: `/var/www/html/logs/error.log`
- Access logs: `/var/log/nginx/access.log`

## Support

For login issues or questions:
- Email: support@legalestate.tech
- Documentation: https://docs.legalestate.tech
- System Status: https://status.legalestate.tech