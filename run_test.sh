#!/bin/bash

O='\e[38;5;208m'
NC='\033[0m'

oecho () {
	echo -e "${O}$1${NC}"
}

pssh () {
	parallel-ssh -h hosts -l root -i -o setup_logs "$1"
}

rc=`$1/check_params.sh $@`
if [ "$rc" -ne "0" ]; then
	exit 1;
fi

pssh /purepoc/$1/run.sh


