#!/bin/ksh
# split.ksh - 29 Jun 2017
#  script to split prepbufr file into several single-msgtype files
#
#  8 Mar 2010 - cp'd /meso/save/wx22dk/prepbufr/split.bufr (25 Nov 2008);
#               modified: ...
# 20 Feb 2013 - ported to WCOSS Linux platforms
# 12 Feb 2014 - reset tmp filesystem (tbase=stmpp1)
# 29 Jun 2017 - added temp dir suffix optional argument
# 30 Sep 2019 - ported to Dell phase 3; cp'd from /u/Jeff.Whiting/bin on ph2
#---
usage='gsb <(prep)bufr file> [temp dir suffix]'
bfile=${1:?"$usage"}
sfx=${2}

bver=11.3.0
echo "=== gsb (blib v$bver) === (host: $(hostname))"

here=`pwd`
[ ."`echo $bfile | cut -c1`" != ./ ] && bfile="${here}/$bfile"
[ -s $bfile ] || { echo 'gsb: bfile not found - exiting' ; exit ; }
date ; echo "bfile=`ls -l $bfile | awk '{print $NF}'"

tbase=/gpfs/dell2/stmp
tdir=sb ; [ -n "$sfx" ] && tdir=sb.$sfx
wrkdir=${tbase}/$USER/$tdir
[ -d $wrkdir ] && /bin/rm -rf $wrkdir
mkdir -p $wrkdir || { echo "gsb: error mkdir '$wrkdir' - exiting" ; exit ; }
cd $wrkdir || { echo "error cd wrkdir='$wrkdir' - exiting" ; exit ; }

#######################################################################
cat <<inputEOF > sb.f
      program splitbufr
c
c  25 Nov 2008  DKeyser   original source
c   8 Mar 2010  JWhiting  mods for personal use
c----
c
C-----------------------------------------------------------------------
C  MAIN PROGRAM SPLIT.BUFR
C
C  THIS CODE WILL COPY ALL UNIQUE MESSAGE TYPES FROM AN INPUT BUFR
C  FILE (DUMP OR PREPBUFR) TO SEPARATE OUTPUT FILES (SPLITS IT UP)
C
C-----------------------------------------------------------------------

      CHARACTER*20 FILNAME
      CHARACTER*8  SUBSET,SUBSET_LAST(30)
      DIMENSION  IRECO(51:80),ISUBO(51:80)
      LOGICAL    NEW

      DATA  IUNITI/11/,IRECI/0/,IRECO/30*0/
      DATA  SUBSET_LAST/30*'XXXXXXXX'/

      write(*,*) 'welcome to splitbufr - v03.10.10'

C  OPEN INPUT BUFR FILE - READ IN DICTIONARY MESSAGES
C   (TABLE A, B, D ENTRIES)

      CALL DATELEN(10)
      CALL OPENBF(IUNITI,'IN',IUNITI)
      PRINT 100, IUNITI
  100 FORMAT(/5X,'===> BUFR DATA SET IN UNIT',I3,' SUCCESSFULLY',
     $ ' OPENED FOR INPUT; FIRST MESSAGE CONTAINS BUFR TABLES A,B,D'/)

   10 CONTINUE

C READ IN NEXT INPUT DATA MESSAGE

      CALL READMG(IUNITI,SUBSET,IDATE,IRET)
      IF(IRET.NE.0)  GO TO 99
      CALL UFBCNT(IUNITI,IRECI,ISUB)
      PRINT 102, IRECI,SUBSET,IDATE
  102 FORMAT(/5X,'===> READ IN BUFR DATA MESSAGE NUMBER ',I5,' -- ',
     $ 'TABLE A ENTRY IS "',A8,'" AND DATE IS',I11/)
      NEW=.TRUE.
      DO II=1,30
         IF(SUBSET.EQ.SUBSET_LAST(II))  THEN
            IUNIT_OUT=50+II
            NEW=.FALSE.
            EXIT
         ELSE  IF(SUBSET_LAST(II).EQ.'XXXXXXXX')  THEN
            IUNIT_OUT=50+II
            SUBSET_LAST(II) = SUBSET
            EXIT
         END IF
      END DO

      IF(NEW)  THEN
ccc      FILNAME='${2}'//'_'//SUBSET
         FILNAME='split'//'_'//SUBSET
         OPEN(UNIT=IUNIT_OUT,FILE=FILNAME,STATUS='NEW',
     $    FORM='UNFORMATTED')
         CALL OPENBF(IUNIT_OUT,'OUT',IUNITI)
         PRINT 101, IUNIT_OUT,FILNAME
  101    FORMAT(/5X,'===> BUFR DATA SET IN UNIT',I3,
     $    ' (FILE "',A,'") SUCCESSFULLY OPENED FOR OUTPUT'/)
      END IF

      CALL COPYMG(IUNITI,IUNIT_OUT)
      CALL UFBCNT(IUNIT_OUT,IRECO(IUNIT_OUT),ISUBO(IUNIT_OUT))
      PRINT 103, SUBSET,IDATE,IUNIT_OUT,IRECO(IUNIT_OUT)
  103 FORMAT(/5X,'---> COPIED THIS MSG W/ ENTRY "',A8,'" &',
     $ ' DATE ',I11,' TO OUTPUT UNIT',I3,' - NO. OF BUFR MSGS ',
     $ 'WRITTEN TO THIS UNIT SO FAR: ',I5/)

      GO TO 10

   99 CONTINUE

C ALL MESSAGES IN WORKING BUFR FILE HAVE BEEN EXAMINED AND WRITTEN

      IRECOT = 0
      DO I = 51,80
         IRECOT = IRECOT + IRECO(I)
      ENDDO

      PRINT 3030, IRECI,IRECOT
 3030 FORMAT(/10X,'==> ALL BUFR MESSAGES READ IN: TOTAL ',
     $ 'NUMBER OF DATA MESSAGES IN INPUT BUFR FILE IS:',I5//
     $ 39X,': TOTAL NUMBER OF DATA MESSAGES WRITTEN TO OUTPUT BUFR',
     $ ' FILES IS:',I5//)

      STOP

      END

inputEOF
#######################################################################

OS=`uname`
if [ .$OS = ".AIX" ] ; then
  ncepxlf -c -O3 -qlist -qsource -qnosave -qintsize=4 -qrealsize=4 \
     -bnoquiet -qxlf77=leadzero sb.f

  ncepxlf sb.o /nwprod/lib/libbufr_4_64.a /nwprod/lib/libw3_4.a -o sb.x
  rm fort.*
###ln -sf $1          fort.11
  ln -sf $bfile      fort.11

  timeit='timex'

elif [ .$OS = ".Linux" ] ; then
  FC='ifort'
  FFLAGS='-g -traceback'
  LDFLAGS=''
# LIBS='/nwprod/lib/libbufr_v10.2.3_4_64.a'
# LIBS='/meso/noscrub/Jeff.Whiting/lib/libbufr_v10.2.3_4_64.a' # version w/ traceback
  LIBS='/gpfs/dell1/nco/ops/nwprod/lib/bufr/v11.3.0/ips/18.0.1/libbufr_v11.3.0_4_64.a'

  $FC $FFLAGS $LDFLAGS sb.f -o sb.x $LIBS > /dev/null 2>cmp.err

  unset FORT00 `env | grep "FORT[0-9]\{1,\}" | awk -F= '{print $1}'`
  export FORT11=$bfile

  timeit='time -p'
else
  echo "OS='$OS' not supported - exiting" ; exit
fi # OS = AIX or Linux

echo "splitbufr: splitting up bfile='$bfile'" > sb.out

$timeit ./sb.x >>sb.out 2> errfile
err=$?

cat errfile >> sb.out

if test "$err" -ne '0'
then
     echo "gsp: split failed - abnormal stop"

else
     echo "gsp: split successful - all done"
fi
echo "gsp: output files at ${wrkdir}/split_*"
##cat split.bufr.out

rm fort.* > /dev/null 2>&1
echo "gsb: normal end"
