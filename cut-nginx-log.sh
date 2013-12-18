#!/bin/bash
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
log_path="/usr/local/nginx/logs/"
nginx_pid="/usr/local/nginx/logs/nginx.pid"

mkdir -p ${log_path}$(date -d "last-day" +'%Y')/$(date -d "last-day" +'%m')/
mv ${log_path}access.log ${log_path}$(date -d "last-day" +'%Y')/$(date -d "last-day" +'%m')/access_$(date -d "last-day" +'%Y%m%d').log
#service nginx restart
kill -HUP `cat $nginx_pid`
#-------------------I am boring line------------------------------------
#date -d yesterday +'%Y%m%d'
#date -d last-day +'%Y%m%d'
#date -d "1 days ago" +'%Y%m%d'
#date -d "next-day" +'%Y%m%d'
#date -d last-month +'%Y%m%d'
