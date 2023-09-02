#!/bin/bash
######################### Logging setup #########################
LOG_DIR=/var/log/my_script_logs
if ! [ -d "$LOG_DIR" ]; then
  mkdir $LOG_DIR
fi

log() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >> $LOG_DIR/installation.log
}
######################### Logging setup #########################

log "*** Started execution - installation-postgres.sh ***"
# Check if PG_PASSWORD is set
if [ -z "$PG_PASSWORD" ]; then
    echo "Error: PG_PASSWORD environment variable is not set."
    exit 1
fi

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
log "Executing apt-get update."
apt-get update
log "Executing install postgresql-15."
apt install postgresql-15 -y
cd /tmp || exit
log "Setting new password."
sudo -u postgres psql -U postgres -d postgres -c "alter user postgres with password '$PG_PASSWORD';"
log "Adding 2 lines in pg_hba.conf."
echo 'host all all 0.0.0.0/0 md5' >> /etc/postgresql/15/main/pg_hba.conf
echo 'host all all ::0/0 md5' >> /etc/postgresql/15/main/pg_hba.conf
log "Updating postgresql.conf."
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/15/main/postgresql.conf
log "Restarting postgres."
systemctl restart postgresql

log "*** Finished execution - installation-postgres.sh ***"