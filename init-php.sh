#!/bin/bash
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
mkdir /usr/local/php/
mkdir /usr/local/php/tmp
chmod 777 /usr/local/php/tmp
cd /usr/local/lnmp/
wget http://cn2.php.net/distributions/php-5.5.1.tar.gz
cd /usr/local/lnmp/php-5.5.1
./configure --prefix=/usr/local/php --with-mysql --with-mysqli \
--enable-xml --enable-bcmath --enable-fastcgi --enable-fpm --enable-zip  \
--with-gd --with-freetype-dir --with-jpeg-dir --with-png-dir --enable-mbstring \
--enable-sockets --with-gettext 
make 
make install
cd /usr/local/lnmp/
unzip phpredis-master.zip
cd /usr/local/lnmp/phpredis-master
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config
make 
make install
cd /usr/local/lnmp/php-5.5.1
cp php.ini-production /usr/local/php/lib/php.ini
cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf
#-------------------I am boring line------------------------------------
cd /usr/local/lnmp/php-5.5.1/ext/curl
/usr/local/php/bin/phpize 
./configure --with-php-config=/usr/local/php/bin/php-config
make
make install 
#-------------------I am boring line------------------------------------
cd /usr/local/lnmp/php-5.5.1/ext/pdo_mysql
/usr/local/php/bin/phpize 
./configure --with-php-config=/usr/local/php/bin/php-config
make
make install
#-------------------I am boring line------------------------------------
cd /usr/local/lnmp/
tar xvf memcache-3.0.8.tgz
cd memcache-3.0.8
/usr/local/php/bin/phpize 
./configure  --with-php-config=/usr/local/php/bin/php-config  --with-libmemcached-dir=/usr/local/libmemcached/ 
make
make install
#-------------------I am boring line------------------------------------
cd /usr/local/lnmp/
tar xvf mongo-1.4.2.tgz
cd mongo-1.4.2
/usr/local/php/bin/phpize 
./configure  --with-php-config=/usr/local/php/bin/php-config 
make
make install
#-------------------I am boring line------------------------------------
echo '''
#!/bin/bash
# Startup script for the php-fpm Server
# chkconfig: - 85 15
# description: PHP-FPM is an PHPFastCGI manager, is only used for PHP 
# processname: php-fpm
phpfpm=/usr/local/php/sbin/php-fpm
 
REIVAL=0
prog="php-fpm"
 
. /etc/rc.d/init.d/functions
 
. /etc/sysconfig/network
 
[ ${NETWORKING} = "no" ] && exit 0

 
start() {
    echo -n $"starting $prog: "
    daemon $phpfpm
    RETVAL=$?
    echo
    [ $RETVAL = 0 ] 
}
 
stop() {
    echo -n $"stoping $prog: "
    killproc php-fpm
    RETVAL=$?
    echo
    [ $RETVAL = 0 ] 
}

case "$1" in
start)
    start
    ;;
stop)
    stop
    ;;
restart)
    stop
    start
    ;;
*)
    echo $"Usage: $prog {start|stop|restart}"
    exit 1
esac
exit $RETVAL
''' > /etc/init.d/php-fpm
#-------------------I am boring line------------------------------------
chmod +x /etc/init.d/php-fpm
chkconfig --add php-fpm
chkconfig php-fpm on
service php-fpm start
echo '''
PATH=$PATH:/usr/local/php/bin/
''' >> /etc/profile
source /etc/profile
#-------------------I am boring line------------------------------------
sed -i '730 a\extension_dir="/usr/local/php/lib/php/extensions/no-debug-non-zts-20121212/"' /usr/local/php/lib/php.ini
sed -i '731 a\extension="redis.so"'  /usr/local/php/lib/php.ini
sed -i '732 a\extension="pdo_mysql.so"'  /usr/local/php/lib/php.ini
sed -i '733 a\extension="curl.so"'  /usr/local/php/lib/php.ini
sed -i '734 a\extension="memcache.so"'  /usr/local/php/lib/php.ini
sed -i '735 a\extension="mongo.so"'  /usr/local/php/lib/php.ini
sed -i '/date.timezone =/a\date.timezone = Asia/Shanghai' /usr/local/php/lib/php.ini
sed -i 's/;session.save_path = "\/tmp"/session.save_path = "\/tmp"/' /usr/local/php/lib/php.ini
#-------------------I am boring line------------------------------------
