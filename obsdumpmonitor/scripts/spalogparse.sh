# parse the spalog for only the entries specific to a designated date

source /u/Shelley.Melchior/.bashrc

# Set the desired date, in YYYY/MM/DD format, here:
# -------------------------------------------------
dateflag=$(date +%Y/%m/%d)
date=$(date +%Y%m%d)

# Get the total number of lines in the spalog.
# --------------------------------------------
num_spalog_lines=$(cat /com/logs/spalog | wc -l)

# Print some welcome messages.
# ----------------------------
echo
echo "Hello, the spalog is $num_spalog_lines lines long."
echo "I'm a pepper."
echo "Wouldn't you like to be a Pepper too?"
echo
echo "OK, let's check this log out..."
echo

# Initialize stuff.
# -----------------
line_num=0
within_entry=F

# start with a clean output file.
# --------------------------------
outdir="/ptmpp1/$USER/obs_dump/log"
# force a mkdir in case /ptmpp1/$USER does not exist
mkdir -p $outdir
outfile=$outdir/viewspalog.$date.log
> $outfile 

# create a temporary smaller version of spalog, limited to 1000 lines
sed '1,1000p;d' /com/logs/spalog > $outdir/spalog1000

# Start pickin' through lines.
# ----------------------------
#cat /com/logs/spalog | 
cat $outdir/spalog1000 | 
while read spalog_line
do
  line_num=$(expr $line_num + 1)

  # Let user know where we are in the spalog...
  # -------------------------------------------
  remainder=$(expr $line_num % 100)
  if [ $remainder -eq 0 ]; then
    echo Examining line number $line_num of $num_spalog_lines...
  fi # if [ $remainder -eq 0 ]

  # Stop after 3000 lines
  # ---------------------
  if [ $line_num -eq 1000 ]; then
    echo Exiting after scanning 1000 lines. 
    break 
  fi

  spalog_line_10char=$(echo $spalog_line | cut -c 1-10)

  # Compare the first ten char of the spalog line to the desired date flag.
  # -------------------------------------------------------------------------
  if [ "$spalog_line_10char" = "$dateflag" ]; then
    # Oh, look, it matches!  That's amazing... now pick out the lines for this
    # spalog entry.
    # -------------------------------------------------------------------------
    echo Jackpot!  Found a spalog entry for $dateflag.
    echo Printing to $outfile ...
    within_entry=T
  fi # if [ $spalog_line_10char = $dateflag ]
 
  # Assume (hopefully) that the line marking the end of this spalog entry 
  # starts with "=========="
  # ---------------------------------------------------------------------
  if [ "$within_entry" = "T" -a "$spalog_line_10char" = "==========" ]; then
    # separate this log entry from others with a few blank lines.
    echo $spalog_line >> $outfile 
    echo >> $outfile 
    echo >> $outfile 
    within_entry=F
  fi # if [ "$spalog_line_10char" = "==========" ]

  # If this line belongs to a spalog entry that is for the date in question,
  # output the line to the output file.
  # ------------------------------------------------------------------------
  if [ "$within_entry" = "T" ]; then
    echo $spalog_line >> $outfile 
  fi # if [ "$within_entry" = "T" ]
 
done # while read spalog_line

# remove temporary smaller version of spalog
rm $outdir/spalog1000

# generate new filestats log (listing of $logdir)
# -----------------------------------------------
logdir="/ptmpp1/$USER/obs_dump/log"
ls -l $logdir | cut -c37- > $logdir/filestats.$date.log

# generate new serverstats log (lists which wcoss machine is prod/dev)
# -----------------------------------------------------------------
rundir="/meso/save/$USER/obs_dump"
rundir="/meso/save/$USER/svnwkspc/melchior/obsdumpmonitor/scripts"
serverstatslog="$outdir/serverstats.$date.log"
sh $rundir/serverstats > $serverstatslog

# scp files from gyre to emcdev
# viewspalog, filestats, serverstats
bsub < $rundir/transfer_obsdumpmon

# Andddddddddd..... scene.
