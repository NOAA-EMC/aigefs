#!/bin/bash
set -x

echo "Starting $0"

# Wait for up to 15 minutes to find the latest GEFS 6-h forecast
target=$COMINgefs/pgrb2sp25/${GEFS_MEMBER}.t${cyc}z.pgrb2s.0p25.f000
n_tries=30
for counter in $( seq 1 1 $n_tries ); do
    if [[ -e "$target" ]]; then
        echo "Required file found: $target"
        sleep 30
        break
    elif [[ $counter -eq $n_tries ]]; then
        echo "Required file not found after $counter tries: $target"
        export err=1; err_chk
    fi

    sleep 30
done

mkdir -p $DATA/data/$PDY/$cyc/
mkdir -p $DATA/data/$m1_PDY/$m1_cyc/
mkdir -p $DATA/data/$m2_PDY/$m2_cyc/

# copy data in
cpreq $COMINgefsm2/pgrb2sp25/${GEFS_MEMBER}.t${m2_cyc}z.pgrb2s.0p25.f006 $DATA/data/$m2_PDY/$m2_cyc
cpreq $COMINgefsm1/pgrb2p25/${GEFS_MEMBER}.t${m1_cyc}z.pgrb2.0p25.f000 $DATA/data/$m1_PDY/$m1_cyc
cpreq $COMINgefsm1/pgrb2sp25/${GEFS_MEMBER}.t${m1_cyc}z.pgrb2s.0p25.f000 $DATA/data/$m1_PDY/$m1_cyc
cpreq $COMINgefsm1/pgrb2sp25/${GEFS_MEMBER}.t${m1_cyc}z.pgrb2s.0p25.f006 $DATA/data/$m1_PDY/$m1_cyc
cpreq $COMINgefs/pgrb2p25/${GEFS_MEMBER}.t${cyc}z.pgrb2.0p25.f000 $DATA/data/$PDY/$cyc
cpreq $COMINgefs/pgrb2sp25/${GEFS_MEMBER}.t${cyc}z.pgrb2s.0p25.f000 $DATA/data/$PDY/$cyc

ls -lR $DATA/data

# run gefs_utility script to create graphcast input
$USHaigefs/gen_aigefs_ics.py "$m1_PDYHH" "$curr_PDYHH" "$GEFS_MEMBER" -o output
export err=$?; err_chk

cpfs output/${MEMBER}/mlgefs.t${cyc}z.ic.nc $COMOUT/aigefs.t${cyc}z.ic.nc

echo "$0 completed normally"
