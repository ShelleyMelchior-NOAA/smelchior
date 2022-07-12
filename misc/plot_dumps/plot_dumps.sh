#!/bin/sh

# Driver script to read through a BUFR dump file to plot specific parameters
# to visualize spatial domain/extent and data availability.

# Takes 1 argument:
# 1 - full path for bufr dump file

set -x

# Test incoming args; trap errors
test $# -ne 1 && echo "$0: <bufr dump file> "
test $# -ne 1 && exit

# Set up working directory
DATA=/ptmpp1/$USER/plot_dumps
mkdir -p $DATA
cd $DATA
errcd=$?
#[ errcd -eq 0 ] && rm -rf plot_dumps.*
export DATA=${DATA}

# Set up XLF options
#export XLFRTEOPTS="unit_vars=yes"
#export XLFUNITS=0
#export XLFUNIT_11="$1"

# Set up libraries
#LIBS='-L/nwprod/lib -lw3_4 -lbufr_v10.1.0_4_64'

set +x

# Heredoc fortran source

#####6###1#########2#########3#########4#########5#########6#########7##
#cat <<inputEOF > plot_dump.f ; { xlf -qmaxmem=-1 plot_dump.f -o plot_dump.x $LIBS > /dev/null 2>cmp.err ; } && ./plot_dump.x
#cat <<\inputEOF > plot_dumps.f
cat <<inputEOF > plot_dumps.f

C Main Program 

      program plot_bufrdump

C     This code reads through an input bufr dump file and plots specific 
C     parameters to visualize the spatial domain/extent of the data set.

      parameter  (mxmn=3,mxlv=75000)
      character*8  subset,stn(mxmn) 
      character*80  mnstr,outfile
      integer  cnt,doi
      real*8  dat(mxmn,mxlv),datbl(mxmn)

      equivalence (datbl,stn)

C     Open bufr dump file to read out: lat, long
      lunin=11
      open(lunin,form='UNFORMATTED')

C     Open log output file to write to
      open(unit=12,file="$DATA/log")

      call datelen(10)

      call openbf(lunin,'IN',lunin)

C     Loop through input bufr dump file, reading in one bufr msg at a
C     time (e.g., 'NC005044')
      cnt=0
C     For JMA subsets from SATWND bufr_d file
C     do while (ireadmg(lunin,subset,idate).eq.0)
C       if (
C    &      subset.eq.'NC005041'.or.
C    &      subset.eq.'NC005042'.or.
C    &      subset.eq.'NC005043'.or.
C    &      subset.eq.'NC005044'.or.
C    &      subset.eq.'NC005045'.or.
C    &      subset.eq.'NC005046'
C    &     ) then
C     For SFCSHP subsets from SFCSHP bufr_d file
C     do while (ireadmg(lunin,subset,idate).eq.0)
C       if (
C    &      subset.eq.'NC001001'.or.
C    &      subset.eq.'NC001002'.or.
C    &      subset.eq.'NC001003'.or.
C    &      subset.eq.'NC001004'.or.
C    &      subset.eq.'NC001005'.or.
C    &      subset.eq.'NC001007'.or.
C    &      subset.eq.'NC001013'
C    &     ) then
C     For AIRCAR subsets from AIRCAR bufr_d file
C     do while (ireadmg(lunin,subset,idate).eq.0)
C       if (
C    &      subset.eq.'NC004004'.or.
C    &      subset.eq.'NC004007'
C    &     ) then
C     For AIRCFT subsets from AIRCFT bufr_d file
      do while (ireadmg(lunin,subset,idate).eq.0)
        if (subset.eq.'NC004003'.or.
     .      subset.eq.'NC004103') then
C    &      subset.eq.'NC004001'.or.
C    &      subset.eq.'NC004002'.or.
C    &      subset.eq.'NC004003'.or.
C    &      subset.eq.'NC004006'.or.
C    &      subset.eq.'NC004008'.or.
C    &      subset.eq.'NC004009'.or.
C    &      subset.eq.'NC004012'.or.
C    &      subset.eq.'NC004013'
C    &     ) then
        end if
C     For VADWND subsets from VADWND bufr_d file
C     do while (ireadmg(lunin,subset,idate).eq.0)
C       if (
C    &      subset.eq.'NC002008'
C    &     ) then
C     For MSONET subsets from MSONET bufr_d file
C     do while (ireadmg(lunin,subset,idate).eq.0)
C       if (
C    &      subset.eq.'NC255101'
C    &     ) then
C     For SYNOP subsets
      do while (ireadmg(lunin,subset,idate).eq.0)    
        if (subset.eq.'NC000000'.or.
     .      subset.eq.'NC000001'.or. 
     .      subset.eq.'NC000002'.or. 
     .      subset.eq.'NC000100'.or. 
     .      subset.eq.'NC000101'.or. 
     .      subset.eq.'NC000102') then 
          write(12,*) 
          write(12,*) '---START ', subset, idate, '---'
          write(12,*) 
C         Loop through this bufr msg reading in one report at at time
          do while (ireadsb(lunin).eq.0)
C           Use ufbint to pull various parameters from report
C           Return lat/lon and stn id
            if (subset.eq.'NC000100'.or.
     .          subset.eq.'NC000101'.or.
     .          subset.eq.'NC000102') then
              mnstr='CLATH CLONH RPID'
            else
              mnstr='CLAT CLON RPID'
            end if
            call ufbint(lunin,datbl,3,1,iret,mnstr)
C           write(12,*) datbl(1),datbl(2),stn(3)
            cnt=cnt+1
            dat(1,cnt)=datbl(1)
            dat(2,cnt)=datbl(2)
            dat(3,cnt)=datbl(3)
          end do
        end if
      end do

      write(12,*) 
      write(12,*) '---cnt = ', cnt, '---'
      write(12,*) 

      call closbf(lunin)     ! close input bufr dump file

C     Write xml file to plot lat/lon markers
C     open(unit=13,file="$DATA/plot_dump.xml")
      open(unit=13,
     . file="$DATA/plot_dump.xml")
      write(13,'(a)') '<?xml version="1.0"?>'
      write(13,'(a)') '<markers>'
      do doi=1,cnt
        write(13,'(a,$)') '<marker label="'
        write(13,'(a,$)') dat(3,doi)
        write(13,'(a,$)') '" lat="'
        write(13,'(f6.2,$)') dat(1,doi)
        write(13,'(a,$)') '" lng="'
        write(13,'(f7.2,$)') dat(2,doi)
        write(13,'(a)') '"/>'
C       write(13,'(a)') '<marker>'
C       write(13,'(a,$)') '<lat>'
C       write(13,'(f6.2,$)') dat(1,doi)
C       write(13,'(a)') '</lat>'
C       write(13,'(a,$)') '<lng>'
C       write(13,'(f7.2,$)') dat(2,doi)
C       write(13,'(a)') '</lng>'
C       write(13,'(a)') '</marker>'
      end do
      write(13,'(a)') '</markers>'

      close(12)              ! close output log file
      close(lunin)

      stop

      end  ! program plot_bufrdump

inputEOF
set -x
#####6###1#########2#########3#########4#########5#########6#########7##

ifort -c -O2 -convert big_endian -list -auto plot_dumps.f

ifort plot_dumps.o /nwprod/lib/libbufr_v10.2.5_4_64.a /nwprod/lib/libw3nco_4.a -o plot_dumps

rm fort.*

ln -sf $1 fort.11
time -p ./plot_dumps > $DATA/plot_dumps.out 2> errfile
err=$? 

cat errfile >> $DATA/plot_dumps.out

echo "err='$err'  working dir = '$DATA'"

if test "$err" -ne '0'
then
  echo "plot_dumps.sh failed - abnormal stop"
else
  echo "plot_dumps.sh successful - normal end of script"
fi

# end plot_dumps.sh
