#!/bin/bash

my_iface=`route | grep default | awk '{print $8}'`
my_ip=`ifconfig enp0s5 | grep "inet " | awk '{print $2'} | grep -o -e '[0-9].*'`

for x in {1..4}; do 
	mkdir -p /mnt/test_fs/$my_ip
	dd if=/mnt/test_fs/$my_ip/$x of=/dev/null bs=1M count=10000 &
done
