# Run dumpjb for dump group: aircft

set -x

cyc=00
PDY=$(cat /com/date/t${cyc}z | cut -d' ' -f3 | cut -c1-8)
export PDY=$(sh /nwprod/util/ush/finddate.sh $PDY d-1)
#PDY=20151104
CDATE=${PDY}${cyc}

workdir=/ptmpp1/$USER/dumpjb_aircft.$CDATE.$$
[ -d $workdir ] || mkdir -p $workdir
cd $workdir

export TMPDIR=$workdir

export LALO=0

CRAD=3.0

export DTIM_latest_aircft=+3.25
export DTIM_earliest_aircft=-3.25
export DTIM_latest_aircar=+3.25
export DTIM_earliest_aircar=-3.25

#export HOMEobsproc_dump=/nwprod/obsproc_dump.v3.2.1
export HOMEobsproc_dump=/meso/save/$USER/svnwkspc/VS/obsproc_dump
#export DUMP=/meso/save/Shelley.Melchior/svnwkspc/VS/obsproc_dump/ush/dumpjb
#export CORX=/meso/save/Shelley.Melchior/svnwkspc/VS/obsproc_dump/exec/bufr_dupcor
#export AIRX=/meso/save/Shelley.Melchior/svnwkspc/VS/obsproc_dump/exec/bufr_dupair
#export SATX=/meso/save/Shelley.Melchior/svnwkspc/VS/obsproc_dump/exec/bufr_dupsat
#export EDTX=/meso/save/Shelley.Melchior/svnwkspc/VS/obsproc_dump/exec/bufr_edtbfr
export obsproc_shared_bufr_dumplist_ver=v1.2.0
export HOMEobsproc_shared_bufr_dumplist=/nwprod/obsproc_shared/bufr_dumplist.${obsproc_shared_bufr_dumplist_ver}
#export LIST=/meso/save/Shelley.Melchior/svnwkspc/bufr_dumplist.tkt97.dump-amdar-catchall-tanks/fix/bufr_dumplist
export EPRM=/dcom/us007003/sdmedit

export DCOMROOT=/dcom
export TANK=${DCOMROOT}/us007003

$HOMEobsproc_dump/ush/dumpjb $CDATE $CRAD aircft
echo $HOMEobsproc_dump $CDATE $CRAD aircft aircar

