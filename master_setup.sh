#!/bin/bash

O='\e[38;5;208m'
NC='\033[0m'

oecho () {
	echo -e "${O}$1${NC}"
}

pssh () {
	parallel-ssh -h hosts -l root -i -o setup_logs "$1"
}

oecho "Install packages on master, will prompt for local sudo pass"
sudo apt-get install -q -y pssh sshpass docker.io nfs-kernel-server
sudo usermod -a -G docker `whoami`

pwd=`pwd`
sudo ln -s $pwd /purepoc
echo "/purepoc   0.0.0.0/0(rw,no_subtree_check,no_root_squash)" > exports
sudo cp -f exports /etc/exports
sudo systemctl restart nfs-kernel-server

oecho "Please logout and log back in for docker group to become effective."
