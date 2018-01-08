#!/bin/bash

hostname=`hostname`

cd /purepoc/test_dd
count=`cat count`

cmd=`cat cmd`

for fs in `ls -1 /mnt/test_fs`; do
	for x in $(eval echo "{1..$count}"); do
		mkdir -p /mnt/test_fs/$fs/$hostname
		echo running: $(eval "echo $cmd")
		eval "$cmd"
	done
done
