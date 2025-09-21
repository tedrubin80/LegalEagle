# LegalEstate.tech Production Credentials

## Database Credentials
- **Database User**: legalestate_admin
- **Database Password**: LegalTechSecure2024
- **Database Name**: legal_estate
- **Connection String**: postgresql://legalestate_admin:LegalTechSecure2024@localhost:5432/legal_estate

## Application Users

### Admin Access
- **Email**: admin@legalestate.tech
- **Password**: AdminLegalTech2024
- **Role**: SUPER_ADMIN
- **User ID**: ce7cadbe0f01fcdc79a0138a826d5969

### Client Portal Access  
- **Email**: client@legalestate.tech
- **Password**: ClientLegalTech2024
- **Role**: CLIENT
- **User ID**: test-user-id

## Server Configuration
- **Backend Port**: 3002
- **Environment**: production
- **Domain**: legalestate.tech
- **API Base URL**: https://legalestate.tech/api
- **Frontend URL**: https://legalestate.tech

## JWT & Session Secrets
- **JWT Secret**: legalestate_tech_prod_jwt_2024_ultra_secure_key_v1
- **Session Secret**: legalestate_tech_prod_session_2024_ultra_secure_key_v1

## SSL Configuration
- **Certificate**: /etc/letsencrypt/live/legalestate.tech/fullchain.pem
- **Private Key**: /etc/letsencrypt/live/legalestate.tech/privkey.pem

## Backup Information
- **Database Backup**: legal_estate_db_backup_20250829-232208.sql
- **Website Backup**: legalestate_website_backup_20250829-232227.tar.gz
- **Backup Locations**: 
  - /home/legalftp/backups/
  - /mnt/backups/
  - /home/legalftp/ftp/

## Beta Testing Configuration

**✅ Rate Limiting (Updated for Beta Testing):**
- **Auth Endpoints**: 20 attempts per 5 minutes (was 5 per 15 minutes)
- **Global Rate Limit**: 2000 requests per 10 minutes (was 1000 per 15 minutes)
- **Reset Method**: Server restart clears all rate limiting

**✅ Backend Endpoints (Proper Production Setup):**
- `/api/auth/admin/login` - For admin users only (SUPER_ADMIN, ADMIN, ATTORNEY, PARALEGAL, STAFF)
- `/api/auth/client/login` - For client users only (CLIENT role)
- `/api/auth/verify` - Token verification endpoint (works for both)

**✅ Testing Status:**
- Admin Login: ✅ Working perfectly (admin@legalestate.tech)
- Client Login: ✅ Working perfectly (client@legalestate.tech) 
- Admin Endpoint Security: ✅ Properly blocks CLIENT role users
- Client Endpoint Security: ✅ Only allows CLIENT role users
- Token Verification: ✅ Working for both admin and client tokens
- Frontend: ✅ Updated and deployed with correct endpoint routing

## Production URLs

**🌐 Live Website:** https://legalestate.tech
**🔐 Admin Portal:** https://legalestate.tech/admin/login  
**👤 Client Portal:** https://legalestate.tech/client/login
**📊 API Health:** https://legalestate.tech/api/health
**📝 API Documentation:** https://legalestate.tech/api-docs (Swagger UI)

## Server Status
- **Backend**: Running on port 3002 (production mode)
- **Frontend**: Built and deployed via nginx
- **Database**: PostgreSQL with production credentials
- **SSL**: Valid Let's Encrypt certificates
- **Environment**: Production with beta-friendly rate limits

---
*Created: August 29, 2025*
*Environment: Production (Beta Testing Ready)*
*Last Updated: August 29, 2025 23:47 UTC*
*Status: FULLY OPERATIONAL - Ready for beta testing*