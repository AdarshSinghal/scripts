#!/bin/sh

#Log setup
LOG_FILE=$DEPLOYMENT_DIR/deployment.log
rm "$LOG_FILE"
sleep 1s
log() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $1"
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >> $LOG_FILE
}


#Common Variables
APP_DIR=/var/www/nnt-fe
DEPLOYMENT_DIR=$APP_DIR/_deployments
BACKUP_DIR=$DEPLOYMENT_DIR/old_deployments/$(date +'%Y-%m-%d-%H-%M-%S')
PREV_DIR=$BACKUP_DIR/previous


#Methods

validateZipFilePresent() {
  cd $DEPLOYMENT_DIR || exit
  #Count the number of ZIP files in the directory
  # shellcheck disable=SC2012
  # shellcheck disable=SC2035
  zip_count=$(ls -1 *.zip 2>/dev/null | wc -l)
  log "Found $zip_count zip files in DEPLOYMENT_DIR($DEPLOYMENT_DIR)"
  #Check if the ZIP file count is not equal to 1
  if [ "$zip_count" -ne 1 ]; then
    log "Exit: ZIP file count is not equal to 1"
    exit 1
  fi
}

unzipLatestDeploymentFile() {
  log "Extracting new deployment zip"
  # shellcheck disable=SC2035
  unzip -q *.zip
  #Check whether unzipping is successful or not
  # shellcheck disable=SC2181
  if [ $? -eq 0 ]; then
    log "Unzip successful"
  else
    log "Unzip failed"
    exit 1
    #TODO - Automate fallback to previous deployment
  fi
}


log "Starting prod deployment."
start_time=$(date +%s)

#Step1
validateZipFilePresent

#Step2 - Move zip file
log "Move zip file from APP_DIR($APP_DIR) to DEPLOYMENT_DIR($DEPLOYMENT_DIR)"
mv "$DEPLOYMENT_DIR"/*.zip "$APP_DIR/"

#Step3 -
log "Creating PREV_DIR($PREV_DIR) for backup"
mkdir -p "$PREV_DIR"

#Step4
log "Shutdown FE and BE services to release resources."
pm2 stop nnt-fe
sleep 1s

##Step5
log "Moving previous deployment files to $PREV_DIR"
cd "$APP_DIR" || exit
mv .next "$PREV_DIR"
mv package-lock.json "$PREV_DIR"
mv package.json "$PREV_DIR"
#Now files backup completes
#APP_DIR is ready for this deployment

#Step6
unzipLatestDeploymentFile

#Step7 - Run npm install
log "Running npm install"
npm install

#Step8 - Start services
log "Start FE services"
pm2 start nnt-fe

#Step9 - Cleanup
mv *.zip "$BACKUP_DIR/app.zip"

############### End of Deployment ###################
end_time=$(date +%s)
time_taken=$((end_time - start_time))
log "Deployment finished in $time_taken seconds"