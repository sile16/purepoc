#!/bin/bash

my_iface=`route | grep default | awk '{print $8}'`
my_ip=`ifconfig enp0s5 | grep "inet " | awk '{print $2'} | grep -o -e '[0-9].*'`

cd /purepoc/test_dd
count=`cat count`

cmd=`cat cmd`

for fs in `ls -1 /mnt/test_fs`; do
	for x in $(eval echo "{1..$count}"); do
		mkdir -p /mnt/test_fs/$fs/$my_ip
		echo running: $(eval "echo $cmd")
		eval "$cmd"
	done
done
