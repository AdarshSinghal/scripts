#!/bin/bash
LOG_DIR=/var/log/my_script_logs
LOG_FILE="$LOG_DIR/postgres-installation.log"
if ! [ -d "$LOG_DIR" ]; then
sudo mkdir $LOG_DIR
fi

# Check if PG_PASSWORD is set
if [ -z "$PG_PASSWORD" ]; then
    echo "Error: PG_PASSWORD environment variable is not set."
    exit 1
fi
echo "1. Starting script execution" >> "$LOG_FILE"
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
echo "2. Executing... apt-get update" >> "$LOG_FILE"
sudo apt-get update
echo "3. Executing... install postgresql-15" >> "$LOG_FILE"
apt install postgresql-15 -y
cd /tmp || exit
echo "4. Setting new password..." >> "$LOG_FILE"
sudo -u postgres psql -U postgres -d postgres -c "alter user postgres with password '$PG_PASSWORD';"
echo "5. Completed. Adding 2 lines in pg_hba.conf..." >> "$LOG_FILE"
echo 'host all all 0.0.0.0/0 md5' >> /etc/postgresql/15/main/pg_hba.conf
echo 'host all all ::0/0 md5' >> /etc/postgresql/15/main/pg_hba.conf
echo "6. Completed. - Updating postgresql.conf..." >> "$LOG_FILE"
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/15/main/postgresql.conf
echo "7 - Completed. Restarting postgres..." >> "$LOG_FILE"
sudo systemctl restart postgresql
echo "8 - Completed all steps" >> "$LOG_FILE"