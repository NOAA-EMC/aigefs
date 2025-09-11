#!/bin/bash
set -x

echo "Starting $0"

mkdir -p ${DATA}/data

# copy data in
cpreq $COMIN/aigefs.${cycle}.ic.nc $DATA/data
ls -l $DATA/data

# run graphcast forecast
$USHaigefs/run_graphcast.py \
	-i ${DATA}/data/aigefs.${cycle}.ic.nc \
	-n ml${GEFS_MEMBER} \
	-o ${DATA} \
	-w $FIXaigefs \
	-l 64
export err=$?; err_chk

for fh in $( seq -f "%03g" 0 6 384 ); do
  file=$COMOUT/aigefs.${cycle}.pres.f${fh}.grib2
  cpfs mlgefs.${cycle}.pres.0p25.f${fh}.grib2 ${file}
  cpfs mlgefs.${cycle}.pres.0p25.f${fh}.grib2.idx ${file}.idx

  if [ "$SENDDBN" = "YES" ]; then
    $DBNROOT/bin/dbn_alert MODEL AIGEFS_GB2 $job ${file}
    $DBNROOT/bin/dbn_alert MODEL AIGEFS_GB2_IDX $job ${file}.idx
  fi

  file=$COMOUT/aigefs.${cycle}.sfc.f${fh}.grib2
  cpfs mlgefs.${cycle}.sfc.0p25.f${fh}.grib2 ${file}
  cpfs mlgefs.${cycle}.sfc.0p25.f${fh}.grib2.idx ${file}.idx

  if [ "$SENDDBN" = "YES" ]; then
    $DBNROOT/bin/dbn_alert MODEL AIGEFS_GB2 $job ${file}
    $DBNROOT/bin/dbn_alert MODEL AIGEFS_GB2_IDX $job ${file}.idx
  fi
done

echo "$0 completed normally"
