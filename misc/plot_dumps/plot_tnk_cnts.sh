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
DATA=/ptmpp1/$USER/plot_tnkcnts
mkdir -p $DATA
cd $DATA
errcd=$?
#[ errcd -eq 0 ] && rm -rf plot_tnkcnts.*
export DATA=${DATA}

# Define text file (used to write dat and ctl files)
txtfl=${DATA}/$1.10dycnt.txt
if [ -f ${txtfl} ]
then
  rm ${txtfl}
fi
touch ${txtfl}

# Define tank dir
b=$(echo $1 | cut -c3-5)
xx=$(echo $1 | cut -c6-8)
tankdir=/dcomdev/us007003
#tankdir=/dcom/us007003
if [ "$b" == "004" ]
then
  tankdir=/dcom/us007003
fi
echo $tankdir

# Set up past 10 days
PDY=$(cat /com/date/t00z | cut -d' ' -f3 | cut -c1-8)
#PDYctl="notset"
n=10
while [ $n -ge 1 ]
#while [ $n -ge 0 ]
do
  # Get date formatted for ctl file
  if [ $n -eq 10 ]
  then
    PDYctl=$(sh /nwprod/util/ush/finddate.sh $PDY d-${n})
    mo=$(date -d ${PDYctl} +%b)
    dy=$(date -d ${PDYctl} +%d)
    yr=$(date -d ${PDYctl} +%Y)
    echo $mo $dy $yr
  fi 
  PDYm=$(sh /nwprod/util/ush/finddate.sh $PDY d-${n})
# if [ $n -eq 0 ]
# then
#   PDYm=$PDY
# fi
  tankfile=${tankdir}/${PDYm}/b${b}/xx${xx}
  # run go_chkdat to parse report counts 
  if [ -f ${tankfile} ]
  then
    go_chkdat ${tankfile} > ${DATA}/go_chkdat.out
    sed "s/$1//" <${DATA}/go_chkdat.out >${DATA}/temp
    sed 's/^ *//g' <${DATA}/temp >${DATA}/temp2
    count=$(cat ${DATA}/temp2  | cut -d' ' -f1)
    rm ${DATA}/temp ${DATA}/temp2
    # write to text file
    echo $PDYm $count >> ${txtfl}
#   # Get date formatted for ctl file
#   if [ "$PDYctl" = "notset" ]
#   then
#     PDYctl=$(sh /nwprod/util/ush/finddate.sh $PDY d-${n})
#     mo=$(date -d ${PDYctl} +%b)
#     dy=$(date -d ${PDYctl} +%e)
#     yr=$(date -d ${PDYctl} +%Y)
#     echo $mo $dy $yr
#   fi 
  else
    echo "DNE: ${tankfile}"
    # maybe add logic for days when tank is empty?
    echo $PDYm 0 >> ${txtfl}
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
$rundir/plot_tnk_cnts.tcl $txtfl $1 

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

# Run grads to generate graphic
if [ -f ${ctlfl} ]
then
  grads -lbcx "$rundir/plot_tnk_cnts.gs $ctlfl $1"
fi

# scp png file to webserver
# managed from driver script in $rundir/transfer_plot_tnk_cnts.

exit
