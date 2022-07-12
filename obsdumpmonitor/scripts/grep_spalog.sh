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
outfile=/meso/save/$USER/obs_dump/log/spalog.$date.log

> $outfile 

# Start pickin' through lines.
# ----------------------------
cat /com/logs/spalog | 
while read spalog_line
do
  line_num=$(expr $line_num + 1)

  # Let user know where we are in the spalog...
  # -------------------------------------------
  remainder=$(expr $line_num % 1000)
  if [ $remainder -eq 0 ]; then
    echo Examining line number $line_num of $num_spalog_lines...
  fi # if [ $remainder -eq 0 ]

  # Stop after 3000 lines
  # ---------------------
  if [ $line_num -eq 3000 ]; then
    echo Exiting after scanning 3000 lines. 
    exit
  fi

  spalog_line_10char=$(echo $spalog_line | cut -c 1-10)

  # Compare the first ten char of the spalog line to the desired date flag.
  # -------------------------------------------------------------------------
  if [ "$spalog_line_10char" = "$dateflag" ]; then
    # Oh, look, it matches!  That's amazing... now pick out the lines for this
    # spalog entry.
    # -------------------------------------------------------------------------
    echo Jackpot!  Found a spalog entry for $date_string.
    echo Printing to $outfile ...
    within_entry=T
  fi # if [ $spalog_line_10char = $date_string ]
 
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

# Andddddddddd..... scene.
