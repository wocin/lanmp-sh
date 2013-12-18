#/bin/bash
#By wocin
#Email ---
#initializing system environment
#-------------------I am boring line------------------------------------
#setup server should be stop
service sendmail stop
service postfix stop
/etc/rc.d/init.d/cups stop
/etc/rc.d/init.d/rpcbind stop
/etc/rc.d/init.d/rpcsvcgssd stop
/etc/rc.d/init.d/rpcidmapd stop
/etc/rc.d/init.d/rpcgssd stop
/etc/rc.d/init.d/portmap stop
/etc/rc.d/init.d/nfs stop
/etc/rc.d/init.d/nfslock stop
/etc/rc.d/init.d/qpidd stop
/etc/rc.d/init.d/postfix stop
chkconfig --level 345 sendmail off
chkconfig --level 345 postfix off
chkconfig --level 345 acpid off
chkconfig --level 345 auditd off
chkconfig --level 345 bluetooch off
chkconfig --level 345 cupspeed off
chkconfig --level 345 hplip off
chkconfig --level 345 hidd off
chkconfig --level 345 rpcgssd off
chkconfig --level 345 rpcbind off
chkconfig --level 345 rpcidmapd off
chkconfig --level 345 portmap off
chkconfig --level 345 cups off
chkconfig --level 345 sshd on
chkconfig --level 345 vsftpd on
chkconfig --level 345 qpidd off
#-------------------I am boring line------------------------------------
#sysctl.conf for reference
echo '''
net.ipv4.tcp_max_tw_buckets = 655360
net.ipv4.tcp_sack = 1
net.ipv4.tcp_ecn = 0
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_rmem = 4096 87380 4194304
net.ipv4.tcp_wmem = 4096 16384 4194304
net.core.wmem_default = 8388608
net.core.rmem_default = 8388608
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.core.netdev_max_backlog = 262144
net.core.somaxconn = 262144
net.ipv4.tcp_max_orphans = 3276800
net.ipv4.tcp_max_syn_backlog = 262144
net.ipv4.tcp_timestamps = 1
net.ipv4.tcp_synack_retries = 1
net.ipv4.tcp_syn_retries = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_mem = 94500000 915000000 927000000
net.ipv4.tcp_keepalive_time = 10
net.ipv4.tcp_fin_timeout = 15
'''>>/etc/sysctl.conf 
sysctl -p
#-------------------I am boring line------------------------------------
#history 
echo '''
HISTFILESIZE=50
HISTSIZE=50
HISTTIMEFORMAT="%Y-%m-%d-%H:%M:%S=>"
'''>>/etc/bashrc
export HISTTIMEFORMAT
#-------------------I am boring line------------------------------------
#yum install software
yum -y install gcc gcc-c++ autoconf make cmake libjpeg \
libjpeg-devel libpng libpng-devel freetype freetype-devel libxml2 \
libxml2-devel zlib zlib-devel glibc glibc-devel glib2 glib2-devel \
bzip2 bzip2-devel ncurses ncurses-devel curl curl-devel \
e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel openssl openssl-devel \
gd gd2 gd-devel gd2-devel libevent libevent-devel libtool httpd-tools net-snmp net-snmp-devel perl-DBI \
mysql mysql-server expext vsftpd vim ntsysv unzip sudo crontabs at ntp
#-------------------I am boring line------------------------------------
#Delete User and Group
userdel -f adm;userdel -f ntp;userdel -f lp
userdel -f sync;userdel -f pcap;userdel -f halt
userdel -f shutdown;userdel -f news;userdel -f uucp
userdel -f operator;userdel -f games;userdel -f gopher
userdel -f rpm;userdel -f nscd;userdel -f rpcuser
userdel -f nfsnobody;userdel -f mailnull;userdel -f smmsp
groupdel video;groupdel adm;groupdel lp;groupdel dip
groupdel floppy;groupdel cdrom;groupdel audio;groupdel tape
groupdel dialout;groupdel utempter;groupdel uucp
groupdel games
#-------------------I am boring line------------------------------------
#Set the executable file permission
chmod 700 /bin/ping /usr/bin/finger /usr/bin/who /usr/bin/w /usr/bin/locate
chmod 700 /usr/bin/whereis /sbin/ifconfig /usr/bin/pico /usr/bin/vi /usr/bin/vim
chmod 700 /usr/bin/which /bin/rpm /usr/bin/gcc /usr/bin/make
#-------------------I am boring line------------------------------------
