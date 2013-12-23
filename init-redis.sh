#!/bin/bash
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
mkdir /backup/redis/ -p
cd /usr/local/lnmp/
wget http://download.redis.io/releases/redis-2.6.14.tar.gz
cd /usr/local/lnmp/redis-2.6.14
make
cd src 
make install
cp /usr/local/lnmp/redis-2.6.14/redis.conf /etc/
sed -i 's/daemonize no/daemonize yes/' /etc/redis.conf
sed -i 's/dir \.\//dir \/backup\/redis/' /etc/redis.conf
echo '''
#!/bin/bash
# chkconfig: - 80 12
# description: redis daemon
# processname: redis
# config: /etc/redis.conf
# pidfile: /var/run/redis.pid
source /etc/init.d/functions
BIN="/usr/local/bin"
CONFIG="/etc/redis.conf"
PIDFILE="/var/run/redis.pid"
### Read configuration
[ -r "$SYSCONFIG" ] && source "$SYSCONFIG"
RETVAL=0
prog="redis-server"
desc="Redis Server"
start() {
        if [ -e $PIDFILE ];then
             echo "$desc already running...."
             exit 1
        fi
        echo -n $"Starting $desc: "
        daemon $BIN/$prog $CONFIG
        RETVAL=$?
        echo
        [ $RETVAL -eq 0 ] && touch /var/lock/subsys/$prog
        return $RETVAL
}
stop() {
        echo -n $"Stop $desc: "
        killproc $prog
        RETVAL=$?
        echo
        [ $RETVAL -eq 0 ] && rm -f /var/lock/subsys/$prog $PIDFILE
        return $RETVAL
}
restart() {
        stop
        start
}
case "$1" in
  start)
        start
        ;;
  stop)
        stop
        ;;
  restart)
        restart
        ;;
  condrestart)
        [ -e /var/lock/subsys/$prog ] && restart
        RETVAL=$?
        ;;
  status)
        status $prog
        RETVAL=$?
        ;;
   *)
        echo $"Usage: $0 {start|stop|restart|condrestart|status}"
        RETVAL=1
esac
exit $RETVAL
''' >> /etc/init.d/redis
chmod +x /etc/init.d/redis
chkconfig --add redis
chkconfig redis on
