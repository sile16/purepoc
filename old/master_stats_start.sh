#!/bin/bash

#pass the test name as the param
O='\e[38;5;208m'
NC='\033[0m'

oecho () {
        echo -e "${O}$1${NC}"
}

if [ "$#" -ne "1" ] && [ "$#" -ne "2" ] ; then
	oecho "This script takes the test name as a param and optionally a run#"
	oecho "Syntax: $0 <test_name> [count]"
	oecho "example #:$0 test_dd"
	exit 1
fi

if [ `docker ps | grep graphite | wc -l` -ne 0 ]; then
	oecho "Looks like it's already running, please stop the current stats container before starting."
	exit 1
fi

#if the specific test is passed we are just viewing exsiting data probably
if [ "$#" -eq "2" ];then
	count=$2
else
	count=`cat $1/count`
fi

pwd=`pwd`
mkdir -p "$pwd/$1/results/$count"




docker run -v "$pwd/$1/results/$count":/data \
    -p 80:80 \
    -p 3000:3000 \
    -p 2003:2003 \
    -p 2004:2004 \
    -p 7002:7002 \
    -p 8125:8125/udp \
    -p 8126:8126 \
    -d samsaffron/graphite


