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
sudo apt-get install -q -y pssh sshpass 

