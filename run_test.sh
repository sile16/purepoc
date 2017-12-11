#!/bin/bash

O='\e[38;5;208m'
NC='\033[0m'

oecho () {
	echo -e "${O}$1${NC}"
}

pssh () {
	parallel-ssh -h hosts -l root -i -o "$log_dir/$count"  "$1"
}

log_dir="$1/logs"

if [ ! -f "$log_dir/count" ]; then
	mkdir -p "$log_dir"
	echo "1" > "$log_dir/count"
fi

count=`cat $log_dir/count`


if [ -f "$1/check_params.sh" ]; then
	$1/check_params.sh $@
	rc=`echo $?`
	if [ "$rc" -ne "0" ]; then
		exit 1;
	fi
fi


pssh date
pssh /purepoc/$1/setup.sh
pssh "/purepoc/$1/run.sh $@"
pssh date

count=$((count+1))
echo $count > "$log_dir/count"

