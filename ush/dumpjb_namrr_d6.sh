. /u/Shelley.Melchior/.bashrc

# Run dumpjb for dump group: nexrad

set -x

# Check incoming args
test $# -ne 3 && echo "$0: <cyc> <tmmark> <network>"
test $# -ne 3 && exit

cyc=$1
tmmark=$2
network=$3 # namrr 
pid=$$

# test if this is the prod machine
# pass in $pid
ushdir=/meso/save/$USER/svnwkspc/melchior/ush
sh $ushdir/devprodtest.sh ${pid}
returnfile=/stmpp1/$USER/devprodtest.${pid}.out
rc=$(cat $returnfile)
if [[ $rc != 0 ]]; then
  echo 'prod machine - exit'
  rm $returnfile
  exit
fi
rm $returnfile

# compare 2 different date commands - diagnostic
cat /com/date/t${cyc}z
now=$(date +%Y%m%d)

export PDY=$(cat /com/date/t${cyc}z | cut -d' ' -f3 | cut -c1-8)
#export PDY=20160117 # may need to hard set the date if /com/date/t00z has already been updated

# Test that the two dates are equal
# This test is a safeguard on the occasion that /com/date/t${cyc}z is delayed in being updated.
# This most particularly will affect 00Z and 12Z runs.
#if [ ${now} -ne ${PDY} ]; then
#  echo "/com/date/t${cyc}z has not yet been updated"
#  PDY=${now}
#fi

CDATE=${PDY}${cyc}
dumptime=$(/nwprod/util/exec/ndate -$tmmark $CDATE)

workdir=/stmpp1/$USER/dumpjb_namrr_d6_${network}.${PDY}${cyc}.${tmmark}.$$
[ -d $workdir ] || mkdir -p $workdir
cd $workdir

export TMPDIR=$workdir

export HOMEobsproc_dump=/nwprod/obsproc_dump.v3.2.1

export LALO=0

CRAD=0.50

export obsproc_shared_bufr_dumplist_ver=v1.2.0
export HOMEobsproc_shared_bufr_dumplist=/nwprod/obsproc_shared/bufr_dumplist.v1.2.0

# NEXRAD tanks are hourly
# Process only those hourly tanks w/i requested dump center cycle time window

# radial wind
SKIP_006010=YES # 00Z
SKIP_006011=YES # 01Z
SKIP_006012=YES # 02Z
SKIP_006013=YES # 03Z
SKIP_006014=YES # 04Z
SKIP_006015=YES # 05Z
SKIP_006016=YES # 06Z
SKIP_006017=YES # 07Z
SKIP_006018=YES # 08Z
SKIP_006019=YES # 09Z
SKIP_006020=YES # 10Z
SKIP_006021=YES # 11Z
SKIP_006022=YES # 12Z
SKIP_006023=YES # 13Z
SKIP_006024=YES # 14Z
SKIP_006025=YES # 15Z
SKIP_006026=YES # 16Z
SKIP_006027=YES # 17Z
SKIP_006028=YES # 18Z
SKIP_006029=YES # 19Z
SKIP_006030=YES # 20Z
SKIP_006031=YES # 21Z
SKIP_006032=YES # 22Z
SKIP_006033=YES # 23Z

# reflectivity
SKIP_006040=YES # 00Z
SKIP_006041=YES # 01Z
SKIP_006042=YES # 02Z
SKIP_006043=YES # 03Z
SKIP_006044=YES # 04Z
SKIP_006045=YES # 05Z
SKIP_006046=YES # 06Z
SKIP_006047=YES # 07Z
SKIP_006048=YES # 08Z
SKIP_006049=YES # 09Z
SKIP_006050=YES # 10Z
SKIP_006051=YES # 11Z
SKIP_006052=YES # 12Z
SKIP_006053=YES # 13Z
SKIP_006054=YES # 14Z
SKIP_006055=YES # 15Z
SKIP_006056=YES # 16Z
SKIP_006057=YES # 17Z
SKIP_006058=YES # 18Z
SKIP_006059=YES # 19Z
SKIP_006060=YES # 20Z
SKIP_006061=YES # 21Z
SKIP_006062=YES # 22Z
SKIP_006063=YES # 23Z

if [ $cyc -eq 00 ]; then   # (23.50 - 00.49 Z)
   unset SKIP_006033 # radial wind  23Z
   unset SKIP_006010 # radial wind  00Z
   unset SKIP_006063 # reflectivity 23Z
   unset SKIP_006040 # reflectivity 00Z
elif [ $cyc -eq 01 ]; then   # (00.50 - 01.49 Z)
   unset SKIP_006010 # radial wind  00Z
   unset SKIP_006011 # radial wind  01Z
   unset SKIP_006040 # reflectivity 00Z
   unset SKIP_006041 # reflectivity 01Z
elif [ $cyc -eq 02 ]; then   # (01.50 - 02.49 Z)
   unset SKIP_006011 # radial wind  01Z
   unset SKIP_006012 # radial wind  02Z
   unset SKIP_006041 # reflectivity 01Z
   unset SKIP_006042 # reflectivity 02Z
elif [ $cyc -eq 03 ]; then   # (02.50 - 03.49 Z)
   unset SKIP_006012 # radial wind  02Z
   unset SKIP_006013 # radial wind  03Z
   unset SKIP_006042 # reflectivity 02Z
   unset SKIP_006043 # reflectivity 03Z
elif [ $cyc -eq 04 ]; then   # (03.50 - 04.49 Z)
   unset SKIP_006013 # radial wind  03Z
   unset SKIP_006014 # radial wind  04Z
   unset SKIP_006043 # reflectivity 03Z
   unset SKIP_006044 # reflectivity 04Z
elif [ $cyc -eq 05 ]; then   # (04.50 - 05.49 Z)
   unset SKIP_006014 # radial wind  04Z
   unset SKIP_006015 # radial wind  05Z
   unset SKIP_006044 # reflectivity 04Z
   unset SKIP_006045 # reflectivity 05Z
elif [ $cyc -eq 06 ]; then   # (05.50 - 06.49 Z)
   unset SKIP_006015 # radial wind  05Z
   unset SKIP_006016 # radial wind  06Z
   unset SKIP_006045 # reflectivity 05Z
   unset SKIP_006046 # reflectivity 06Z
elif [ $cyc -eq 07 ]; then   # (06.50 - 07.49 Z)
   unset SKIP_006016 # radial wind  06Z
   unset SKIP_006017 # radial wind  07Z
   unset SKIP_006046 # reflectivity 06Z
   unset SKIP_006047 # reflectivity 07Z
elif [ $cyc -eq 08 ]; then   # (07.50 - 08.49 Z)
   unset SKIP_006017 # radial wind  07Z
   unset SKIP_006018 # radial wind  08Z
   unset SKIP_006047 # reflectivity 07Z
   unset SKIP_006048 # reflectivity 08Z
elif [ $cyc -eq 09 ]; then   # (08.50 - 09.49 Z)
   unset SKIP_006018 # radial wind  08Z
   unset SKIP_006019 # radial wind  09Z
   unset SKIP_006048 # reflectivity 08Z
   unset SKIP_006049 # reflectivity 09Z
elif [ $cyc -eq 10 ]; then   # (09.50 - 10.49 Z)
   unset SKIP_006019 # radial wind  09Z
   unset SKIP_006020 # radial wind  10Z
   unset SKIP_006049 # reflectivity 09Z
   unset SKIP_006050 # reflectivity 10Z
elif [ $cyc -eq 11 ]; then   # (10.50 - 11.49 Z)
   unset SKIP_006020 # radial wind  10Z
   unset SKIP_006021 # radial wind  11Z
   unset SKIP_006050 # reflectivity 10Z
   unset SKIP_006051 # reflectivity 11Z
elif [ $cyc -eq 12 ]; then   # (11.50 - 12.49 Z)
   unset SKIP_006021 # radial wind  11Z
   unset SKIP_006022 # radial wind  12Z
   unset SKIP_006051 # reflectivity 11Z
   unset SKIP_006052 # reflectivity 12Z
elif [ $cyc -eq 13 ]; then   # (12.50 - 13.49 Z)
   unset SKIP_006022 # radial wind  12Z
   unset SKIP_006023 # radial wind  13Z
   unset SKIP_006052 # reflectivity 12Z
   unset SKIP_006053 # reflectivity 13Z
elif [ $cyc -eq 14 ]; then   # (13.50 - 14.49 Z)
   unset SKIP_006023 # radial wind  13Z
   unset SKIP_006024 # radial wind  14Z
   unset SKIP_006053 # reflectivity 13Z
   unset SKIP_006054 # reflectivity 14Z
elif [ $cyc -eq 15 ]; then   # (14.50 - 15.49 Z)
   unset SKIP_006024 # radial wind  14Z
   unset SKIP_006025 # radial wind  15Z
   unset SKIP_006054 # reflectivity 14Z
   unset SKIP_006055 # reflectivity 15Z
elif [ $cyc -eq 16 ]; then   # (15.50 - 16.49 Z)
   unset SKIP_006025 # radial wind  15Z
   unset SKIP_006026 # radial wind  16Z
   unset SKIP_006055 # reflectivity 15Z
   unset SKIP_006056 # reflectivity 16Z
elif [ $cyc -eq 17 ]; then   # (16.50 - 17.49 Z)
   unset SKIP_006026 # radial wind  16Z
   unset SKIP_006027 # radial wind  17Z
   unset SKIP_006056 # reflectivity 16Z
   unset SKIP_006057 # reflectivity 17Z
elif [ $cyc -eq 18 ]; then   # (17.50 - 18.49 Z)
   unset SKIP_006027 # radial wind  17Z
   unset SKIP_006028 # radial wind  18Z
   unset SKIP_006057 # reflectivity 17Z
   unset SKIP_006058 # reflectivity 18Z
elif [ $cyc -eq 19 ]; then   # (18.50 - 19.49 Z)
   unset SKIP_006028 # radial wind  18Z
   unset SKIP_006029 # radial wind  19Z
   unset SKIP_006058 # reflectivity 18Z
   unset SKIP_006059 # reflectivity 19Z
elif [ $cyc -eq 20 ]; then   # (19.50 - 20.49 Z)
   unset SKIP_006029 # radial wind  19Z
   unset SKIP_006030 # radial wind  20Z
   unset SKIP_006059 # reflectivity 19Z
   unset SKIP_006060 # reflectivity 20Z
elif [ $cyc -eq 21 ]; then   # (20.50 - 21.49 Z)
   unset SKIP_006030 # radial wind  20Z
   unset SKIP_006031 # radial wind  21Z
   unset SKIP_006060 # reflectivity 20Z
   unset SKIP_006061 # reflectivity 21Z
elif [ $cyc -eq 22 ]; then   # (21.50 - 22.49 Z)
   unset SKIP_006031 # radial wind  21Z
   unset SKIP_006032 # radial wind  22Z
   unset SKIP_006061 # reflectivity 21Z
   unset SKIP_006062 # reflectivity 22Z
elif [ $cyc -eq 23 ]; then   # (22.50 - 23.49 Z)
   unset SKIP_006032 # radial wind  22Z
   unset SKIP_006033 # radial wind  23Z
   unset SKIP_006062 # reflectivity 22Z
   unset SKIP_006063 # reflectivity 23Z
fi

echo $HOMEobsproc_dump/ush/dumpjb $dumptime $CRAD nexrad
$HOMEobsproc_dump/ush/dumpjb $dumptime $CRAD nexrad

# copy *.ibm to name prep processing is expecting
mv $workdir/nexrad.ibm $workdir/${network}.t${cyc}z.nexrad.tm${tmmark}.bufr_d

export tstsp=$workdir/${network}.t${cyc}z.

mv $workdir/nexrad.out $workdir/nexrad.${network}.out

exit

