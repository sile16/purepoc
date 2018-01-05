#!/bin/bash

#pass the test name as the param
O='\e[38;5;208m'
NC='\033[0m'

oecho () {
        echo -e "${O}$1${NC}"
}

if [ "$#" -ne "0" ]  ; then
	oecho "This script takes no params "
	exit 1
fi

if [ `docker ps | grep graphite | wc -l` -eq 0 ]; then
	oecho "Looks like there isn't one running."
	exit 1
fi

container=`docker ps | grep graphite | awk '{print $1};'`

docker kill $container
