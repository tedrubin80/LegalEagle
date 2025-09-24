#!/bin/bash

# Nightly Demo Reset Script for Legal Estate Management System
# This script resets demo data every night at 2 AM UTC

echo "Starting nightly demo reset at $(date)"

# Set database connection variables
export PGPASSWORD="LegalTechSecure2024"
DB_HOST="localhost"
DB_USER="legalestate_admin"
DB_NAME="legal_estate"

# Log file
LOG_FILE="/var/log/demo-reset.log"

# Function to log messages
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Function to reset demo data
reset_demo_data() {
    log_message "Resetting demo data..."

    # Connect to database and reset tables
    psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" << EOF
-- Reset user-generated content while preserving demo users
DELETE FROM "Activity" WHERE "createdAt" < NOW() - INTERVAL '1 day';
DELETE FROM "Communication" WHERE "createdAt" < NOW() - INTERVAL '1 day';
DELETE FROM "Task" WHERE "createdAt" < NOW() - INTERVAL '1 day' AND "userId" != 'demo-user-id';
DELETE FROM "TimeEntry" WHERE "createdAt" < NOW() - INTERVAL '1 day';

-- Reset case and client modifications but keep demo data
UPDATE "Case" SET
    "updatedAt" = NOW() - INTERVAL '$(($RANDOM % 7)) days',
    "status" = (ARRAY['ACTIVE', 'DISCOVERY', 'SETTLEMENT'])[floor(random() * 3 + 1)]
WHERE "createdAt" < NOW() - INTERVAL '1 day';

UPDATE "Client" SET
    "updatedAt" = NOW() - INTERVAL '$(($RANDOM % 30)) days'
WHERE "createdAt" < NOW() - INTERVAL '1 day';

-- Clean up temporary files and uploads
DELETE FROM "Document" WHERE "createdAt" < NOW() - INTERVAL '7 days' AND "type" = 'TEMP';

-- Reset demo user sessions
DELETE FROM "Session" WHERE "expiresAt" < NOW();

-- Insert fresh demo activity
INSERT INTO "Activity" ("id", "action", "description", "entityType", "entityId", "userId", "createdAt")
VALUES
    (gen_random_uuid(), 'SYSTEM_RESET', 'Demo environment reset completed', 'SYSTEM', NULL, NULL, NOW());

COMMIT;
EOF

    if [ $? -eq 0 ]; then
        log_message "Demo data reset completed successfully"
    else
        log_message "ERROR: Demo data reset failed"
        return 1
    fi
}

# Function to restart services if needed
restart_services() {
    log_message "Checking service health..."

    # Check if backend is responding
    if ! curl -f http://localhost:3001/api/health > /dev/null 2>&1; then
        log_message "Backend not responding, restarting Docker containers..."
        cd /var/www/demo
        docker compose restart backend
        sleep 10
    fi

    log_message "Services are healthy"
}

# Function to cleanup logs
cleanup_logs() {
    log_message "Cleaning up old log files..."

    # Keep only last 30 days of logs
    find /var/log -name "demo-reset.log.*" -mtime +30 -delete

    # Rotate current log if it's too large (>10MB)
    if [ -f "$LOG_FILE" ] && [ $(stat -c%s "$LOG_FILE") -gt 10485760 ]; then
        mv "$LOG_FILE" "$LOG_FILE.$(date +%Y%m%d_%H%M%S)"
        touch "$LOG_FILE"
    fi
}

# Main execution
main() {
    log_message "=== Starting Nightly Demo Reset ==="

    # Check if we're in demo mode
    if [ "$REACT_APP_DEMO_MODE" != "true" ]; then
        log_message "Not in demo mode, skipping reset"
        exit 0
    fi

    # Perform reset operations
    reset_demo_data
    restart_services
    cleanup_logs

    log_message "=== Nightly Demo Reset Completed ==="
    log_message "Next reset scheduled for tomorrow at 2:00 AM UTC"
}

# Run main function
main "$@"