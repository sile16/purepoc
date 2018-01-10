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
  oecho "Installing $1"
  if [ `rpm -q $1>/dev/null; echo $?` !=  "0" ]; then
    oecho "Installing $1 via yum"
    yum install -y $1 >> $LOG
    if [ $? -ne 0 ]; then
      error "Failed installing $1"
    fi
  fi
}

oecho "Installing required packages"
for x in git docker ansible pyOpenSSL python-cryptography python-lxml; do
  install_pkg $x
done

oecho "Starting services"
for x in "docker"; do
  oecho "Starting $1"
  systemctl enable $x
  systemctl start $x
done


###### pulling from github
if [ ! -d /purepoc/openshift-ansible ]; then
  oecho "Pulling repo"
  mkdir -p /purepoc
  cd /purepoc
  git clone https://github.com/openshift/openshift-ansible.git
  git clone https://github.com/sile16/purepoc.git
fi


###### adding scripts to path
[[ ":$PATH:" != *":/purepoc/purepoc:"* ]] && PATH="/purepoc/purepoc:${PATH}"




