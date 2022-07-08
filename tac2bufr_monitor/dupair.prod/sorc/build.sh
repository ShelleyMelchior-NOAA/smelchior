#!/bin/sh
set -x
set -e    # fail if an error is hit so that errors do not go unnoticed
if [ $# -eq 0 ]; then
  dir_list=*.fd
else
  dir_list=$*
fi
echo $dir_list
#source ./load_libs.rc  # use modules to set library related environment variables
source ./setlibs.rc  # use this if existing library modules don't quite cover all that is needed.

for sdir in $dir_list; do
 dir=${sdir%\/}  # chop trailing slash if necessary
 cd $dir
 make clobber
 make
 ###touch *
 ls -l
 cd ..
done


