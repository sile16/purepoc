#!/bin/bash


#pass the server
cd /purepoc/test_dd_read
server=`cat server`

umount /mnt/test_fs
mkdir -p  /mnt/test_fs
mount $server /mnt/test_fs
