#!/bin/bash

#cleanup 
echo "Starting cleanup"
if [ -d /mnt/test_fs ];then
	for mnt in `ls -1 /mnt/test_fs`; do 
		umount -f /mnt/test_fs/$mnt
		rm -rf /mnt/test_fs/$mnt
	done
	umount /mnt/test_fs
	rm -rf /mnt/test_fs

fi
echo "cleanup finished"
