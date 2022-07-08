set -x

module load prod_envir

RADX=$NWROOT/obsproc_dump.v3.2.1/exec/bufr_raddate
#RADX=/gpfs/hps/emc/meso/noscrub/$USER/svn/obsproc_dump.tkt-351.crayport/exec/bufr_raddate
RDT0=2016062018
DTIM=2.99

RDT0=`echo "$RDT0       0"|$RADX 2>/dev/null`
RDT1=`echo "$RDT0   $DTIM"|$RADX 2>/dev/null`
RDT2=`echo "$RDT0  -$DTIM"|$RADX 2>/dev/null`
