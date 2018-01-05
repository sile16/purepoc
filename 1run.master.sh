#!/bin/bash

. `pwd`/bash_common.sh

oecho "Downloading bootstrap"
download
oecho "Installing salt master"

#-M install master, -L install cloud
#-X don't start daemons
sudo sh /tmp/bootstrap-salt.sh -M -X -L

oecho "linking to /purepoc"
if [ ! -L "/purepoc" ]; then
    oecho "Requires sudo password to setup link"
    sudo ln -s `pwd` /purepoc
fi

#replace slat config files with ours


if [ ! -L "/etc/salt" ] ; then
  DATE=$(date +"%S-%M-%d-%b-%Y")
  oecho "replacing salt configs, backup at /etc/salt-bk-$DATE.tgz"
  sudo service salt-master stop
  sudo service salt-minion stop

  sudo tar -zcvf /etc/salt-bk-$DATE.tgz /etc/salt/*
  sudo rm -rf /etc/salt
  sudo ln -s /purepoc/master_config/etc/salt /etc/salt
fi

oecho "Starting Salt Deamons"
sudo service salt-master start
sudo service salt-minion start


#old docker way:
#docker run --privileged -h purepoc --rm -v /purepoc:/purepoc -p 4505:4505 -p 4506:4506 -it purepoc
#curl -L https://bootstrap.saltstack.com | sudo sh -s -- -A 127.0.0.1 -i master
