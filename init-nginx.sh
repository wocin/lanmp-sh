#!/bin/bash
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
#init pcre for nginx
mkdir /usr/local/lnmp/
cd /usr/local/lnmp/
wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.34.tar.gz
tar xvf pcre-8.34.tar.gz
cd pcre-8.34
./configure	--prefix=/usr/local/lnmp/pcre-8.34
make
make install
#-------------------I am boring line------------------------------------
#init nginx
groupadd nginx
useradd -g nginx nginx
usermod -s /sbin/nologin nginx
mkdir /usr/local/nginx
cd /usr/local/lnmp/
wget http://nginx.org/download/nginx-1.5.8.tar.gz
tar xvf nginx-1.5.8.tar.gz
cd /usr/local/lnmp/nginx-1.5.8
./configure	--prefix=/usr/local/nginx --with-pcre=/usr/local/lnmp/pcre-8.33 --with-http_stub_status_module \
--with-http_ssl_module --with-http_flv_module --with-http_dav_module \
--with-http_gzip_static_module --with-debug --user=nginx --group=nginx 
make
make install
mkdir /usr/local/nginx/conf.d
#-------------------I am boring line------------------------------------
#nginx.conf for reference
echo '''
user  nginx;
worker_processes  8;
error_log  logs/error.log  error;

pid        logs/nginx.pid;
worker_rlimit_nofile 65535;

events {
    use epoll;
    worker_connections  1024;
}

http {
    include       mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  logs/access.log  main;
    sendfile        on;
    tcp_nopush     on;

    keepalive_timeout  65;
    server_names_hash_bucket_size 128;
    client_header_buffer_size 32k;
    large_client_header_buffers 1 128k;# 4 32k
    client_max_body_size 8m;

    fastcgi_connect_timeout 600;
    fastcgi_send_timeout 600;
    fastcgi_read_timeout 600;
    fastcgi_buffer_size 256k;
    fastcgi_buffers 4 512k;#8 128
    fastcgi_busy_buffers_size 512k;
    fastcgi_temp_file_write_size 512k;
    fastcgi_intercept_errors on;

    gzip on;
    gzip_min_length 1k;
    gzip_buffers     1 64k; #4 16
    gzip_http_version 1.0;
    gzip_comp_level 2;
    gzip_types       text/plain application/x-javascript text/css application/xml;
    gzip_vary on;
 
    include /usr/local/nginx/conf.d/*.conf;
}
'''>/usr/local/nginx/conf/nginx.conf
#-------------------I am boring line------------------------------------
#init nginx start.sh
echo '''
#!/bin/bash
# Startup script for the nginx Web Server
# chkconfig: - 85 15
# description: nginx is a World Wide Web server. It is used to serve
# processname: nginx
nginxd=/usr/local/nginx/sbin/nginx
nginx_config=/usr/local/nginx/conf/nginx.conf
nginx_pid=/usr/local/nginx/logs/nginx.pid
 
REIVAL=0
prog="nginx"
 
. /etc/rc.d/init.d/functions
 
. /etc/sysconfig/network
 
[ ${NETWORKING} = "no" ] && exit 0
[ -x $nginxd ] || exit 0
 
start() {
if [ -e $nginx_pid ];then
    echo "nginx already running..."
    exit 1
fi
    echo -n $"starting $prog: "
    daemon $nginxd -c ${nginx_config}
    RETVAL=$?
    echo
    [ $RETVAL = 0 ] && touch /usr/local/nginx/logs/nginx
    return $RETVAL
}
 
stop() {
    echo -n $"stoping $prog: "
    killproc $nginxd
    RETVAL=$?
    echo
    [ $RETVAL = 0 ] && rm -f /usr/local/nginx/logs/nginx /usr/local/nginx/logs/nginx.pid
}
reload() {
    echo -n $"reloading $prog: "
    $nginxd -s reload
    RETVAL=$?
    echo
}
case "$1" in
start)
    start
    ;;
stop)
    stop
    ;;
reload)
    reload
    ;;
restart)
    stop
    start
    ;;
status)
    status $prog
    RETVAL=$?
    ;;
*)
    echo $"Usage: $prog {start|stop|restart|reload|status}"
    exit 1
esac
exit $RETVAL
''' >> /etc/init.d/nginx
chmod +x /etc/init.d/nginx
chkconfig --add nginx
chkconfig nginx on
#-------------------I am boring line------------------------------------
