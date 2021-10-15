#!/bin/bash
# ufbtab_example - 24 Jan 2019
#  BUFR mnemonic quick look utility
#  based on DKeyser code (/nfsuser/*/wx22dk/prepbufr/ufbtab_example)
#
#  6 Nov 2009 - parameterized txt/dec/mix in case statement
# 30 Nov 2009 - mucked w/ mixed output format
# 16 Dec 2010 - enabled '|' delimited text/dec flds
# 29 Dec 2010 - fixed bug in '|' delimited text parsing;
#               removed cstyle parameter
# 14 Jan 2010 - fixed bug in '|' delimited text parsing (nd=0 trap)
# 21 Nov 2011 - set BLIB to current prod version (was decdev ver)
# 15 Feb 2012 - set mnem string limit to 55 (fr 50)
#  9 Nov 2012 - cfg'd for linux OS
#  5 Mar 2014 - set wrkdir to stmpp1 (using tbase var)
# 23 May 2016 - updated to latest BLIB (v11.1.0)
# 16 Sep 2016 - added hostname to version label
# 12 Sep 2018 - bash; fixed bugs (missing quotes & graves); blib 11.2.0
# 24 Jan 2019 - set numeric output to f12.5 fmt (was g14.7)
# 13 May 2019 - cfg'd for Dell phase 3
#----
#set -x
usage=" 
usage: uf_ex <bufrfile> <nems(eg, 'RPID | YEAR MNTH DAYS')> [quiet] 
       (use | to separate initial character fields from latter decimal)"

bfile=${1:?"$usage"}
nems0=${2:?"$usage"}

quiet=${3:-'no'}

bver=11.2.0
echo "=== ufbtab_ex - v18.09.12 (blib v$bver) === (host: $(hostname))"

here=`pwd -P`
if [ ."`echo $bfile | cut -c1`" != ./ ] ; then bfile="${here}/$bfile" ; fi
##echo "-- bfile='$bfile'"
echo "bfile=$(ls -l $bfile | awk '{print $NF}')"
infile=$bfile

ls $infile > /dev/null 2>&1 || \
  { echo " ! bfile='$bfile' not found - exiting" ; exit ; } 

tbase=/gpfs/dell2/stmp
wrkdir=/${tbase}/$USER/ue.$$
/bin/rm -rf $wrkdir 2> /dev/null
mkdir -p $wrkdir || { echo "ERROR- mkdir $wrkdir" ; exit ; }
cd $wrkdir

# nems0 == original character string (w/ optional pipe break)
# nems  == original character string w/ pipe removed
# nnems == total number of mnemonics requested
# ncnems == total number of mnemonics w/ character content
# ndnems == total number of mnemonics w/ decimal content
# lnems == length of orig char str w/o pipe
nems="`echo $nems0 | sed 's/ *|//g' | tr 'a-z' 'A-Z'`"
nnems=`echo $nems | wc | awk '{print $2}'`
ndnems=`echo $nems0 | cut -d'|' -f2 | wc | awk '{print $2}'`
ncnems=`echo $nems0 | cut -d'|' -f1 | wc | awk '{print $2}'`
[ $ncnems = $nnems -a $ndnems != 0 ] && { ndnems=$nnems ; ncnems=0 ; }
lnems=${#nems}  # length of string
echo "-- nems='$nems0'   n=$nnems c=$ncnems d=$ndnems l=$lnems"
[ $lnems -gt 55 ] && { echo "-- error - mnem string too long (limit 55). exiting" ; exit ; }
###echo 'debug exit' ; exit
#######################################################################

#cat <<\inputEOF > source.f
cat <<inputEOF > source.f
      program ufbtab_example

c     PARAMETER (MXTS=6,MXTB=1000000)
c     PARAMETER (MXTS=$((nnems+1)),MXTB=1000000)
c     PARAMETER (MXTS=$((nnems+1)),MXTB=8000000)
c     PARAMETER (MXTS=$((nnems)),MXTB=8000000)
      PARAMETER (MXTS=$((nnems)),MXTB=4000000)     ! MXTB x MXTS == mem issue
c     PARAMETER (MXTS=$((nnems)),MXTB=800000)     ! MXTB x MXTS == mem issue
c     PARAMETER (MXTS=$((nnems)),MXTB=100000)     ! MXTB x MXTS == mem issue

      CHARACTER*8    SUBSET,CTAB_8(MXTS,MXTB)
c     CHARACTER*80   TSTR0, TSTR
      CHARACTER*55   TSTR0, TSTR
      REAL(8)        TAB_8(MXTS,MXTB)
 
      EQUIVALENCE(TAB_8,CTAB_8)

ccccc DATA TSTR  /'RPID WMOB WMOS               '/
c     DATA TSTR0  /"$nems0"/   ! input mnemonics string (w/ special char)
c     DATA TSTR  /"$nems"/     ! input mnemonics string
      DATA TSTR0   ! input mnemonics string (w/ special char)
     & /"$nems0"/
      DATA TSTR     ! input mnemonics string
     & /"$nems"/

      DATA LUBFI /20/, LUBFJ /91/, LUERR /0/

C  Check to see if input file contains compressed BUFR messages
      write(*,*) 'welcome to ufbtab_example - v11/26/14'

c     CALL OPENBF(0,'QUIET',1)  ! debug

      CALL COMPRESS_CHECK(LUBFI,' INPUT',ICOMP)
      if ( ICOMP .le. 0 ) call errexit(ICOMP)

      CALL DATELEN(10)

      IF(ICOMP.EQ.1)  THEN

C If messeages are compressed, uncompress file because UFBTAB still
C  doesn't work with compressed BUFR messages

         print *, 'MUST UNCOMPRESS FILE IN ORDER TO USE UFBTAB'
         CALL OPENBF(LUBFI,'IN',LUBFI)
         CALL OPENBF(LUBFJ,'OUT',LUBFI)
         DO WHILE(IREADMG(LUBFI,SUBSET,IDATE).EQ.0)
            DO WHILE(IREADSB(LUBFI).EQ.0)
               CALL OPENMB(LUBFJ,SUBSET,IDATE)
               CALL UFBCPY(LUBFI,LUBFJ)
               CALL WRITSB(LUBFJ)
            END DO
         END DO

         CALL CLOSBF(LUBFI)
         CALL CLOSBF(LUBFJ)

         CALL COMPRESS_CHECK(LUBFJ,'OUTPUT',ICOMP)

         IF(ICOMP.ne.2)  THEN
            print *, '#### BUFR FILE NOT SUCCESSFULLY UNCOMPRESSED ',
     $       '(IRET = ',ICOMP,')  - STOP 88'
            CALL ERREXIT(88)
         END IF
      ELSE
         CALL COPYBF(LUBFI,LUBFJ)
      END IF

C  MAKE A TABLE
C  ------------

c     print *,' calling UFBTAB:'
      print *,' TSTR=>' // TSTR // '<'
 
      CALL UFBTAB(LUBFJ,TAB_8,MXTS,MXTB,NTAB,TSTR)

c     write(*,*) ' *** debug stop *** ',ntab ; stop

      NMAX=NTAB
c     NMAX=min(NTAB,1000)
      if (NMAX .ne. NTAB) 
     &  write(*,'(a,i4,a)') ' Output limited to ',NMAX,' lines.'
c     print *, '  NTAB=',NTAB,' MXTS=',MXTS
c    &    ,'  #c)',$ncnems, ' #d=',$ndnems
c    &    ,' "',trim(TSTR0),'"'

      if(NTAB.gt.0)  then
      DO  I=1,NMAX      

c numeric & ASCII mixed
        write(*,'(i7,$)') i                                ! record #
        do j=1,$ncnems 
cccc     if (icbfms(ctab_8(j,i),6).ne.0) ctab_8(j,i)=' -msng- '
         write(*,'(1x,i1,")",1x,a8,$)') j,ctab_8(j,i)      ! char fields
        enddo ! j=1,ncnems
        do j=$((ncnems+1)),$nnems 
c        write(*,'(1x,i1,"=",1x,g12.5,$)') j,tab_8(j,i)    ! numeric fields
c        write(*,'(1x,i1,"=",1x,g14.7,$)') j,tab_8(j,i)    ! numeric fields
         write(*,'(1x,i1,"=",1x,f12.5,$)') j,tab_8(j,i)    ! numeric fields
        enddo ! j=ncnems+1,nnems
        write(*,*)

      END DO
      end if 
      STOP
      END

C$$$  SUBPROGRAM DOCUMENTATION BLOCK
C
C SUBPROGRAM:    COMPRESS_CHECK
C   PRGMMR: D. A. KEYSER     ORG: NP22       DATE: 2002-03-05
C
C ABSTRACT: THIS SUBROUTINE DETERMINES IF AN NCEP BUFR FILE HAS
C   DATA MESSAGES THAT ARE COMPRESSED.  IT READS AND EXAMINES
C   SECTION 3 OF THE BUFR MESSAGES IN SEQUENCE UNTIL IT FINDS
C   THE FIRST MESSAGE THAT CONTAINS ACTUAL REPORT DATA (I.E.,
C   BEYOND THE DICTIONARY MESSAGES AT THE TOP, AND FOR DUMP
C   FILES BEYOND THE DUMMY MESSAGES CONTAINING THE CENTER TIME
C   AND DUMP TIME).  ONCE A DATA MESSAGE IS FOUND THE BIT
C   INDICATING COMPRESSION IN SECTION 3 IS UNPACKED AND THE
C   APPROPRIATE VALUE IS RETURNED.
C
C PROGRAM HISTORY LOG:
C 2002-03-05  D. A. KEYSER -- ORIGINAL AUTHOR
c 2004-11-23  JWhiting -- updated output messages
c                         replaced guts w/ call to BLIB routine MESCBC
c                         added Rd Error return code
c                         removed CFILE (new arg list)
C
C USAGE:   CALL COMPRESS_CHECK(LUNIT,CINOUT,IRET)
C   INPUT ARGUMENT LIST:
C     LUNIT    - UNIT NUMBER OF INPUT NCEP BUFR FILE
C     CINOUT   - CHARACTER*6 INPUT/OUTPUT FILE INDICATOR (SHOULD
C              - BE EITHER ("INPUT " OR "OUTPUT")
C
C   OUTPUT ARGUMENT LIST:
C     IRET     - COMPRESSION INDICATOR VALUE (SEE REMARKS)
C
C   INPUT FILES:
C     UNIT "LUNIT" - NCEP BUFR FILE
C
C   OUTPUT FILES:
C     UNIT 06      - STANDARD OUTPUT PRINT
C
C   SUBPROGRAMS CALLED:
C     UNIQUE:    - NONE
C     LIBRARY:
C       BUFRLIB  - MESGBC
C
C REMARKS: OUTPUT ARGUMENT IRET RETURNS WITH ONE OF THE FOLLOWING
C    VALUES:
C             -3 - ERROR READING FILE
C             -2 - FILE DOES NOT EXIST
C             -1 - FILE HAS NO DATA MESSAGES
C              0 - UNCERTAIN IF FILE IS COMPRESSED (DEFAULT)
C              1 - FILE HAS DATA MESSAGES WHICH ARE COMPRESSED
C              2 - FILE HAS DATA MESSAGES WHICH ARE UNCOMPRESSED
C
C    NOTE: ONLY THE FIRST DATA MESSAGE IS CHECKED, SO THE ASSUMPTION
C          IS THAT ALL DATA FILES ARE EITHER COMPRESSED OR
C          UNCOMPRESSED.
C
C ATTRIBUTES:
C   LANGUAGE: FORTRAN 90
C   MACHINE:  IBM SP
C
C$$$
      SUBROUTINE COMPRESS_CHECK(LUNIT,CINOUT,IRET)

      CHARACTER*6   CINOUT

      IRET = 0  ! Default return is compression uncertain

      CALL MESGBC(LUNIT, MTYP, ICOMP)

      IF (ICOMP .EQ. 1) THEN 
         write(*,100) CINOUT,MTYP
  100    FORMAT(1X,A6,' file is  C O M P R E S S E D.',
     &     '  Message type=',i4)
         IRET = 1
      ELSE IF (icomp .eq. 0) THEN
c        write(*,200) CINOUT,MTYP
  200    FORMAT(1X,A6,' file is  U N C O M P R E S S E D.',
     &     '  Message type=',i4)
         IRET = 2
      ELSE IF (icomp .eq. -1) then 
         IRET = 0
         IF (MTYP .EQ. -256) THEN 
           write(*,350) CINOUT,ICOMP,MTYP
  350      FORMAT(/1X,' ERROR!  ',A6,' file Rd ERROR.',
     &       '  ICOMP=',i3,'  MTYP=',i4,/)
           IRET = -3
         ENDIF
         write(*,300) CINOUT,ICOMP,MTYP
  300    FORMAT(1X,A6,' file has Unknown Compression.'
     &     ,'  ICOMP=',i3,'  MTYP=',i4)
      ELSE IF (icomp .eq. -3) then 
         write(*,400) CINOUT,ICOMP,MTYP
  400    FORMAT(/1X,' ERROR!  ',A6,' file Does Not Exist.'
     &     ,'  ICOMP=',i3,'  MTYP=',i4,/)
         IRET = -2
      ELSE IF (icomp .eq. -2) then 
         write(*,500) CINOUT,ICOMP,MTYP
  500    FORMAT(/1X,' ERROR!  ',A6,' file Has No Data Messages.'
     &     ,'  ICOMP=',i3,'  MTYP=',i4,/)
         IRET = -1
      ENDIF

      RETURN
      END
inputEOF
#######################################################################

OS=`uname`  # ; echo "OS='$OS'" 
if [ .$OS = ".Linux" ] ; then
  FC='ifort'
  FFLAGS='-c -integer-size 32 -real-size 32'
# LFLAGS='-bmaxdata:2000000000 -bmaxstack:256000000'
  LFLAGS=''
# BLIB='-lbufr_4_64'
# WLIB='-lw3nco_4'       # '-lw3emc_4 -lw3nco_4' 
# LIBS="-L/nwprod/lib $BLIB $WLIB"
  BLIB="/gpfs/dell1/nco/ops/nwprod/lib/bufr/v$bver/ips/18.0.1/libbufr_v${bver}_4_64.a"
  WLIB="/gpfs/dell1/nco/ops/nwprod/lib/w3nco/v2.0.6/ips/18.0.1/libw3nco_v2.0.6_4.a"
  LIBS="$BLIB $WLIB"
else 
  echo "OS='$OS' not supported - exiting" ; exit 
fi # OS = AIX or Linux
#echo "FC='$FC'  FFLAGS='$FFLAGS'"

#xlf $FFLAGS source.f  2> /dev/null
###echo -n "-- compiling ufbtab_example ... "
rc=0
$FC $FFLAGS source.f >cmp.err 2>&1
rc=$? ### ; echo "  all done, compile rc='$rc'"
if [ $rc -ne 0 ] ; then 
  { echo "$FC -c ERROR (rc='$rc') wrkdir='$wrkdir'" 
    echo "  contents of cmp.err:" ; cat cmp.err
    echo " --- exiting"
    exit ; } ; fi

# a/b lib designations
###BLIB=/nwprod/bufrlib90/bufrlib_4
###WLIB=/nwprod/w3lib90/w3lib_4

# f/s lib designations
###BLIB=/nwprod/lib/libbufr_4.a
###WLIB=/nwprod/lib/libw3_4.a

# unified bufrlib
#BLIB=/nfsuser/g01/wx22dk/source.jifs/lib/libbufr_4_64.a
#BLIB=/nwprod/lib/libbufr_4_64.a

# supersize bufrlib
#BLIB=/nwprod/lib/libbufr_s_64.a

# development bufrlib
#BLIB=/home/decdev/lib/libbufr_4_64.a
#BLIB=/home/decdev/lib/libbufr_s_64.a

# c/s lib designations
## BLIB=/nwprod/lib/libbufr_4_64.a
## WLIB=/nwprod/lib/libw3_4.a

## LFLAGS='-bmaxdata:2000000000 -bmaxstack:256000000'
#xlf source.o -o source.x $LFLAGS $BLIB $WLIB   2> /dev/null
### xlf source.o -o source.x $LFLAGS $BLIB $WLIB    > /dev/null 2> cmp.err

###echo -n "-- linking ufbtab_example ... "
rc=0
$FC source.o -o source.x $LFLAGS $LIBS  >cmp.err 2>&1
rc=$? ### ; echo "  all done, link rc='$rc'"
if [ $rc -ne 0 ] ; then { 
   echo "$FC link ERROR (rc='$rc')"
   echo "  contents of cmp.err:" ; cat cmp.err
   echo " --- exiting"
   exit ; } ; fi

# debug
#infile='Ethelbert' ; echo "infile='$infile'" ; cp -p source.o $infile
#echo "-- BLIB='$BLIB'"

if [ .$OS = ".AIX" ] ; then 
  export XLFRTEOPTS="unit_vars=yes"
  export XLFUNITS=0
  export XLFUNIT_20="$infile"
  export XLFUNIT_91="bufr_uncompressed"
elif [ .$OS = ".Linux" ] ; then 
  unset FORT000 `env | grep "FORT[0-9]\{1,\}" | awk -F= '{print $1}'`
  export FORT20="$infile"
  export FORT91="bufr_uncompressed"
fi # OS is AIX or Linux

/bin/rm ufbtab_example.out 2> /dev/null

echo '=== ufbtab_ex - v11/09/12 ===' > ufbtab_example.out
echo "-- bfile='$bfile'" >> ufbtab_example.out

echo -n "-- running ufbtab_example ... "
err=0
   ./source.x >>ufbtab_example.out 2> errfile
err=$? 
if [ $err != 0 ] ; then cat errfile >> ufbtab_example.out ; fi

if test "$err" -ne '0'
then
     echo "  FAILED (rc=$err) - abnormal stop"
     cat ufbtab_example.out | more -20 2>&1
     echo " ! workdir is '`pwd`'"

else
     echo "  successful."
     echo -n '-- output file content: '   # no carriage return in output
     [ .$quiet = .'quiet' -o .$quiet = .'QUIET' ] && \
      { echo '  ...suppressed (QUIET mode); see output file' ; } || \
      { echo ' ' ; 
        cat ufbtab_example.out | cut -c1-150 | more -20 2>&1 ; }
      

#set -x
     cd $here
     if [ ! -w $here ] ; then 
       echo '-- Unable to write output file (permission denied).'
     else  # write permission
       cp -p $wrkdir/ufbtab_example.out .
       /bin/rm -rf $wrkdir 2> /dev/null
       echo -n "-- output file:"
       ls -log ./ufbtab_example.out |\
         awk '{printf "%10s %3s %2s %5s %s",$3,$4,$5,$6,$7}'
       echo "  (`wc -l ./ufbtab_example.out | awk '{print $1}'` lines) "
     fi  # write permission
fi

echo 'normal end of script'
