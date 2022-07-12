. /u/Shelley.Melchior/.bashrc

# Run dumpjb for dump group: aircft aircar

set -x

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

cyc=12
PDY=$(cat /com/date/t${cyc}z | cut -d' ' -f3 | cut -c1-8)
#export PDY=$(sh /nwprod/util/ush/finddate.sh $PDY d-1)
CDATE=${PDY}${cyc}

#workdir=/ptmpp1/$USER/dumpjb_aircraft.$CDATE.$$  # use pid for testing
workdir=/ptmpp1/$USER/dumpjb_aircraft.$CDATE
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
#export DUMP=/meso/save/$USER/svnwkspc/VS/obsproc_dump/ush/dumpjb
export DUMP=/meso/save/$USER/svnwkspc/VS/obsproc_dump/ush/dumpjb
export DUEX=/meso/save/$USER/svnwkspc/VS/obsproc_dump/exec
#export CORX=/meso/save/$USER/svnwkspc/VS/obsproc_dump/exec/bufr_dupcor
#export AIRX=/meso/save/$USER/svnwkspc/VS/obsproc_dump/exec/bufr_dupair
#export EDTX=/meso/save/$USER/svnwkspc/VS/obsproc_dump/exec/bufr_edtbfr
export obsproc_shared_bufr_dumplist_ver=v1.2.0
export HOMEobsproc_shared_bufr_dumplist=/nwprod/obsproc_shared/bufr_dumplist.v1.2.0
export LIST=/meso/save/$USER/svnwkspc/VS/obsproc_shared/bufr_dumplist/fix/bufr_dumplist

# Pick up V7BUFR MDCRS (NC004004) in /dcomdev
# Strip subsets with test header "IUTM97 KARP" from /dcomdev since these are not in /dcom
miscdir=/meso/save/$USER/svnwkspc/melchior/misc
sh $miscdir/toss_spec_header.sh /dcomdev/us007003/$PDY/b004/xx004
mdcrsout=/stmpp1/$USER/toss_spec_header
if [ -e $mdcrsout/bufrout ]
then
  mkdir -p $mdcrsout/dcomdev/us007003/$PDY/b004
  if [ -d $mdcrsout/dcomdev/us007003/$PDY/b004 ]
  then
    cp -p $mdcrsout/bufrout $mdcrsout/dcomdev/us007003/$PDY/b004/xx004
    export TANK_004004=$mdcrsout/dcomdev/us007003
  fi
fi

export TANK=/dcom/us007003
#export TANK=/dcomdev/us007003

#$HOMEobsproc_dump/ush/dumpjb $CDATE $CRAD aircft
echo $DUMP $CDATE $CRAD aircft aircar
$DUMP $CDATE $CRAD aircft aircar

# copy aircar.ibm and aircft.ibm to name prep processing is expecting
# Depending on when process ran, the new name will include gfs or gdas1
hr=$(date +%H)
if [ $hr -eq 5 -o $hr -eq 11 -o $hr -eq 17 -o $hr -eq 23 ]; then
  network=gdas1
elif [ $hr -eq 2 -o $hr -eq 8 -o $hr -eq 14 -o $hr -eq 20 ]; then
  network=gfs
else
  echo "oops - this shouldn't happen"
fi
mv $workdir/aircar.ibm $workdir/${network}.t${cyc}z.aircar.tm00.bufr_d
mv $workdir/aircft.ibm $workdir/${network}.t${cyc}z.aircft.tm00.bufr_d
mv $workdir/aircar.out $workdir/aircar.${network}.out
mv $workdir/aircft.out $workdir/aircft.${network}.out
