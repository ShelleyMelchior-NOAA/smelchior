set -x

module load prod_envir

#DUEX=$NWROOT/obsproc_dump.v3.2.1/exec
DUEX=/gpfs/hps/emc/meso/noscrub/$USER/svn/obsproc_dump.tkt-351.crayport/exec

### THIS SCRIPT WORKS FOR dupsat, dupcor, dupmar, dupmrg, duprad AND dupsst
### DOES NOT WORK FOR dupair OR dupshp

## choose the dup-check code you want to run here

DUPX=$DUEX/bufr_dupsat

# Set up $DATA based on this server
dir=dupcheck
this_srvr=$(hostname -s | cut -c1)
if [ "$this_srvr" = "g" ]; then     # WCOSS gyre
  DATA=/stmpp1/$USER/$dir
elif [ "$this_srvr" = "t" ]; then   # WCOSS tide
  DATA=/stmpp1/$USER/$dir
elif [ "$this_srvr" = "l" ]; then   # Cray luna
  DATA=/gpfs/hps/stmp/$USER/$dir
elif [ "$this_srvr" = "s" ]; then   # Cray surge
  DATA=/gpfs/hps/stmp/$USER/$dir
else
  echo "Unknown server!"
  exit
fi

mkdir -p $DATA
cd $DATA
err=$?
[ "$err" -eq '0' ]  && rm *



# set LALO is geographical check is to be performed -- > used only by dupsat
#export LALO=F$NWROOT/obsproc_dump.v3.2.1/fix/nam_expdomain_halfdeg_imask.gbl
export LALO=F/gpfs/tp1/nco/ops/nwprod/obsproc_dump.v3.2.1/fix/nam_expdomain_halfdeg_imask.gbl

# input file:
#   FIRST RECORD CONTAINS INPUT FILE NAME
#   SECOND RECORD CONTAINS OUTPUT FILE NAME
#   OPTIONAL THIRD RECORD CONTAINS TIME WINDOW TRIMMING SPECIFICATIONS
#      (THE YYYYMMDDHH<.HH> DATE OF THE EARLIEST TIME TO DUMP AND THE
#       YYYYMMDDHH<.HH> DATE OF THE LATEST TIME TO DUMP)
#   OPTIONAL FOURTH RECORD CONTAINS DUP-CHECKING TOLERANCE LIMITS
#                             (DEXY DOUR DMIN DSEC                - dupsat)
#                             (DEXY DOUR DMIN                     - dupcor)
#                             (DEXY DDAY,DOUR,DMIN                - dupmar, dupmrg)
#                             (DEXY DDAY DOUR DMIN DSEC DTB7 DTB8 - duprad)
#                             (DEXY DSST DTYP                     - dupsst)
#      (IF FOURTH RECORD IS MISSING, DEFAULT DUP-CHECKING TOLERANCE LIMITS ARE
#       USED, IF THIRD RECORD IS ALSO MISSING, NO TIME WINDOW TRIMMING IS PERFORMED)

RDT1=2016062009.00
RDT2=2006062014.99
line3="$RDT1 $RDT2"
#####line3=""

cp -p $DCOMROOT/us007003/20160620/b021/xx033 raw_input_file

cat <<eof > stdin
raw_input_file
dup_checked
$line3
eof


time -p $DUPX < stdin > dupcheck.out 2>&1

