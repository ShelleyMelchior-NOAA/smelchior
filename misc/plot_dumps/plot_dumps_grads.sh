#!/bin/sh

# Driver script to read through a BUFR dump file to plot specific parameters
# to visualize spatial domain/extent and data availability.

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
DATA=/ptmpp1/$USER/plot_dumps
mkdir -p $DATA
cd $DATA
errcd=$?
#[ errcd -eq 0 ] && rm -rf plot_dumps.*
export DATA=${DATA}

set +x

# Heredoc fortran source

#####6###1#########2#########3#########4#########5#########6#########7##
#cat <<inputEOF > plot_dump.f ; { xlf -qmaxmem=-1 plot_dump.f -o plot_dump.x $LIBS > /dev/null 2>cmp.err ; } && ./plot_dump.x
#cat <<\inputEOF > plot_dumps.f
cat <<inputEOF > plot_dumps_grads.f

C Main Program 

      program plot_bufrdump

C     This code reads through an input bufr dump file and plots specific 
C     parameters to visualize the spatial domain/extent of the data set.

      parameter  (mxmn=3)
      character*8  subset,stn(mxmn),stid 
      character*80  mnstr
      integer  cnt,nlev,nflag
      real*8  datbl(mxmn),lon360

      equivalence (datbl,stn)

C     Open bufr dump file to read out: lat, long
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

C     Loop through input bufr dump file, reading in one bufr msg at a
C     time (e.g., 'NC005044')
      cnt=0
      do while (ireadmg(lunin,subset,idate).eq.0)
        write(12,*) 
        write(12,*) '---START ', subset, idate, '---'
        write(12,*) 
C       Loop through this bufr msg reading in one report at at time
        do while (ireadsb(lunin).eq.0)
C         Use ufbint to pull various parameters from report
C         Return lat/lon and stn id
C         TAC: dropw, pibal, raob*, synop*, dbuoy, mbuoy 
          if (subset.eq.'NC000000'.or.subset.eq.'NC000001'.or.
     .        subset.eq.'NC000002'.or.subset.eq.'NC002001'.or.
     .        subset.eq.'NC002002'.or.subset.eq.'NC002003'.or.
     .        subset.eq.'NC002004'.or.subset.eq.'NC002005'.or.
     .        subset.eq.'NC001002'.or.subset.eq.'NC001003') then
            mnstr='RPID CLAT CLON'
C         BUFR: dropwb, pibalb, raob*, synop*, dbuoyb, mbuoyb
          else if (subset.eq.'NC000100'.or.subset.eq.'NC000101'.or.
     .             subset.eq.'NC000102'.or.subset.eq.'NC002101'.or.
     .             subset.eq.'NC002102'.or.subset.eq.'NC002103'.or.
     .             subset.eq.'NC002104'.or.subset.eq.'NC002105'.or.
     .             subset.eq.'NC001102'.or.subset.eq.'NC001103') then
            mnstr='RPID CLATH CLONH'
C         TAC: airep, amdar
          else if (subset.eq.'NC004001'.or.subset.eq.'NC004003'.or.
     .             subset.eq.'NC004004') then
            mnstr='ACID CLAT CLON'
C         BUFR: amdar
C         TAC: eadas
          else if (subset.eq.'NC004006'.or.subset.eq.'NC004103'.or.
     .             subset.eq.'NC004010') then
            mnstr='ACRN CLATH CLONH'
C         TAC: pirep
          else if (subset.eq.'NC004002') then
            mnstr='RPID CLAT CLON'
C         Radiance tanks: escris, esatms, esiasi, crisdb, atmsdb, iasidb
C                         mtiasi, crisf4
          else if (subset.eq.'NC021037'.or.subset.eq.'NC021038'.or.
     .             subset.eq.'NC021039'.or.subset.eq.'NC021212'.or.
     .             subset.eq.'NC021213'.or.subset.eq.'NC021239'.or.
     .             subset.eq.'NC021241'.or.subset.eq.'NC021033'.or.
     .             subset.eq.'NC021035'.or.subset.eq.'NC021036'.or.
     .             subset.eq.'NC021206') then
            write(12,*) 'tank = ', subset 
            mnstr='SAID CLATH CLONH'
C         Lightning tanks: ltngsr, ltnglr 
          else if (subset.eq.'NC007001'.or.subset.eq.'NC007002') then
            mnstr='STMID CLATH CLONH'
          end if
C         if cnt > 999,999 then close 16 (txt) and open a new file to
c         continue writing
          if(cnt.eq.999999) then
            close(16)              ! close output txt file
            open(unit=16,
     .file="$DATA/
     .$2.$3.extra.txt")
          end if
          call ufbint(lunin,datbl,3,1,iret,mnstr)
C         if lat or lon missing, skip report
          if(ibfms(datbl(2)).or.ibfms(datbl(3))) then
            write(12,*) stn(1),datbl(2),datbl(3)
            cycle
          end if
C         write(12,*) stn(1),datbl(2),datbl(3)
C         if(ibfms(datbl(1))) stn(1) = 'miss'
          write(16,'(a,$)') stn(1)
          write(16,'(a,$)') ' '
          write(16,'(f6.2,$)') datbl(2)
          write(16,'(a,$)') ' '
C         For GrADS reset lon 0 to 360
C         lon360 = datbl(3) + 180.0
C         write(16,'(f7.2)') lon360 
          write(16,'(f7.2)') datbl(3)
          write(12,*) 'count = ',cnt
          cnt=cnt+1
        end do ! while (ireadsb ...)
      end do ! while (ireadmg ...)

      close(16)              ! close output txt file

      write(12,*) 
      write(12,*) '---cnt = ', cnt, '---'
      write(12,*) 

      call closbf(lunin)     ! close input bufr dump file

C     Write GrADS dat file to plot lat/lon markers
      open(8,name="$2.$3.txt")
      open(unit=14,
     . file="$DATA/$2.$3.dat",
     . form="unformatted",recordtype="stream")
10    read(8,9000,end=90) stid,rlat,rlon
9000  format (a8,x,f6.2,x,f7.2)
      u = 0.0
      v = 0.0
      tim = 0.0
      nlev = 1
      nflag = 1
      write(14) stid,rlat,rlon,tim,nlev,nflag
      write(14) u,v
      go to 10
90    continue
      nlev = 0
      nflag = 0
      write (14) stid,rlat,rlon,tim,nlev,nflag
      close(8)               ! close input txt file
      close(14)              ! close output dat file

C     Write GrADS ctl file
      open(unit=15,
     . file="$DATA/$2.$3.ctl")
      write(15,'(a,$)') 'DSET   $DATA'
      write(15,'(a)') '/$2.$3.dat'
      write(15,'(a)') 'DTYPE  station'
      write(15,'(a,$)') 'STNMAP $DATA'
      write(15,'(a)') '/$2.$3.map'
      write(15,'(a)') 'UNDEF  -9999.0'
      write(15,'(a)') 'OPTIONS  big_endian'
      write(15,'(a)') 'TITLE  Plot Dump'
      write(15,'(a)') 'TDEF   1 linear 12z12May2015 6hr'
      write(15,'(a)') 'VARS   2'
      write(15,'(a)') 'u    0  99 u-wind'
      write(15,'(a)') 'v    0  99 v-wind'
      write(15,'(a)') 'ENDVARS'
      close(15)              ! close output ctl file

      if(cnt.gt.999999) then
      ! Write extra dat and ctl file for large data sets
      ! dat
        open(8,name="$2.$3.extra.txt")
        open(unit=14,
     . file="$DATA/$2.$3.
     .extra.dat",
     . form="unformatted",recordtype="stream")
11      read(8,9001,end=91) stid,rlat,rlon
9001    format (a8,x,f6.2,x,f7.2)
        u = 0.0
        v = 0.0
        tim = 0.0
        nlev = 1
        nflag = 1
        write(14) stid,rlat,rlon,tim,nlev,nflag
        write(14) u,v
        go to 11
91      continue
        nlev = 0
        nflag = 0
        write (14) stid,rlat,rlon,tim,nlev,nflag
        close(8)               ! close input txt file
        close(14)              ! close output dat file
      ! ctl 
        open(unit=15,
     . file="$DATA/$2.$3.
     .extra.ctl")
        write(15,'(a,$)') 'DSET   $DATA'
        write(15,'(a)') '/$2.$3.extra.dat'
        write(15,'(a)') 'DTYPE  station'
        write(15,'(a,$)') 'STNMAP $DATA'
        write(15,'(a)') '/$2.$3.extra.map'
        write(15,'(a)') 'UNDEF  -9999.0'
        write(15,'(a)') 'OPTIONS  big_endian'
        write(15,'(a)') 'TITLE  Plot Dump'
        write(15,'(a)') 'TDEF   1 linear 12z12May2015 6hr'
        write(15,'(a)') 'VARS   2'
        write(15,'(a)') 'u    0  99 u-wind'
        write(15,'(a)') 'v    0  99 v-wind'
        write(15,'(a)') 'ENDVARS'
        close(15)              ! close output ctl file
      end if

      close(12)              ! close output log file
      close(lunin)

      stop

      end  ! program plot_bufrdump

inputEOF
set -x
#####6###1#########2#########3#########4#########5#########6#########7##

ifort -c -O2 -convert big_endian -list -auto plot_dumps_grads.f

ifort plot_dumps_grads.o /nwprod/lib/libbufr_v10.2.5_4_64.a /nwprod/lib/libw3nco_4.a -o plot_dumps_grads

rm fort.*

ln -sf $1 fort.11
time -p ./plot_dumps_grads > $DATA/plot_dumps_grads.out 2> errfile
err=$? 

cat errfile >> $DATA/plot_dumps_grads.out

echo "err='$err'  working dir = '$DATA'"

if test "$err" -ne '0'
then
  echo "plot_dumps_grads.sh failed - abnormal stop"
else
  echo "plot_dumps_grads.sh successful - normal end of script"
fi

# Generate station map for GrADS
#ctlfile=$DATA/plot_dump.ctl
ctlfile=$DATA/$2.$3.ctl
ctlfilextr=$DATA/$2.$3.extra.ctl
stnmap -i $ctlfile
if [ -f $ctlfilextr ]
then
  stnmap -i $ctlfilextr
fi
if [ -f $ctlfile ]
then
  # Run GrADS scripts to generate png image
  echo "run GrADS scripts"
  #rundir=/meso/save/$USER/svnwkspc/melchior/misc/plot_dumps
  rundir=/meso/save/$USER/gitwkspc/EMC_obsproc/misc/plot_dumps  # melchior DB
  grads -lbcx "$rundir/plot_dumps_grads.gs $ctlfile $2 $3 $ctlfilextr"
fi

# scp file to webserver
# managed from driver script in $rundir/transfer_plots_dumps_grads

# end plot_dumps_grads.sh
