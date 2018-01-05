#!/bin/bash

O='\e[38;5;208m'
NC='\033[0m'

oecho () {
        echo -e "${O}$1${NC}"
}

curl_rt=`which curl > /dev/null; echo $?`
wget_rt=`which wget > /dev/null; echo $?`

echo "$curl_rt && $wget_rt"
if [ $curl_rt -ne 0 ] && [ $wget_rt -ne 0 ]; then
  oecho "Error: Could not find either curl or wget, please install one."
  exit 1
fi


### downloading salt bootstrap
success=0
if [ $curl_rt -eq 0 ]; then
  curl -o bootstrap-salt.sh -L https://bootstrap.saltstack.com 2>/dev/null
  if [ $? -eq 0 ]; then
    success=1
  fi
fi

if [ ! $success ] && [ $wget_rt -eq 0 ] ; then
  wget -O bootstrap-salt.sh https://bootstrap.saltstack.com
  if [ $? -eq 0 ]; then
    success=1
  fi
fi

if [ ! $success ]; then
  oecho "Error: Unable to download salt bootstrap, please check network"
  oecho "connectivity to https://bootstrap.saltstack.com"
  exit 1
fi

oecho "Installing salt minion on master"
sudo sh bootstrap-salt.sh -A 127.0.0.1 -i master
