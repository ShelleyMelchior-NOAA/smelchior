. /u/Shelley.Melchior/.bashrc

# Run dumpjb for dump group: aircft aircar

set -x

# check incoming args; must have 2, but 3rd is optional to run in backfill mode
test $# -lt 2 && echo "$0: <cyc> <network> (makeup)"
test $# -lt 2 && exit

cyc=$1  # 00, 06, 12, 18
network=$2  # gdas, gfs

# test if this is the prod machine
ushdir=/meso/save/$USER/svnwkspc/melchior/ush
sh $ushdir/devprodtest.sh
returnfile=/stmpp1/$USER/devprodtest.out
rc=$(cat $returnfile)
if [[ $rc != 0 ]]; then
  echo 'prod machine - exit'
  rm $returnfile
  exit
fi
rm $returnfile

export PDY=$(cat /com2/date/t${cyc}z | cut -d' ' -f3 | cut -c1-8)
#export PDY=$(sh /nwprod2/util/ush/finddate.sh $PDY d-1)
if [ ! -z "$3" ]
then
  PDY=20170502  # PDY setting when running in backfill mode
fi
CDATE=${PDY}${cyc}
CDATEm1=$(/nwprod2/util/exec/ndate -24 $CDATE)
PDYm1=$(echo $CDATEm1 | cut -c 1-8)

workdir=/ptmpp2/$USER/dumpjb_aircraft.${network}.$CDATE
if [ ! -z "$3" ] 
then
  workdir=/ptmpp2/$USER/dumpjb_aircraft.${network}.$CDATE.$$  # use pid for testing and backfill
fi
[ -d $workdir ] || mkdir -p $workdir
cd $workdir

export TMPDIR=$workdir

export LALO=0

CRAD=3.0

export DTIM_latest_aircft=+3.25
export DTIM_earliest_aircft=-3.25
export DTIM_latest_aircar=+3.25
export DTIM_earliest_aircar=-3.25

export HOMEobsproc_dump=/nwprod/obsproc_dump.v3.3.0
#export HOMEobsproc_dump=/meso/save/$USER/svnwkspc/VS/obsproc_dump
export KEEP_NEARDUP_ACFT=NO
#export obsproc_shared_bufr_dumplist_ver=v1.2.0
#export HOMEobsproc_shared_bufr_dumplist=/nwprod/obsproc_shared/bufr_dumplist.${obsproc_shared_bufr_dumplist_ver}
export HOMEobsproc_shared_bufr_dumplist=/meso/save/$USER/svnwkspc/VS/obsproc_shared/bufr_dumplist

# Pick up V7BUFR MDCRS (NC004004) in /dcomdev
# Strip subsets with test header "IUTM97 KARP" from /dcomdev since these are not in /dcom
#miscdir=/meso/save/$USER/svnwkspc/melchior/misc
#mdcrsout=/stmpp2/$USER/toss_spec_header
#mkdir -p $mdcrsout/dcomdev/us007003/$PDY/b004
#mkdir -p $mdcrsout/dcomdev/us007003/$PDYm1/b004
#sh $miscdir/toss_spec_header.sh /dcomdev/us007003/$PDY/b004/xx004 \
#   $mdcrsout/dcomdev/us007003/$PDY/b004
#sh $miscdir/toss_spec_header.sh /dcomdev/us007003/$PDYm1/b004/xx004 \
#   $mdcrsout/dcomdev/us007003/$PDYm1/b004
#if [ -e $mdcrsout/dcomdev/us007003/$PDY/b004/bufrout ]
#then
#  cp -p $mdcrsout/dcomdev/us007003/$PDY/b004/bufrout $mdcrsout/dcomdev/us007003/$PDY/b004/xx004
#fi
#if [ -e $mdcrsout/dcomdev/us007003/$PDYm1/b004/bufrout ]
#then
#  cp -p $mdcrsout/dcomdev/us007003/$PDYm1/b004/bufrout $mdcrsout/dcomdev/us007003/$PDYm1/b004/xx004
#fi
#export TANK_004004=$mdcrsout/dcomdev/us007003

#export DCOMROOT=/dcomdev
export DCOMROOT=/dcom
export TANK=${DCOMROOT}/us007003

# Remove IUAX91, IUAX96, IUAX97 from production sdmedit file so that they are not rejected
#sed -e '/IUAX91/d;/IUAX96/d;/IUAX97/d' /dcom/us007003/sdmedit > $workdir/sdmedit
#export EPRM=$workdir/sdmedit
# Remove flagging of NC004010 and LATAM data from sdmedit file
grep -ve NC004010 -ve "IUAI01 SCSC" /dcom/us007003/sdmedit > $workdir/sdmedit
export EPRM=$workdir/sdmedit

$HOMEobsproc_dump/ush/dumpjb $CDATE $CRAD aircft aircar
echo $HOMEobsproc_dump/ush/dumpjb $CDATE $CRAD aircft aircar

# copy aircar.ibm and aircft.ibm to name prep processing is expecting
# generate tstsp
if [ $network = "gdas" ]; then
  mv $workdir/aircar.ibm $workdir/${network}1.t${cyc}z.aircar.tm00.bufr_d
  mv $workdir/aircft.ibm $workdir/${network}1.t${cyc}z.aircft.tm00.bufr_d
  export tstsp=$workdir/${network}1.t${cyc}z.
else
  mv $workdir/aircar.ibm $workdir/${network}.t${cyc}z.aircar.tm00.bufr_d
  mv $workdir/aircft.ibm $workdir/${network}.t${cyc}z.aircft.tm00.bufr_d
  export tstsp=$workdir/${network}.t${cyc}z.
fi
mv $workdir/aircar.out $workdir/aircar.${network}.out
mv $workdir/aircft.out $workdir/aircft.${network}.out

exit  # For now (2/1/17) only generate dump files



# Generate cycle and network specific J-job
if [ $network = "gfs" ]; then
  local_template=/meso/save/$USER/svnwkspc/melchior/jobs/JGFS_PREP.ph2.template
else
  local_template=/meso/save/$USER/svnwkspc/melchior/jobs/JGDAS_PREP.ph2.template
fi
cp $local_template $workdir
cd $workdir

# Perform string substitution in template and save into bscript
sed "s=XCCX=${cyc}=g;s=XTSTSPX=${tstsp}=;s=XPDYX=$PDY=" $local_template > bscript

# check that the production dump files are available
# once available, submit bscript; otherwise keep sleeping for 20s for 60 iterations (20 mins).
statusfl=/com2/gfs/prod/${network}.${PDY}/${network}*.t${cyc}z.status.tm00.bufr_d
i=1
while [ "$i" -ne 0 ]
do
  if [ -f ${statusfl} ]; then
    bsub < bscript
    i=0
  else
    echo "sleep 20"
    sleep 20
    i=$((i + 1))
    if [ "$i" -eq 60 ]; then break; fi
  fi
done

exit
