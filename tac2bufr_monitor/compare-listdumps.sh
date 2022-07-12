# Go through listdumps.output.* to eliminate common report IDs.  What
# remains in the larger listdumps.output.* are those dupe IDs that should be
# eliminated.


wkdir=/meso/save/$USER/svnwkspc/melchior/tac2bufr_monitor
largerflorg=$wkdir/listdumps.output.aircft.p-cor-air.2014121706
largerfl=$wkdir/listdumps.output.aircft.p-cor-air.2014121706.mod
smallerflorg=$wkdir/listdumps.output.aircft.l-cor-p-air.2014121706
smallerfl=$wkdir/listdumps.output.aircft.l-cor-p-air.2014121706.mod

# Modify the 2 listdumps.output files to remove non-needed lines.
# sed -e '/L1:/d;/ADDIT-/d;/RSRD/d' listdumps.output.aircft.p-cor-air.2014121706.mod > listdumps.output.aircft.p-cor-air.2014121706.mod1
sed -e '/L1:/d;/ADDIT-/d;/RSRD/d;1,108d' $largerflorg > $largerfl
head --lines=-29 $largerfl > $wkdir/test
mv $wkdir/test $largerfl
sed -e '/L1:/d;/ADDIT-/d;/RSRD/d;1,108d' $smallerflorg > $smallerfl
head --lines=-29 $smallerfl > $wkdir/test
mv $wkdir/test $smallerfl


cnt=0
cat $largerfl | while read line
do
  rptid=$(echo "$line" | cut -f1 -d" ") 
  echo "$line"
  echo ">$rptid<"
#  test=$(grep "$line" $smallerfl | wc -l)
#  echo $test
  grep -o $rptid $smallerfl | wc -l
  echo $?
  if [ -z $? ]; then
    echo "rpt only in largerfile"
  else
    echo "rpt in both files"
  fi
#  grep -o $rptid $smallerfl | wc -l
#  echo $?
# BALLLS!!  This isn't working right ... ??!!
#  if [ $? -eq 0 ]; then
#    cnt=$((cnt+1))
#   echo $cnt
#  fi 
done
