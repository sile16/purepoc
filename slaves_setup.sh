#!/bin/bash

O='\e[38;5;208m'
NC='\033[0m'

oecho () {
	echo -e "${O}$1${NC}"
}

pssh () {
	parallel-ssh -h hosts -l root -i -o setup_logs "$1"
}

my_iface=`route | grep default | awk '{print $8}'`
my_ip=`ifconfig enp0s5 | grep "inet " | awk '{print $2'} | grep -o -e '[0-9].*'`


oecho "Installing packages on slaves"
pssh "apt-get -q update"
pssh "apt-get -qy upgrade"
pssh "apt-get -qy install docker.io nfs-common"
pssh "mkdir purepoc"
pssh "mount $my_ip:/purepoc purepoc"


