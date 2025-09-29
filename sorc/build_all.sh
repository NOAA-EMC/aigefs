#!/bin/sh
set -eux

# to use debug flags export DEBUG='Y' before compiling
export DEBUG=${DEBUG:-'N'}

build_dir=`pwd`
logs_dir=$build_dir/logs
if [ ! -d $logs_dir  ]; then
  echo "Creating logs folder"
  mkdir $logs_dir
fi

# Check final exec folder exists
if [ ! -d "../exec" ]; then
  echo "Creating ../exec folder"
  mkdir ../exec
fi

#------------------------------------
# INCLUDE PARTIAL BUILD 
#------------------------------------

#. ./partial_build.sh

#------------------------------------
# build aigefs_ensstat
#------------------------------------
echo " .... Building gefs_ensstat .... "
./build_aigefs_ensstat.sh > $logs_dir/build_aigefs_ensstat.log 2>&1

#------------------------------------
# build virtual environment
#------------------------------------
echo " .... Building virtual environment .... "
./build_venv.sh > $logs_dir/build_venv.log 2>&1


echo;echo " .... Build system finished .... "

exit 0

