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

########################### Git setup ############################
log "*** Started execution of config-nginx-jenkins.sh ***"
apt-get install git -y

#Create directory where git repo will be cloned, if not exists.
script_dir=/usr/local/git-repo/scripts
log "Checking whether script_dir($script_dir) exists."
if ! [ -d "$script_dir" ]; then
  log "Creating script_dir"
  mkdir -p $script_dir
else
  log "Found dir script_dir"
fi

#git clone or git pull, depends on repository existence in script_dir
cd script_dir || exit
if [ -d "$script_dir/.git" ]; then
  git restore .
  if git pull; then
    log "Successfully executed git pull inside script_dir."
  else
    log "Failed executing git pull inside script_dir."
  fi
else
    git clone https://github.com/AdarshSinghal/scripts.git "$script_dir"
    log "Successfully executed git clone inside script_dir."
fi
########################### Git setup ############################

# Define source and destination directories
dir1="$SCRIPTS_DIR/server/ubuntu/aws/nginx-config-files"
sites_available="/etc/nginx/sites-available/"
sites_enabled="/etc/nginx/sites-enabled/"
log "Copying all files from $dir1 to $sites_available"
cp "$dir1"/* "$sites_available"
log "Files copied into $sites_available"

# Create symbolic links for copied files

for file in "$sites_available"/*; do
    base_name=$(basename "$file")
    ln -s "$file" "$sites_enabled/$base_name"
    log "Created symbolic link for $base_name in $sites_enabled"
done

removeFile() {
  if [ -e "$1" ]; then
      rm "$1"
      log "Removed $1"
  else
      echo "$1 does not exist"
  fi
}
log "Removing default files"
removeFile "$sites_available/default"
removeFile "$sites_enabled/default"
log "Removed default files"

log "*** Finished execution of config-nginx-jenkins.sh ***"

