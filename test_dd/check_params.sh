#!/bin/bash

if [ "$#" -ne "2" ] ; then
	echo "Params passed $#:$@"
	echo "Usage: test_dd <server_mount_path>"
	exit 1
fi

