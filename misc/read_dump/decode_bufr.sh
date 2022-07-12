#!/bin/sh

# Drive script to read through a BUFR dump file to decode/read specific
# parameters from each report (subset) in the file.

# Takes 1 argument:
# 1 - full path for bufr dump file

#set -x

# test incoming args; trap errors
test $# -ne 1 && echo "$0: <bufr dump file> "
test $# -ne 1 && exit

bfile=${1}

# set up working directory
DATA=/stmp/$USER/read_bufrdump
mkdir -p $DATA
cd $DATA
errcd=$?
[ $errcd -eq 0 ] && rm -rf read_bufrdump.*

# Obsolete CCS options
# set up XLF options
#export XLFRTEOPTS="unit_vars=yes"
#export XLFUNITS=0
#export XLFUNIT_11="$bfile"

# set up FORT options
unset FORT000 `env | grep "FORT[0-9]\{1,\}" | awk -F= '{print $1}'`
export FORT11=$bfile

# set up libraries
LIBS='-L/nwprod/lib -lw3nco_4 -lw3emc_4 -lbufr_4_64'

#set +x

# heredoc fortran source
#####6###1#########2#########3#########4#########5#########6#########7##
cat <<inputEOF > read_bufrdump.f ; { ifort read_bufrdump.f -o read_bufrdump.x $LIBS > /dev/null 2>cmp.err ; } && ./read_bufrdump.x

c main program documentation block

      program read_bufrdump

c This code reads through an input bufr dump file and decodes/reads
C specific parameters from each report (subset) in the file.

      parameter  (mxmn=20, mxlv=255)
      character*8  subset, rpstr(5)
      character*80  mnstr
      integer  pmslmsg, pstnmg, tdmsg, zmsg, wdirmsg
      integer  cnt, miss, cntmiss, i, cntdf
      real*8  obs1(mxmn), obslv1(mxlv), obslv2(mxlv)
      real*8  obs2(mxmn,mxlv) 
      real*8  rpid(5), pstn, sum, avg
      real*8  pmsl, temp, elev, stdatm, q, qstd, qdiff, qpct 
      real*8  qpct1max, qpct1min
      real*8  qpstnar(2000), qpmslar(2000), qstdatmar(2000)
      real*8  pstn0ar(2000), pstn1ar(2000), pstn2ar(2000)
      real*8  qpct1ar(2000), qpct2ar(2000)
      real*8  elevar(2000)
      equivalence  (rpstr(1),rpid(1))
      data cnt/0/,miss/999999/,cntmiss/0/,sum/0/,qpct1max/0/
      data qpct1min/100/

c     function pr gets pstn from pmsl, temp, and elev
      pr(pmsl,temp,elev) =pmsl * (((temp - (.0065 * elev))/temp)**5.256)

c     functions convert temp/td (k) & pres (mb) into sat./spec hum (g/g)
      es(t) = 6.1078 * exp((17.269 * (t - 273.16))/((t - 273.16)+237.3))
      qfrmtp(t,p) = (0.622 * es(t))/(p - (0.378 * es(t)))

c     open bufr dump file to read from it
      lunin=11
      open(lunin,form='UNFORMATTED')

c     open log output file to write to it
      open(unit=12,file="$DATA/log")

      call datelen(10)

      call openbf(lunin,'IN',lunin)

c     counter (cnt) initialized as 0.

c     loop through input bufr dump file reading in one bufr message
c     at a time (e.g., 'NC000001')

      do while (ireadmg(lunin,subset,idate).eq.0)

        write(12,*) subset       

c       loop through this bufr message reading in one report (subset)
c       at a time

        do while (ireadsb(lunin).eq.0)

c         through a series of calls to ufbint read in various parameters
c         from this report (subset)

          write(12,*) 
          write(12,'(a)') '*******************************************'
          write(12,*) 

c         return a single string mnemonic (RPID)
          call ufbint(lunin,rpid,1,1,iret,'RPID')
          write(12,*) 'STN ID: ',rpstr(1)

c         return observation dtg
          mnstr='YEAR MNTH DAYS HOUR MINU'
          call ufbint(lunin,obs1,5,1,iret,mnstr)
          write(12,'(1x,a,$)') 'DTG: '
          write(12,50) (int(obs1(i)),i=1,5)
   50     format (1x,i4,4i2.2) 

c         return coarse latitude and longitude (CLAT,CLON)
          mnstr='CLAT CLON'
          call ufbint(lunin,obs1,2,1,iret,mnstr)
          write(12,'(1x,a,$)') 'LAT, LON: '
          write(12,'(f7.2,1x,f7.2)') (obs1(i),i=1,2)

c         return temperature (TMDB) in obslv1(x) and dewpoint (TMDP)
c         in obslv2(x), where x is the level.  These are known to be
c         replicated (e.g. in different levels) so iret will be
c         returned w/ the actual number of replications (levels)
c         of these values in the report.
          write(12,'(1x,a,$)') 'Lvl   TMDB   TMDP     SELV'
          write(12,'(a)') '   PRES   PMSL   WDIR   WSPD'
          write(12,'(1x,a,$)') '-------------------------------------'
          write(12,'(a)') '-------------------'
          mnstr='TMDB TMDP SELV PRES PMSL WDIR WSPD'
          call ufbint(lunin,obs1,7,mxlv,iret,mnstr)
          write(12,52) iret,(obs1(i),i=1,2),int(obs1(3))
          write(12,53) (int(obs1(i)),i=4,6),obs1(7)
   52     format (i4,2(2x,f6.2),1x,i6,$) 
   53     format (2(2x,i6),2x,i3,2x,f5.1) 

c         indicate if WDIR is missing
          wdirmsg = ibfms(obs1(6))
          if (wdirmsg.eq.1.and.int(obs1(7)).le.3) then
            write(12,*) 'WDIR missing'
            write(12,*) 'WSPD lt 3'
          endif
c         if (int(obs1(7)).le.3) then
c           write(12,*) 'WSPD lt 3'
c         endif

c         calculate station pressure and moisture 
c         ibfms = 0 --> not missing
c         ibfms = 1 --> missing
          pmslmsg = ibfms(obs1(5))
          pstnmsg = ibfms(obs1(4))
          tdmsg = ibfms(obs1(2))
          zmsg = ibfms(obs1(3))
          if (pmslmsg.eq.0.and.pstnmsg.eq.1) then
            write(12,*) 'valid pmsl, missing pstn'
            if (zmsg.eq.0.and.obs1(3).le.8) then
              write(12,*) 'pstn = pmsl'
              pstn = (obs1(5)) / 100
              if (tdmsg.eq.0) then
                q = qfrmtp(obs1(2),pstn)
              endif
            else
              write(12,*) 'pstn estimated from pmsl'
              pstn = pr(obs1(5),obs1(1),obs1(3)) / 100
              if (tdmsg.eq.0) then
                q = qfrmtp(obs1(2),pstn)
              endif
            endif
            write(12,*) 'pstn = ', pstn
            if (tdmsg.eq.0) then
              write(12,*) 'q = ', q
            endif
          endif
          if (pmslmsg.eq.1.and.pstnmsg.eq.1) then
            write(12,*) 'missing pmsl, missing pstn'
            stdatm = 101325
            if (zmsg.eq.0) then
              pstn = pr(stdatm,obs1(1),obs1(3)) / 100
              if (tdmsg.eq.0) then
                q = qfrmtp(obs1(2),pstn)
                qstd = qfrmtp(obs1(2),stdatm/100)
                qdiff = abs(q - qstd)
                qpct = (qdiff / q) * 100
              endif
              write(12,*) 'pstn = ', pstn
              if (tdmsg.eq.0) then
                write(12,*) 'q = ', q
                write(12,*) 'qstd = ', qstd
                write(12,*) 'qdiff = ', qdiff
                write(12,*) 'qpct (%) = ', qpct
              endif
            endif
          endif

c         if Pstn valid, calculate q
c         for same station calculate q using Pmsl (qpmsl)
c         for same station calculate q using 1013.25 (qstdatm)
          if (pstnmsg.eq.0.and.tdmsg.eq.0.and.zmsg.eq.0) then
            cnt=cnt+1
            write(12,*) 'cnt = ', cnt
            pstn = obs1(4) / 100
            pstn0ar(cnt)=pstn             ! sotre in array
            q = qfrmtp(obs1(2),pstn)
            qpstnar(cnt)=q                ! store in array
            write(12,'(1x,a,$)') 'q = '
            write(12,'(f8.6)') q
            write(12,'(1x,a,$)') 'pstn = '
            write(12,'(f9.4)') pstn 
            if (pmslmsg.eq.0) then
              pstn = pr(obs1(5),obs1(1),obs1(3)) / 100
              pstn1ar(cnt)=pstn           ! store in array
              qpmsl = qfrmtp(obs1(2),pstn)
              qpmslar(cnt)=qpmsl          ! store in array
              write(12,'(1x,a,$)') 'qpmsl = '
              write(12,'(f8.6)') qpmsl
              write(12,'(1x,a,$)') 'pstn = '
              write(12,'(f9.4)') pstn 
              qdiff1 = abs(q-qpmsl)
              qpct1 = (qdiff1 / q) * 100
              qpct1ar(cnt)=qpct1          ! store in array
              write(12,'(1x,a,$)') 'qpct1 = '
              write(12,'(f8.4)') qpct1
              if (qpct1.gt.19) then
                write(12,*) 'qpct1 > 19%!!'
              endif
            else
              cntmiss=cntmiss+1
              write(12,*) 'cntmiss = ', cntmiss
              pstn1ar(cnt)=miss           ! store in array
              qpmslar(cnt)=miss           ! store in array
              qpct1ar(cnt)=miss           ! store in array
            endif
            stdatm = 101325
            pstn = pr(stdatm,obs1(1),obs1(3)) / 100 
            pstn2ar(cnt)=pstn           ! store in array
            qstdatm = qfrmtp(obs1(2),pstn)
            qstdatmar(cnt)=qstdatm      ! store in array
            write(12,'(1x,a,$)') 'qstdatm = '
            write(12,'(f8.6)') qstdatm
            write(12,'(1x,a,$)') 'pstn = '
            write(12,'(f9.4)') pstn 
            qdiff2 = abs(q-qstdatm)
            qpct2 = (qdiff2 / q) * 100
            qpct2ar(cnt)=qpct2          ! store in array
            write(12,'(1x,a,$)') 'qpct2 = '
            write(12,'(f8.4)') qpct2
          endif

c         go read in the next report (subset) from bufr dump file

        enddo      ! end do while (ireadsb ...

c       all bufr messages have been read; thus all reports have been
c       processed; DONE
      enddo        ! end do while (ireadmg ...

c     print cnt and cntmiss
      write(12,'(1x,a,$)') 'COUNT = '
      write(12,'(i6)') cnt 
      write(12,'(1x,a,$)') 'COUNT MISS = '
      write(12,'(i6)') cntmiss

c     step through arrays to calculate averages
      cntdf=cnt
      do i = 1, cnt
        if (qpct1ar(i).eq.miss) then
          cntdf=cntdf-1
        else
          sum=sum+qpct1ar(i)
          if (qpct1ar(i).gt.qpct1max) then
            write(12,*) qpct1ar(i), qpct1max
            qpct1max=qpct1ar(i)
          endif 
          if (qpct1ar(i).lt.qpct1min.and.qpct1ar(i).gt.0) then
            qpct1min=qpct1ar(i)
          endif
        endif
      end do
      write(12,*) cnt,'-', cntmiss,'=', cntdf
      avg=sum/cntdf
      write(12,'(1x,a,$)') 'Avg % diff q from Pstn and q from Pmsl: '
      write(12,'(f8.4)') avg
      write(12,'(f8.4)') qpct1max 
      write(12,'(f10.6)') qpct1min 
      sum=0
      do i = 1, cnt
        sum=sum+qpct2ar(i)
      end do 
      avg=sum/cnt
      write(12,'(1x,a,$)') 'Avg % diff q from Pstn and q from stdatm: '
      write(12,'(f8.4)') avg

      call closbf(lunin)   ! close input bufr dump file
      close(12)            ! close log output file
      close(lunin)

      stop
   
      end  ! program read_bufrdump

inputEOF
#####6###1#########2#########3#########4#########5#########6#########7##

rc=$?
echo "rc='$rc'  working dir = '$DATA'"

if test "$rc" -ne '0'
then
  echo "decode_bufr.sh failed - abnormal stop"
else
  echo "decode_bufr.sh successful - normal end of script"
fi

# end of decode_bufr.sh
