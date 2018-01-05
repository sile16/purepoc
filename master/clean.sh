#!/bin/bash

#VOLUME ["/etc/salt/pki", "/var/cache/salt", "/var/logs/salt", "/etc/salt/master.d", "/srv/salt"]

sudo rm -rf ../master_config/var/cache/salt/master/*
sudo rm -rf ../master_config/var/cache/salt/minion/*
sudo rm -rf ../master_config/etc/minion_id
sudo rm -rf ../master_config/var/logs/salt/*
#sudo rm -rf ../master_config/srv/

user=`whoami`

sudo chown $user.$user -R ../master_config
