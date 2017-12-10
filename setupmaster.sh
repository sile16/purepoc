#!/bin/bash

O='\e[38;5;208m'
NC='\033[0m'

oecho () {
	echo -e "${O}$1${NC}"
}

oecho "Install packages on master, will prompt for local sudo pass"
sudo apt-get install -y pssh sshpass


if [ ! -f ~/.ssh/id_rsa.pub ]; then
	oecho "No local public key found, creating a new one"
	ssh-keygen -t rsa
fi

oecho  "Setup SSH Keys for root login, Input remote server credentials"

echo -n User:
read user
echo

echo -n Password:
read -s password
echo

for host in `cat hosts`; do 
	sshpass -p "$password" ssh-copy-id -o StrictHostKeyChecking=no $user@$host
	echo "$password" | ssh $user@$host "sudo -S mkdir -p /root/.ssh"
	echo "$password" | ssh $user@$host "sudo -S cp ~/.ssh/authorized_keys /root/.ssh/"
done



