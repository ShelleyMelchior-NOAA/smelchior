# Run dumpjb for dump group: adpsfc (synop, synopm, synopb, synpmb) 

set -x

#PDY=20150203    # exported from trigger
#cyc=00          # exported from trigger
CDATE=${PDY}${cyc}

workdir=/ptmpp1/$USER/dump_synop.$CDATE.$$
[ -d $workdir ] || mkdir -p $workdir
cd $workdir

export TMPDIR=$workdir

export LALO=0

CRAD=3.0

export DTIM_latest_adpsfc=+2.99

export HOMEobsproc_dump=/nwprod/obsproc_dump.v3.2.0
export obsproc_shared_bufr_dumplist_ver=v1.1.0
#export LIST=/meso/save/Shelley.Melchior/svnwkspc/melchior/tac2bufr_monitor/bufr_dumplist_synop
export LIST=/meso/save/Shelley.Melchior/svnwkspc/obsproc_shared_bufr_dumplist.tkt-222.TAC2BUFR_SYNOP/fix/bufr_dumplist

export TANK=/dcomdev/us007003

$HOMEobsproc_dump/ush/dumpjb $CDATE $CRAD adpsfc

# Perform adpsfc data monitoring

cd $workdir
bufrd=adpsfc.ibm
emailfile=email.${PDY}${cyc}.synop

# Do a quick bufr inventory
echo "---- BINV ----"
which binv
binv $workdir/${bufrd} | tee $emailfile

# Add key to emailfile
echo "" >> $emailfile
echo "-- KEY --" >> $emailfile
echo "NC000000 - synopr" >> $emailfile
echo "NC000001 - synop" >> $emailfile
echo "NC000002 - synopm" >> $emailfile
echo "NC000100 - synpbr" >> $emailfile
echo "NC000101 - synopb" >> $emailfile
echo "NC000102 - synpmb" >> $emailfile

# Build tank array
tankarr=( "NC000000" "NC000001" "NC000002" "NC000100" "NC000101" "NC000102" )

# Run gsb to split $bufrd into constituents
# gsb /com/gfs/prod/gdas.${PDY}/gdas1.t${cyc}z.adpsfc.tm00.bufr_d
# output writes to /stmpp1/$USER/sb

which gsb
gsb ${workdir}/${bufrd}
for tank in ${tankarr[@]}
do
  if [[ -e "/stmpp1/$USER/sb/split_${tank}" ]] ; then
    cp /stmpp1/$USER/sb/split_${tank} $workdir/${tank}.${PDY}${cyc}
  fi
done

# Run ue on split_NC000?0? to list out stn IDs and lat/lon 
# ue /stmpp1/Shelley.Melchior/sb/split_NC000000 "RPID | CLAT CLON" quiet
# output writes to cwd/ufbtab_example.out

which ue
for tank in ${tankarr[@]}
do
  if [[ -e "${tank}.${PDY}${cyc}" ]] ; then
    if [[ ${tank} == NC0001* ]] ; then
      ue ${tank}.${PDY}${cyc} "RPID | CLATH CLONH" quiet
    else
      ue ${tank}.${PDY}${cyc} "RPID | CLAT CLON" quiet
    fi
    cp ufbtab_example.out ${tank}.${PDY}${cyc}.ue.out
    cat ${tank}.${PDY}${cyc}.ue.out | cut -d')' -f2 > ${tank}.${PDY}${cyc}.ue.out.stripped
  fi
done

# email cron summary
addy=shelley.melchior@noaa.gov
sbj="synop tanks summary - ${PDY}${cyc} - dumpjb"
mail -s "$sbj" $addy < $emailfile

# generate xml files to plot w/ google maps
xmldir=/meso/save/$USER/svnwkspc/melchior/misc/plot_dumps
#sh $xmldir/plot_dumps.sh
#rc=$?
#echo $rc

exit
