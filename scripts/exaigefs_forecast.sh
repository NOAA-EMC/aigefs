#!/bin/bash
set -x

echo "Starting $0"

mkdir -p ${DATA}/data
mkdir -p ${DATAshared}/output

# copy data in
cpreq $COMIN/aigefs.${cycle}.ic.nc $DATA/data
ls -l $DATA/data

mem_num=$( echo $MEMBER | egrep -o "[0-9]+" | bc )

# run graphcast forecast
$USHaigefs/run_graphcast.py \
	-n ai${GEFS_MEMBER} \
	-i ${DATA}/data/aigefs.${cycle}.ic.nc \
	-o ${DATAshared}/output \
	-w $FIXaigefs \
	-l 64 \
        -c ${FIXaigefs}/ens_weights/member${mem_num}.pkl
export err=$?; err_chk

echo "$0 completed normally"
