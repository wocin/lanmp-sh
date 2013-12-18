#!/bin/bash
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
log_path="/usr/local/nginx/logs/"

mkdir -p ${log_path}$(date -d "yesterday" +'%Y')/$(date -d "yesterday" +'%m')/
mv ${log_path}access.log ${log_path}$(date -d "yesterday" +'%Y')/$(date -d "yesterday" +'%m')/access_$(date -d "yesterday" +'%Y%m%d').log
service nginx restart
