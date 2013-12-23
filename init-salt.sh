#!/bin/bash
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
#init master
wget http://mirrors.sohu.com/fedora-epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -ivh epel-release-6-8.noarch.rpm
yum -y install salt-master
sed -i 's/#interface: 0.0.0.0/interface: 0.0.0.0/' /etc/salt/master
mkdir /srv/salt/ -p 
mkdir /srv/salt/shell -p
echo '''
base:
 '*':
  - shell
''' >/srv/salt/top.sls
#-------------------I am boring line------------------------------------
#init minion
wget http://mirrors.sohu.com/fedora-epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -ivh epel-release-6-8.noarch.rpm
yum -y install salt-minion
