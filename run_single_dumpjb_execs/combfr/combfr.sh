set -x 

############################################################################
## This script runs bufr_combfr to combine two or more BUFR files into
## a new output BUFR file.
##    INPUT BUFR files are specified in the order they are to be
##      combined as records in the parm card (filenames only, alll are
##      assumed to be in working $DATA directory
##    OUTPUT (combined) BUFR file is written into fort.50
##
##    There is an option to use an external BUFR table to define
##     the combined output BUFR file (i.e., written into the output BUFR
##     file) -- this is invoked if:
##            fort.10 contains the name of the external BUFR table (full path)
##                         and
##            fort.15 contains the external BUFR table itself
##
##      If fort.10 is not present (or empty), then the BUFR table internal
##       to the first file in the list being combined will be written
##       into the output BUFR file
##################################################################

# Set up $DATA based on this server
dir=combfr
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

module load prod_envir

mkdir -p $DATA
cd $DATA
err=$?
[ "$err" -eq '0' ]  && rm *

COMX=$NWROOT/obsproc_dump.v3.2.1/exec/bufr_combfr
#COMX=/gpfs/hps/emc/meso/noscrub/$USER/svn/obsproc_dump.tkt-351.crayport/exec/bufr_combfr

PDY=20160620

cp $DCOMROOT/us007003/$PDY/b000/xx000 restr_synop  # input BUFR file 1
cp $DCOMROOT/us007003/$PDY/b000/xx001 synop        # input BUFR file 2

cat <<\EOFd > cards  # Specify all filenames to be combined in parm cards
restr_synop
synop
EOFd

rm fort.*

external_bufrtable=$NWROOT/decoders/decod_shared/fix/bufrtab.000

cp $external_bufrtable bufrtable
 
####echo $external_bufrtable > fort.10  # uncomment this to write external
                                        # BUFR table to output file
                                        # (else writes internal BUFR table
                                        #  from first input file to output
                                        #  file)
ln -sf  bufrtable     fort.15   # This will be ignored if fort.10 is empty
ln -sf  combfr.synop  fort.50   # Output BUFR file

time -p $COMX <cards >combfr.output
err=$?

echo "The return code for this program is $err"

ls -l
