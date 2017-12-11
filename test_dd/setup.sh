#!/bin/bash


#pass the server
cd /purepoc/test_dd
./cleanup.sh

x=1
for server in `cat servers` ; do
	mkdir -p /mnt/test_fs/$x
	mount $server /mnt/test_fs/$x
	x=$((x+1))
done

