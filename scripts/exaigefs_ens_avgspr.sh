#!/bin/sh
###########################################################################
# Script: aigefsens_avgspr.sh
# Abstract: this script produces mean and spread of FNMOC ensemble forecast
# Author: Bo Cui ---- Oct. 2013
# History: 
#         2022-07-03  Bo Cui - modified for 0.5 degree input
###########################################################################
set -x
cd $DATA

export pgm=aigefs_ensstat

#---------------------------------------
#  calculate ensemble mean and spread
#---------------------------------------

#hourlist="000 006 012 018 024 030 036 042 048 \
#          054 060 066 072 078 084 090 096 102 \
#          108 114 120 126 132 138 144 150 156 \
#          162 168 174 180 186 192 198 204 210 \
#          216 222 228 234 240 246 252 258 264 270 276 282 288 294 300 \
#          306 312 318 324 330 336 342 348 354 360 366 372 378 384"

memberlist="000 001 002 003 004 005 006 007 008 009 010 \
            011 012 013 014 015 016 017 018 019 020 \
            021 022 023 024 025 026 027 028 029 030"

######################################################
# start mean and spread calculation for each lead time
######################################################

for prod in pres sfc; do
  nfhrs=$fh
  #for nfhrs in $hourlist
  #do
  
  #rm namin_avgspr_${nfhrs}
  
    echo " &namens" >>namin_avgspr_${prod}_${nfhrs}
  
    ifile=0
    for mem in $memberlist
    do
      file=$COMIN/mem${mem}/model/atmos/grib2/aigefs.t${cyc}z.${prod}.f${nfhrs}.grib2
      if [ -s $file ]; then
        (( ifile = ifile + 1 ))
        iskip=0
        echo " cfipg($ifile)='${file}'," >>namin_avgspr_${prod}_${nfhrs}
        echo " iskip($ifile)=${iskip}," >>namin_avgspr_${prod}_${nfhrs}
      fi
    done
  
    echo " nfiles=${ifile}," >>namin_avgspr_${prod}_${nfhrs}
    echo " cfopg1='aigefs.t${cyc}z.${prod}.avg.f${nfhrs}.grib2'," >>namin_avgspr_${prod}_${nfhrs}
    echo " cfopg2='aigefs.t${cyc}z.${prod}.spr.f${nfhrs}.grib2'," >>namin_avgspr_${prod}_${nfhrs}
    echo " /" >>namin_avgspr_${prod}_${nfhrs}
  
    if [ $ifile -le 2 ]; then
      echo "FATAL ERROR in aigefsens_avgspr.sh!!!"
      echo "Fewer than 2 MLGEFS raw files available for fcst hr " $nfhrs
      export err=1; err_chk
    fi
  
  #done
  
  #if [ -s poescript_avgspr ]; then
  #  rm poescript_avgspr
  #fi
  
  #for nfhrs in $hourlist; do
  #  echo "$EXECaigefs/${pgm} <namin_avgspr_${prod}_${nfhrs} > $pgmout.${nfhrs}_avgspr_${prod}" >> poescript_avgspr
  #done
  
  #chmod +x poescript_avgspr
  startmsg
  #$APRUN poescript_avgspr
  $EXECaigefs/${pgm} <namin_avgspr_${prod}_${nfhrs} > $pgmout.${nfhrs}_avgspr_${prod}
  export err=$?; err_chk
  
  wait
  
  if [ "$SENDCOM" = "YES" ]; then
    #for nfhrs in $hourlist
    #do
      file=aigefs.t${cyc}z.${prod}.avg.f$nfhrs.grib2
      if [ -s $file ]; then
        cpfs $file $COMOUT/
        $WGRIB2 -s $file > $file.idx
        cpfs $file.idx $COMOUT/$file.idx
        if [ "$SENDDBN" = "YES" ]; then
          $DBNROOT/bin/dbn_alert MODEL AIGEFS_ENSSTAT_GB2 $job $COMOUT/$file
          $DBNROOT/bin/dbn_alert MODEL AIGEFS_ENSSTAT_GB2_IDX $job $COMOUT/$file.idx
        fi
        $WGRIB2 -s $file > $COMOUT/$file.idx
      else
        echo "Warning $file missing"
      fi
      file=aigefs.t${cyc}z.${prod}.spr.f$nfhrs.grib2
      if [ -s $file ]; then
        cpfs $file $COMOUT/
        $WGRIB2 -s $file > $file.idx
        cpfs $file.idx $COMOUT/$file.idx
        if [ "$SENDDBN" = "YES" ]; then
          $DBNROOT/bin/dbn_alert MODEL AIGEFS_ENSSTAT_GB2 $job $COMOUT/$file
          $DBNROOT/bin/dbn_alert MODEL AIGEFS_ENSSTAT_GB2_IDX $job $COMOUT/$file.idx
        fi
      else
        echo "Warning $file missing"
      fi
    #done
  fi
done

set +x
echo " "
echo "Leaving sub script aigefsens_avgspr.sh"
echo " "
set -x

