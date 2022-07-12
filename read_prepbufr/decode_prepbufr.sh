#!/bin/sh

# Driver script to read through a prepBUFR file to decode/read specific
# parameters from each report (subset) in the file.

# Takes 1 argument:
# 1 - full path for prepbufr file

#set -x

# test incoming args; trap errors
test $# -ne 1 && echo "$0: <prepbufr file> "
test $# -ne 1 && exit

# set up working directory
DATA=/stmp/$USER/decode_prepbufr
mkdir -p $DATA
cd $DATA
errcd=$?
[ $errcd -eq 0 ] && rm -rf decode_prepbufr.*

# set up XLF options
export XLFRTEOPTS="unit_vars=yes"
export XLFUNITS=0
export XLFUNIT_11="$1"

# set up libraries
LIBS='-L/nwprod/lib -lw3_4 -lbufr_4_64'

#set +x

# heredoc fortran source
#####6###1#########2#########3#########4#########5#########6#########7##
cat <<inputEOF > decode_prepbufr.f ; { xlf -qmaxmem=-1 decode_prepbufr.f -o decode_prepbufr.x $LIBS > /dev/null 2>cmp.err ; } && ./decode_prepbufr.x

c main program documentation block

      program read_bufrdump

c This code reads through an input bufr dump file and decodes/reads
C specific parameters from each report (subset) in the file.

      parameter  (mxmn=20, mxlv=255)
      character*8  subset, rpstr(5)
      character*80  mnstr
      integer  sobmsg
      real*8  obs1(mxmn), obslv1(mxlv), obslv2(mxlv)
      real*8  obs2(mxmn,mxlv) 
      real*8  sid(5), pstn
      real*8  pmsl, temp, elev, stdatm, q, qstd, qdiff, qpct 
      equivalence  (rpstr(1),sid(1))

c     function pr gets pstn from pmsl, temp, and elev
c     pr(pmsl,temp,elev) =pmsl * (((temp - (.0065 * elev))/temp)**5.256)

c     functions convert temp/td (k) & pres (mb) into sat./spec hum (g/g)
c     es(t) = 6.1078 * exp((17.269 * (t - 273.16))/((t - 273.16)+237.3))
c     qfrmtp(t,p) = (0.622 * es(t))/(p - (0.378 * es(t)))

c     open prepbufr file to read from it
      lunin=11
      open(lunin,form='UNFORMATTED')

c     open log output file to write to it
      open(unit=12,file="$DATA/log")

      call datelen(10)

      call openbf(lunin,'IN',lunin)

c     loop through input bufr dump file reading in one bufr message
c     at a time (e.g., 'NC000001')

      do while (ireadmg(lunin,subset,idate).eq.0)

        if (subset.eq.'ADPSFC') then
          write(12,*) 
          write(12,*) '----- ', subset, '-----'       
          write(12,*) 

c       loop through this ADPSFC prepbufr message reading in one 
c       report (subset) at a time

          do while (ireadsb(lunin).eq.0)

c           through a series of calls to ufbint read in various parameters
c           from this report (subset)

            write(12,*) 
            write(12,'(a)') '*****************************************'
            write(12,*) 

c           return a single string mnemonic (SID)
            call ufbint(lunin,sid,1,1,iret,'SID')
            write(12,*) 'STN ID: ',rpstr(1)

c           return observation dtg
            mnstr='RPT'
            call ufbint(lunin,obs1,1,1,iret,mnstr)
            write(12,'(1x,a,$)') 'DTG (z): '
            write(12,50) obs1(1)
   50       format (1x,f5.2) 

c           return latitude and longitude (YOB,XOB)
            mnstr='YOB XOB'
            call ufbint(lunin,obs1,2,1,iret,mnstr)
            write(12,'(1x,a,$)') 'LAT, LON: '
            write(12,'(f7.2,1x,f6.2)') (obs1(i),i=1,2)

c           return dump rpt typ & prepbufr rpt typ (T29,TYP)
            mnstr='T29 TYP'
            call ufbint(lunin,obs1,2,1,iret,mnstr)
            write(12,*) 'T29: ',int(obs1(1)) 
            write(12,*) 'TYP: ',int(obs1(2))

c           return temperature (TMDB) in obslv1(x) and dewpoint (TMDP)
c           in obslv2(x), where x is the level.  These are known to be
c           replicated (e.g. in different levels) so iret will be
c           returned w/ the actual number of replications (levels)
c           of these values in the report.
            write(12,'(1x,a)') '  UOB     VOB     SOB'
            write(12,'(1x,a)') '-------------------------------------'
            mnstr='UOB VOB SOB'
            call ufbint(lunin,obs1,3,mxlv,iret,mnstr)
            write(12,52) (obs1(i),i=1,3)
   52       format (3(2x,f6.2)) 

c           indicate if sob is not missing
            sobmsg = ibfms(obs1(3))
            if (sobmsg.eq.0) then
              write(12,*) 'sob not missing'
            endif 
          
c           go read in the next report (subset) from prepbufr file

          enddo      ! end do while (ireadsb ...

        endif        ! end if (subset.eq.'ADPSFC')
c       all prepbufr messages have been read; thus all reports have been
c       processed; DONE

      enddo        ! end do while (ireadmg ...

      call closbf(lunin)   ! close input bufr dump file
      close(12)            ! close log output file
      close(lunin)

      stop
   
      end  ! program decode_prepbufr

inputEOF
#####6###1#########2#########3#########4#########5#########6#########7##

rc=$?
echo "rc='$rc'  working dir = '$DATA'"

if test "$rc" -ne '0'
then
  echo "decode_prepbufr.sh failed - abnormal stop"
else
  echo "decode_prepbufr.sh successful - normal end of script"
fi

# end of decode_prepbufr.sh
