#!/bin/sh

# Driver script to read through a BUFR file (tank or dump) to pull bulletin info 

# Takes 3 arguments:
# 1 - full path for bufr tank or dump file
# 2 - tank (e.g. NC004003)
# 3 - PDY (e.g. 20150512)

. /u/$USER/.bashrc

set -x

# Test incoming args; trap errors
test $# -ne 3 && echo "$0: <bufr tank or dump file> <tank> <PDY>"
test $# -ne 3 && exit

# Set up working directory
DATA=/ptmpp1/$USER/bulletin
if [ ! -d $DATA ]; then
  mkdir -p $DATA
fi
cd $DATA
errcd=$?
#[ errcd -eq 0 ] && rm -rf get_bulletin.*
export DATA=${DATA}

set +x

# Heredoc fortran source

#####6###1#########2#########3#########4#########5#########6#########7##
cat <<inputEOF > get_bulletin.f

C Main Program 

      program get_bulletin

C     This code reads through an input bufr file and pulls bulletin 
C     information.

      parameter  (mxmn=2)
      character*8  subset,bull(mxmn)
      character*80  mnstr
      integer  cnt
      real*8  datbl(mxmn)

      equivalence (datbl,bull)

C     Open bufr file to read out: borg, buhd 
      lunin=11
      open(lunin,form='UNFORMATTED')

C     Open log output file to write to
      open(unit=12,
     . file="$DATA/$2.$3.log")

C     Open txt output file to write to
      open(unit=16,
     . file="$DATA/$2.$3.txt")

      call datelen(10)

      call openbf(lunin,'IN',lunin)

C     Loop through input bufr file, reading in one bufr msg at a
C     time (e.g., 'NC021039')
      cnt=0
      do while (ireadmg(lunin,subset,idate).eq.0)
        write(12,*) 
        write(12,*) '---START ', subset, idate, '---'
        write(12,*) 
C       Loop through this bufr msg reading in one report at a time
        do while (ireadsb(lunin).eq.0)
C         Use ufbint to pull various parameters from report
C         Return borg and buhd
          mnstr='BORG BUHD'
          call ufbint(lunin,datbl,2,1,iret,mnstr)
C         write(12,*) bull(1),bull(2)
          write(16,'(a,$)') 'BORG = '
          write(16,'(a,$)') bull(1)
          write(16,'(a,$)') ' '
          write(16,'(a,$)') 'BUHD = '
          write(16,'(a,$)') bull(2)
          write(16,*)
          cnt=cnt+1
        end do               ! do while (ireadsb ...)
      end do                 ! do while (ireadmg ...)

      close(16)              ! close output txt file

      write(12,*) 
      write(12,*) '---cnt = ', cnt, '---'
      write(12,*) 

      call closbf(lunin)     ! close input bufr dump file

      close(12)              ! close output log file
      close(lunin)

      stop

      end  ! program get_bulletin

inputEOF
set -x
#####6###1#########2#########3#########4#########5#########6#########7##

ifort -c -O2 -convert big_endian -list -auto get_bulletin.f

ifort get_bulletin.o /nwprod/lib/libbufr_v10.2.5_4_64.a /nwprod/lib/libw3nco_4.a -o get_bulletin

rm fort.*

ln -sf $1 fort.11
time -p ./get_bulletin > $DATA/get_bulletin.out 2> errfile
err=$? 

cat errfile >> $DATA/get_bulletin.out

echo "err='$err'  working dir = '$DATA'"

if test "$err" -ne '0'
then
  echo "get_bulletin.sh failed - abnormal stop"
else
  echo "get_bulletin.sh successful - normal end of script"
fi

# end get_bulletin.sh
