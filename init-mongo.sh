#!/bin/bash
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
groupadd mongod
useradd -g mongod mongod
usermod -s /sbin/nologin mongod
mkdir /usr/local/mongo/ -p
mkdir /backup/mongo/ -p
chown mongod:mongod /backup/mongo/
touch /var/log/mongod.log
chmod 777 /var/log/mongod.log
cd /usr/local/lnmp/
wget http://downloads.mongodb.org/linux/mongodb-linux-x86_64-2.5.4.tgz
tar xvf mongodb-linux-x86_64-2.4.5.tgz
mv mongodb-linux-x86_64-2.4.5/* /usr/local/mongo/
#-------------------I am boring line------------------------------------
echo '''
# mongo.conf

#where to log
logpath=/var/log/mongod.log

logappend=true

# fork and run in background
fork = true

bind_ip = 127.0.0.1
#port = 27017

dbpath=/backup/mongo

# location of pidfile
pidfilepath = /var/run/mongodb/mongod.pid

# Disables write-ahead journaling
# nojournal = true

# Enables periodic logging of CPU utilization and I/O wait
#cpu = true

# Turn on/off security.  Off is currently the default
#noauth = true
#auth = true

# Verbose logging output.
#verbose = true

# Inspect all client data for validity on receipt (useful for
# developing drivers)
#objcheck = true

# Enable db quota management
#quota = true

# Set oplogging level where n is
#   0=off (default)
#   1=W
#   2=R
#   3=both
#   7=W+some reads
#diaglog = 0

# Ignore query hints
#nohints = true

# Disable the HTTP interface (Defaults to localhost:27018).
#nohttpinterface = true

# Turns off server-side scripting.  This will result in greatly limited
# functionality
#noscripting = true

# Turns off table scans.  Any query that would do a table scan fails.
#notablescan = true

# Disable data file preallocation.
#noprealloc = true

# Specify .ns file size for new databases.
# nssize = <size>

# Accout token for Mongo monitoring server.
#mms-token = <token>

# Server name for Mongo monitoring server.
#mms-name = <server-name>

# Ping interval for Mongo monitoring server.
#mms-interval = <seconds>

# Replication Options

# in replicated mongo databases, specify here whether this is a slave or master
#slave = true
#source = master.example.com
# Slave only: specify a single database to replicate
#only = master.example.com
# or
#master = true
#source = slave.example.com
'''>/etc/mongod.conf
#-------------------I am boring line------------------------------------
echo '''
PATH=$PATH:/usr/local/mongodb/bin/
''' >> /etc/profile
source /etc/profile
echo '''
#!/bin/bash
# mongod - Startup script for mongod
# chkconfig: 35 85 15
# description: Mongo is a scalable, document-oriented database.
# processname: mongod
# config: /etc/mongod.conf
# pidfile: /var/run/mongo/mongod.pid
. /etc/rc.d/init.d/functions
CONFIGFILE="/etc/mongod.conf"
OPTIONS=" -f $CONFIGFILE"
SYSCONFIG="/etc/sysconfig/mongod"

DBPATH=`awk -F= '/^dbpath=/{print $2}' "$CONFIGFILE"`
PIDFILE=`awk -F= '/^dbpath\s=\s/{print $2}' "$CONFIGFILE"`
mongod=${MONGOD-/usr/local/mongodb/bin/mongod}

MONGO_USER=mongod
MONGO_GROUP=mongod

if [ -f "$SYSCONFIG" ]; then
    . "$SYSCONFIG"
fi

# Handle NUMA access to CPUs (SERVER-3574)
# This verifies the existence of numactl as well as testing that the command works
NUMACTL_ARGS="--interleave=all"
if which numactl >/dev/null 2>/dev/null && numactl $NUMACTL_ARGS ls / >/dev/null 2>/dev/null
then
    NUMACTL="numactl $NUMACTL_ARGS"
else
    NUMACTL=""
fi

start()
{
  echo -n $"Starting mongod: "
  daemon --user "$MONGO_USER" $NUMACTL $mongod $OPTIONS
  RETVAL=$?
  echo
  [ $RETVAL -eq 0 ] && touch /var/lock/subsys/mongod
}

stop()
{
  echo -n $"Stopping mongod: "
  killproc -p "$PIDFILE" -d 300 /usr/bin/mongod
  RETVAL=$?
  echo
  [ $RETVAL -eq 0 ] && rm -f /var/lock/subsys/mongod
}

restart () {
        stop
        start
}
ulimit -n 12000
RETVAL=0

case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  restart|reload|force-reload)
    restart
    ;;
  condrestart)
    [ -f /var/lock/subsys/mongod ] && restart || :
    ;;
  status)
    status $mongod
    RETVAL=$?
    ;;
  *)
    echo "Usage: $0 {start|stop|status|restart|reload|force-reload|condrestart}"
    RETVAL=1
esac

exit $RETVAL
''' >/etc/init.d/mongod
#-------------------I am boring line------------------------------------
chmod +x /etc/init.d/mongod
chkconfig --add mongod
