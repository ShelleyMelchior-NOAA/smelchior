set -x

if test $# -ne 2
then
  echo "usage: $0 </dcomdev/us007003/YYYYMMDD/b004/xx004> <location/for/bufrout>"
  exit
fi

stmp_root=/stmpp2
DATA_toss_spec_header=${DATA_toss_spec_header:-$stmp_root/$USER/toss_spec_header}

mkdir -p $DATA_toss_spec_header
cd $DATA_toss_spec_header
ierr=$?

[ $ierr -eq 0 ]  &&  rm *

cp $1 bufrin
bufrout=$2


#######################################################################

set +x
cat <<\inputEOF > toss_spec_header.f

       PROGRAM toss_spec_header

C-----------------------------------------------------------------------
C  MAIN PROGRAM toss_spec_header
C
C  THIS CODE WILL READ THOUGH AN INPUT BUFR FILE (NORMALLY A TANK) (SPECIFIED
C   AS POSITIONAL PARAMETER 1 - FULL PATH) AND CHANGE TOSS ALL SUBSETS WITH A
C   SPECIFIED (IN-CODE) BULLETIN HEADER AND ORIGINATOR
C-----------------------------------------------------------------------

      REAL*8  RBULL_8(2), BMISS, GETBMISS
      CHARACTER*8  SUBSET
      CHARACTER*8  BORG
      CHARACTER*8  BUHD

      EQUIVALENCE (RBULL_8(1),BUHD)
      EQUIVALENCE (RBULL_8(2),BORG)

      DATA  LUBFI/21/,LUBFJ/51/

C  On WCOSS should always set BUFRLIB missing (BMISS) to 10E8 to avoid
C   overflow when either an INTEGER*4 variable is set to BMISS or a
C   REAL*8 (or REAL*4) variable that is missing is NINT'd
C  -------------------------------------------------------------------
ccccc CALL SETBMISS(10E10_8)
      CALL SETBMISS(10E8_8)
      BMISS=GETBMISS()
      print *
      print *, 'BUFRLIB value for missing is: ',bmiss
      print *

      CALL DATELEN(10)
      CALL OPENBF(LUBFI,'IN ',LUBFI)
      CALL OPENBF(LUBFJ,'OUT',LUBFI)
      DO WHILE(IREADMG(LUBFI,SUBSET,IDATE).EQ.0)
         DO WHILE(IREADSB(LUBFI).EQ.0)
            CALL UFBINT(LUBFI,RBULL_8,2,1,NLVb,'BUHD BORG')
            IF(NLVb.EQ.0.OR.IBFMS(RBULL_8(1)).NE.0.OR.
     $                      IBFMS(RBULL_8(2)).NE.0)  THEN
               PRINT *, 'STOP 89 - COULDN''T OBTAIN A WMO BULLETIN ',
     $          'HEADER/ORIGINATOR'
               CALL ERREXIT(89)
            END IF
            IF(BUHD.EQ.'IUTM97'.AND.BORG.EQ.'KARP') THEN
               cycle
            END IF
            IF(BUHD.EQ.'IUAX01'.AND.BORG.EQ.'MMMX') THEN
               cycle
            END IF
            IF(BUHD.EQ.'IUAX06'.AND.BORG.EQ.'KARP') THEN
               cycle
            END IF
            IF(BUHD.EQ.'IUAX92'.AND.BORG.EQ.'KARP') THEN
               cycle
            END IF
            CALL OPENMB(LUBFJ,SUBSET,IDATE)
            CALL UFBCPY(LUBFI,LUBFJ)
            CALL WRITSB(LUBFJ)
         END DO
      END DO

      CALL CLOSBF(LUBFI)
      CALL CLOSMG(LUBFJ)
      CALL CLOSBF(LUBFJ)

      STOP
 
      END

inputEOF
set -x
#######################################################################

ifort -c -O2 -convert big_endian -list -auto toss_spec_header.f

ifort toss_spec_header.o -L/nwprod/lib -lw3nco_4 -lbufr_4_64 -o toss_spec_header

rm fort.*


ln -sf bufrin     fort.21
ln -sf bufrout    fort.51
time -p $stmp_root/$USER/toss_spec_header/toss_spec_header > $stmp_root/$USER/toss_spec_header/toss_spec_header.out 2> $stmp_root/$USER/toss_spec_header/errfile
err=$?

cat $stmp_root/$USER/toss_spec_header/errfile >> $stmp_root/$USER/toss_spec_header/toss_spec_header.out
cat $stmp_root/$USER/toss_spec_header/toss_spec_header.out

rm fort.*

if test "$err" -ne '0'
then
     echo "toss_spec_header failed - abnormal stop"
     exit 99

else
     echo "toss_spec_header successful - all done"
     cp bufrout $bufrout
fi
exit 0

