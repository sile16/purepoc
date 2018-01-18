#!/bin/bash



oecho_nolog () {
  O='\e[38;5;208m'
  NC='\033[0m'
  echo -e "${O}$1${NC}"
}

oecho_nolog "This script is only tested on RHEL/CentOS 7.4"
if [ `whoami` != 'root' ]; then 
  oecho_nolog "Please run this script as root"
  exit 1;
fi

#######  Setup Logging   ########
LOG=/purepoc/logs/setup
log () { oecho_nolog "`date` : $1" >> $LOG; }
oecho () { oecho_nolog "$1"; log "$1"; }



mkdir -p /purepoc/logs
log "Starting"

error() {
  oecho $1
  oecho $1 >> $LOG
  oecho "Please check /purepoc/logs for more information, exiting"
  exit 1;
}

install_pkg () {
  if [ `rpm -q $1>/dev/null; echo $?` !=  "0" ]; then
    oecho "Installing $1 via yum"
    yum install -y $1 >> $LOG 2>&1
    if [ $? -ne 0 ]; then
      error "Failed installing $1"
    fi
  fi
}

oecho "Disable firewall & SE Linux"
service iptables stop >> $LOG 2>&1
service firewalld stop >> $LOG 2>&1
systemctl disable firewalld >> $LOG 2>&1
chkconfig iptable off >> $LOG 2>&1
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config >> $LOG 2>&1
setenforce 0 >> $LOG 2>&1

                  
oecho "Installing required packages"
for x in git wget epel-release yum-utils ansible pyOpenSSL python-lxml; do
  install_pkg $x
done

oecho "Docker: Removing old"
yum remove -y docker docker-common docker-selinux docker-engine >> $LOG 2>&1
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo >> $LOG 2>&1
oecho "Docker: Installing"
install_pkg docker-io

oecho "Starting services:"
for x in "docker"; do
  oecho "Starting $1"
  sudo chkconfig $x on >> $LOG 2>&1
  service $x start >> $LOG 2>&1
done


###### pulling from github
if [ ! -d /purepoc/openshift-ansible ]; then
  oecho "Pulling repos"
  mkdir -p /purepoc >> $LOG 2>&1
  cd /purepoc
  git clone https://github.com/openshift/openshift-ansible.git >> $LOG 2>&1
  git clone https://github.com/sile16/purepoc.git >> $LOG 2>&1
fi


###### adding scripts to path
###### this doens't work
[[ ":$PATH:" != *":/purepoc/purepoc:"* ]] && PATH="/purepoc/purepoc:${PATH}"




