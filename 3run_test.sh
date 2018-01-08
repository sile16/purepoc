#!/bin/bash
. `pwd`/bash_common.sh

log_dir="/purepoc/logs"

if [ ! -f "$log_dir/count" ]; then
	mkdir -p "$log_dir"
	echo "1" > "$log_dir/count"
fi

count=`cat $log_dir/count`


if [ -f "/purepoc/tests/$1/check_params.sh" ]; then
	/purepoc/tests/$1/check_params.sh $@
	rc=`echo $?`
	if [ "$rc" -ne "0" ]; then
		exit 1;
	fi
fi

DATE=`date +%s`

echo "{\"timestamp\":\"$DATE\",\"testname\":\"$1\",\"params\":\"$@\",\"test_num\":\"$count\"}" >> /purepoc/logs/test_log

sudo salt 'node*' cmd.run "/purepoc/$1/run.sh $@"

count=$((count+1))
echo $count > "$log_dir/count"

