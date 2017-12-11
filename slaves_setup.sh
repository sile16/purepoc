#!/bin/bash

O='\e[38;5;208m'
NC='\033[0m'

oecho () {
	echo -e "${O}$1${NC}"
}

pssh () {
	parallel-ssh -h hosts -l root -i -o setup_logs "$1"
}

oecho "Installing packages on slaves"
pssh "apt-get -q update"
pssh "apt-get -qy upgrade"
pssh "apt-get install docker.io

