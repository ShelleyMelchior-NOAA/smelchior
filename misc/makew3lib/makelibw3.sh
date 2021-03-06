#!/bin/sh
###############################################################
#
#   AUTHOR:    Gilbert - W/NP11
#
#   DATE:      01/11/1999
#
#   PURPOSE:   This script uses the make utility to update the libw3 
#              archive libraries.
#              It first reads a list of source files in the library and
#              then generates a makefile used to update the archive
#              libraries.  The make command is then executed for each
#              archive library, where the archive library name and 
#              compilation flags are passed to the makefile through 
#              environment variables.
#
#   REMARKS:   Only source files that have been modified since the last
#              library update are recompiled and replaced in the object
#              archive libraries.  The make utility determines this
#              from the file modification times.
#
#              New source files are also compiled and added to the object 
#              archive libraries.
#
###############################################################
#
#    Updated by Shrinivas Moorthi on 03/05/2011
#    Updated by Boi Vuong         on 09/11/2012
#               J Whiting             2/25/2013 -- local copy
#
#     Generate a list of object files that corresponds to the
#     list of Fortran ( .f ) files in the current directory
#
export FC=${1:-ifort}
export CC=${2:-icc}
export VER=emc_v2.0.5d  #jaw
#
#  Make INCMOD directory to store all module files
#
export MODDIR=./incmod
mkdir -p $MODDIR
mkdir -p $MODDIR/w3"$VER"_4
if [ skip = it ] ; then 
mkdir -p $MODDIR/w3"$VER"_8
mkdir -p $MODDIR/w3"$VER"_d
fi # skip it
#
for i in `ls *.f` ; do
  obj=`basename $i .f`
  OBJS="$OBJS ${obj}.o"
done
#
#     Generate a list of object files that corresponds to the
#     list of C ( .c ) files in the current directory
#

for i in "`ls *.c 2>/dev/null`" ; do
  obj=`basename $i .c`
  OBJS="$OBJS ${obj}.o"
done
#
#     Remove make file, if it exists.  May need a new make file
#     with an updated object file list.
#
if [ -f make.libw3 ] ; then
  rm -f make.libw3
fi
#
#     Generate a new make file ( make.libw3), with the updated object list,
#     from this HERE file.
#
cat > make.libw3 << EOF
SHELL=/bin/sh

\$(LIB):	\$(LIB)( ${OBJS} )

.f.a:
	$FC -c \$(FFLAGS) \$<
	ar -ruv \$(AFLAGS) \$@ \$*.o
###	mv \$*.o ../../\$*\$(TAG).o
###	rm -f \$*.o

.c.a:
	$CC -c \$(CFLAGS) \$<
	ar -ruv  \$(AFLAGS) \$@ \$*.o
###	mv \$*.o ../../\$*\$(TAG).o
###	rm -f \$*.o
EOF
#
#     Update 4-byte version of libw3_v2.0.3_4.a
#
export TAG="_4"
export LIB="../../libw3"$VER"_4.a"

export FFLAGS=" -O3 -g -module $MODDIR/w3"$VER"_4 -I $MODDIR/sigio_4 -I $MODDIR/w3"$VER"_4"
#export FFLAGS=" -O3 -g -module $MODDIR/w3"$VER"_4 -I $MODDIR/sigio_big_4 -I $MODDIR/w3"$VER"_4"

CHKOUT='-ftrapuv  -check all  -fp-stack-check  -fstack-protector'
DEBUG='-g -traceback' 
MFLAGS="-module $MODDIR/w3${VER}_4 -I $MODDIR/sigio_4 -I $MODDIR/w3${VER}"
export FFLAGS=" -O3 $MFLAGS $DEBUG $CHKOUT -warn nousage"

export AFLAGS=" "
export CFLAGS=" -O3 -DLINUX"
make -f make.libw3
rm -f $LIB
#
#     Update 8-byte version of libw3_v2.0.a_8.a
#
if [ skip = it ] ; then 
export TAG="_8"
export LIB="../../libw3"$VER"_8.a"
#export FFLAGS=" -O3 -g -r8 -i8 -module $MODDIR/w3"$VER"_8 -I $MODDIR/sigio_4 -I $MODDIR/w3"$VER"_8"
export FFLAGS=" -O3 -g -r8 -i8 -module $MODDIR/w3"$VER"_8 -I $MODDIR/sigio_big_4 -I $MODDIR/w3"$VER"_8"
export AFLAGS=" "
export CFLAGS=" -O3 -DLINUX"
make -f make.libw3
rm -f $LIB
#
#     Update Double Precision (Size of Real 8-byte and default Integer) version 
#     of libw3_v2.0.3_d.a
#
export TAG="_d"
export LIB="../../libw3"$VER"_d.a"
#export FFLAGS=" -O3 -g -r8 -module $MODDIR/w3"$VER"_d -I $MODDIR/sigio_4 -I $MODDIR/w3"$VER"_d"
export FFLAGS=" -O3 -g -r8 -module $MODDIR/w3"$VER"_d -I $MODDIR/sigio_big_4 -I $MODDIR/w3"$VER"_d"
export AFLAGS=" "
export CFLAGS=" -O3 -DLINUX"
make -f make.libw3
rm -f $LIB
fi # skip it

rm -f make.libw3
