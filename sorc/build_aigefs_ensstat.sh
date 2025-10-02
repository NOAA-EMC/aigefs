#! /usr/bin/env bash
set -eux

module reset
cwd=`pwd`

progname=aigefs_ensstat

source ../versions/build.ver

module use ${cwd}/../modulefiles/aigefs
module load ${progname}
module list

# Check final exec folder exists
if [ ! -d "../exec" ]; then
  mkdir ../exec
fi

#
cd ${progname}.fd

export FCMP=${FCMP:-ftn}
export FCMP95=$FCMP

if [ "$DEBUG" = 'Y' ] ; then
  #export FFLAGSM="-O0 -traceback -check all -ftrapuv -convert big_endian"
  export FFLAGSM="-O0 -traceback -g -check all -ftrapuv -convert big_endian"
else
  export FFLAGSM="-O3 -traceback -convert big_endian"
fi

export RECURS=
export LDFLAGSM=${LDFLAGSM:-""}
export OMPFLAGM=${OMPFLAGM:-""}

export INCSM="-I ${G2_INC4}"

#export LIBSM="${G2_LIB4} ${W3NCO_LIB4} ${BACIO_LIB4} ${JASPER_LIB} ${PNG_LIB} ${Z_LIB}"
export LIBSM="${G2_LIB4} ${W3EMC_LIB4} ${BACIO_LIB4} ${JASPER_LIB} ${PNG_LIB} ${Z_LIB}"
#export LIBSM="${LIBJPEG_LIBDIR}/libjpeg.so ${G2_LIB4} ${W3EMC_LIB4} ${BACIO_LIB4} ${LIBPNG_LIB} ${JASPER_LIB} ${PNG_LIB} ${Z_LIB}"
#export LIBSM="${LIBJPEG_LIBDIR}/libjpeg.so ${G2_LIB4} ${W3EMC_LIB4} ${BACIO_LIB4} ${JASPER_LIB} ${PNG_LIB} ${Z_LIB}"

make -f Makefile clobber
make -f Makefile
make -f Makefile install
make -f Makefile clobber

exit
