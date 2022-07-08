#!/bin/sh

# Driver script to read through a BUFR tank file to plot report counts 

# Takes 1 argument:
# 1 - tank (e.g. NC004003)

. /u/$USER/.bashrc

set -x

# Test incoming args; trap errors
test $# -ne 1 && echo "$0: <tank>"
test $# -ne 1 && exit

# Set up working directory
DATA=/gpfs/dell2/ptmp/$USER/plot_tnkcnts
mkdir -p $DATA
cd $DATA
errcd=$?
#[ errcd -eq 0 ] && rm -rf plot_tnkcnts.*
export DATA=${DATA}

module load ips/18.0.1.163
module load impi/18.0.1
module load prod_util/1.1.0
module load prod_envir/1.1.0
module load bufr/11.3.0
module load w3nco/2.0.6
module load w3emc/2.3.0

# Define text file (used to write dat and ctl files)
txtfl=${DATA}/counts.txt
if [ -f ${txtfl} ]
then
  rm ${txtfl}
fi
touch ${txtfl}

# Define tank dir
b=$(echo $1 | cut -c3-5)
xx=$(echo $1 | cut -c6-8)
tankdir=$DCOMROOT/dev
#tankdir=$DCOMROOT/prod

# Set up past 10 days
PDY=$(cat $COMROOT/date/t00z | cut -d' ' -f3 | cut -c1-8)
PDYctl="notset"
n=10
while [ $n -ge 1 ]
do
  PDYm=$(sh $UTILROOT/ush/finddate.sh $PDY d-${n})
  tankfile=${tankdir}/${PDYm}/b${b}/xx${xx}
  # run go_chkdat to parse report counts 
  if [ -f ${tankfile} ]
  then
    go_chkdat ${tankfile} > ${DATA}/go_chkdat.out
    count=$(cat ${DATA}/go_chkdat.out | awk -F'   ' '{print $2}' | cut -d' ' -f1)
    # write to text file
    echo $PDYm $count >> ${txtfl}
    # Get date formatted for ctl file
    if [ "$PDYctl" = "notset" ]
    then
      PDYctl=$(sh $UTILROOT/ush/finddate.sh $PDY d-${n})
      mo=$(date -d ${PDYctl} +%b)
      dy=$(date -d ${PDYctl} +%e)
      yr=$(date -d ${PDYctl} +%Y)
      echo $mo $dy $yr
    fi 
  else
    echo "DNE: ${tankfile}"
    (( n-- ))
    continue
  fi
  (( n-- ))
done

# Determine time steps for ctl file
steps=$(wc -l < ${txtfl})
echo $steps

set +x

# Run tcl script to build dat file
rundir=/meso/save/$USER/svnwkspc/melchior/misc/plot_dumps
rundir=/gpfs/dell2/emc/obsproc/noscrub/$USER/gitstatic/EMC_obsproc_melchior/misc/plot_dumps
$rundir/plot_tnk_cnts.tcl.ph3 $txtfl $1 

# Write ctl file
ctlfl=${DATA}/$1.10dycnt.ctl
if [ -f ${ctlfl} ]
then
  rm ${ctlfl}
fi
datfl=${DATA}/$1.10dycnt.dat
echo "dset $datfl" > ${ctlfl}
echo "title $1 $steps day count" >> ${ctlfl} 
echo "undef 1e+31" >> ${ctlfl}
echo "xdef 1 LEVELS 0" >> ${ctlfl}
echo "ydef 1 LEVELS 0" >> ${ctlfl}
echo "zdef 1 LEVELS 0" >> ${ctlfl}
echo "tdef ${steps} LINEAR 00Z${dy}${mo}${yr} 1dy" >> ${ctlfl}
echo "vars 1" >> ${ctlfl}
echo "count 1 0 Count of obs in tank $1" >> ${ctlfl}
echo "ENDVARS" >> ${ctlfl}

exit
# Heredoc fortran source

#####6###1#########2#########3#########4#########5#########6#########7##
#cat <<inputEOF > plot_dump.f ; { xlf -qmaxmem=-1 plot_dump.f -o plot_dump.x $LIBS > /dev/null 2>cmp.err ; } && ./plot_dump.x
#cat <<\inputEOF > plot_dumps.f
cat <<inputEOF > plot_tnkcnts.f

C Main Program 

      program plot_tnkcnts

C     This code reads through an input text file that contains report 
C     counts for a specified tank.

      integer  cnt,date

C     Open log output file to write to
      open(unit=12,
     . file="$DATA/counts.log")

C     Write GrADS dat file to plot lat/lon markers
      open(8,name="$DATA/counts.txt")
      open(unit=14,
     .file="$DATA/$1.10dycnt.dat",
     .form="binary",recordtype="stream")
C    .form="unformatted",recordtype="stream")
10    read(8,9000,end=90) date,cnt
9000  format (i8,1x,i5)
C     write(14) date,cnt
      write(14) cnt
      write(12,9000) date,cnt
      go to 10
90    continue
      close(8)               ! close input txt file
      close(14)              ! close output dat file

C     Write GrADS ctl file
      open(unit=15,
     .file="$DATA/$1.10dycnt.ctl")
      write(15,'(a,$)') 'dset $DATA'
      write(15,'(a)') '/$1.10dycnt.dat'
      write(15,'(a)') 'title $1 10-day count'
      write(15,'(a)') 'undef 1e+10'
C     write(15,'(a)') 'OPTIONS  big_endian'
      write(15,'(a)') 'xdef 1 LEVELS 0'
      write(15,'(a)') 'ydef 1 LEVELS 0'
      write(15,'(a)') 'zdef 1 LEVELS 0'
      write(15,'(a)') 'tdef ${steps} LINEAR 00Z${dy}${mo}${yr} 1dy'
C     write(15,'(a)') 'VARS  2'
      write(15,'(a)') 'vars 1'
C     write(15,'(a)') 'pdy   1 0 pdy for tank count'
      write(15,'(a)') 'count 1 0 Count of obs in tank'
      write(15,'(a)') 'ENDVARS'
      close(15)              ! close output ctl file

      close(12)              ! close output log file
      close(lunin)

      stop

      end  ! program plot_tnkcnts

inputEOF
set -x
#####6###1#########2#########3#########4#########5#########6#########7##

#ifort -c -O2 -convert big_endian -list -auto plot_tnkcnts.f
ifort -c -O2 -list -auto plot_tnkcnts.f

ifort plot_tnkcnts.o /nwprod/lib/libbufr_v10.2.5_4_64.a /nwprod/lib/libw3nco_4.a -o plot_tnkcnts

rm fort.*

#ln -sf $1 fort.11
time -p ./plot_tnkcnts > $DATA/plot_tnkcnts.out 2> errfile
err=$? 

cat errfile >> $DATA/plot_tnkcnts.out

echo "err='$err'  working dir = '$DATA'"

if test "$err" -ne '0'
then
  echo "plot_tnkcnts.sh failed - abnormal stop"
else
  echo "plot_tnkcnts.sh successful - normal end of script"
fi

exit
# Generate station map for GrADS
#ctlfile=$DATA/plot_dump.ctl
ctlfile=$DATA/$2.$3.ctl
stnmap -i $ctlfile
if [ -f $ctlfile ]
then
  # Run GrADS scripts to generate png image
  echo "run GrADS scripts"
  rundir=/meso/save/$USER/svnwkspc/melchior/misc/plot_dumps
  grads -lbcx "$rundir/plot_dumps_grads.gs $ctlfile $2 $3"
fi

# scp file to webserver
if [ -f $DATA/$2.$3.png ]
then 
  echo $DATA/$2.$3.png
  webserver=emc-ls-emcdev.ncep.noaa.gov
  user=smelchior
  path=var/www/html/smelchior/obsdumpmonitor/plots/grads
  dir=$(echo $2 | cut -c3-5)
  echo "DISABLED until emcdev is stable and code is adjusted to use transfer queue."
  echo scp $DATA/${2}.${3}*.png ${user}@${webserver}:/${path}/b${dir}
#  scp $DATA/${2}.${3}*.png ${user}@${webserver}:/${path}/b${dir}
fi

# end plot_dumps.sh
