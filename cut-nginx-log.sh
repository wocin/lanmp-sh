#!/bin/bash
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
log_path="/usr/local/nginx/logs/"

mkdir -p ${log_path}$(date -d "last-day" +'%Y')/$(date -d "last-day" +'%m')/
mv ${log_path}access.log ${log_path}$(date -d "last-day" +'%Y')/$(date -d "last-day" +'%m')/access_$(date -d "last-day" +'%Y%m%d').log
service nginx restart
