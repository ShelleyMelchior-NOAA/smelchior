#!/bin/bash
# bdif - 23 Aug 2016
#  comparies BUFR files by dumping ascii lists
#
# modification history
#  20 Feb 2013 - original script
#  12 Feb 2014 - updated tmp dir filesystems
#  24 Sep 2014 - added ver info; added echo of wrkdir
#  23 Aug 2016 - added -f force option
#  23 Nov 2019 - ported to WCOSS ph3
# ---
ver=v08.23.16
usage="USAGE ($ver):
   bdif [options] <bufr file1> <bufr file2>
      -n nSKIP : compare 1 per every nSKIP rpts
      -f : force diff when file sizes differ"

# parse possible nSKIP arg (# of rpts to skip)
# --------------------------------------------
xargs='' ; nskip=0 ; force=no
while getopts "n:f" opt ; do
# echo "opt='$opt'  OPTARG='$OPTARG'  OPTIND='$OPTIND'"
  case `echo $opt | tr 'A-Z' 'a-z'` in
    n) nskip="`echo $OPTARG | tr 'A-Z' 'a-z'`"
       xarg1="-n $nskip"
       ;;
    f) force="yes" ;;
    *) echo "invalid option - exiting" ; exit ;;
  esac
  xargs="$xargs $xarg1"
done
shift $(($OPTIND-1))  # past optional args

#echo "OPTIND='$OPTIND' 1='$1' 2='$2'"

# parse BUFR files args
# ---------------------
bfile1=${1:?"$usage"}
bfile2=${2:?"$usage"}

[ -f $bfile1 ] || { echo "rpb: bfile1 not found ($bfile1) - exiting" ; exit ; }
[ -s $bfile1 ] || { echo "rpb: bfile1 empty ($bfile1) - exiting" ; exit ; }
[ -f $bfile2 ] || { echo "rpb: bfile2 not found ($bfile2) - exiting" ; exit ; }
[ -s $bfile2 ] || { echo "rpb: bfile2 empty ($bfile2) - exiting" ; exit ; }

s1=$(ls -log $bfile1 | awk '{print $3}')
s2=$(ls -log $bfile2 | awk '{print $3}')
[ $s1 == $s2 ] || { \
  echo -n "rpb: file sizes differ (s1='$s1' s2='$s2') - "
  [ $force == 'yes' ] && echo "forcing diff" || { echo "exiting" ; exit ; }
  }

here=`pwd`
b1=$bfile1 ; [ ."`echo $bfile1 | cut -c1`" != ./ ] && b1="${here}/$bfile1"
b2=$bfile2 ; [ ."`echo $bfile2 | cut -c1`" != ./ ] && b2="${here}/$bfile2"

#echo "debug exit  nskip='$nskip' b1='$b1' b2='$b2' s1='$s1' s2='$s2'" ; exit

TMPBASE=/gpfs/dell2/stmp
pid=$$ ; wrkdir=/$TMPBASE/$USER/bdif.$pid
mkdir $wrkdir || { echo "bd: error mkdir - exiting" ; exit 8 ; }
cd $wrkdir || { echo "bd: error cd - exiting" ; exit 9 ; }

echo "- bdif_$ver */bdif.$pid ($(date -u +'%D %T UTC'))"
# ---


( echo "comparing ascii dumps of " ; echo $bfile1 ; echo $bfile2 ) > files

# make ascii dumps of bufr files
# ------------------------------
#RMP=/u/Jeff.Whiting/util/bdif/readmp.x
RMP=/u/Shelley.Melchior/bin/util/bdif/readmp.x

rm -f fort.20 2>&1 > /dev/null
ln -sf $b1 fort.20
echo "dump1 :: $bfile1"
$RMP $xargs >dump1

rm -f fort.20 2>&1 > /dev/null
ln -sf $b2 fort.20
echo "dump2 :: $bfile2"
$RMP $xargs >dump2


# compare ascii dumps
# -------------------
echo -n "diff -sq dump1 dump2 "
[ $nskip = 0 ] && echo || echo " (comparing only 1 per every $nskip rpts)"
diff -sq dump1 dump2
rc=$?

# clean up wrking dir (unless diffs)
# ----------------------------------
if [ $rc = 0 -a skip != it ] ; then
  cd $here ; /bin/rm -rf $wrkdir
else
  echo " -- dump files left in $wrkdir/*"
fi

exit
