# Interrogate certain b004 (aircraft) tanks
# 004003, 004103 (AMDAR and AMDARB)

source /u/Shelley.Melchior/.bashrc

set -x

#PDY=20160830 # brought in by trigger script

workdir=/ptmpp1/$USER/tank_aircft.$PDY.$$
[ -d $workdir ] || mkdir -p $workdir
cd $workdir
export workdir=${workdir}

tank=/dcomdev/us007003

# Heredoc fortran source

#####6###1#########2#########3#########4#########5#########6#########7##
cat <<inputEOF > aircft_tank.f

C Main Program

      program aircft_tank

C     This code extracts RPID and ACRN (or ACID) from tanks 004003
C     and 004103, repsectively.  In cases when ACRN is missing,
C     ACID is used.
 
      parameter    (mxmn=2)
      character*8  subset,stn(mxmn),stid
      character*80 mnstr
      integer      cnt
      real*8       datbl(mxmn)

      equivalence (datbl,stn)

C     Open bufr tank 004003 to read out RPID
      lunin=11
      open(lunin,form='UNFORMATTED')

C     Open output file that lists RPIDs in ascii
      open(unit=13,
     . file=
     . "$workdir/004003.IDs")

      call datelen(10)

      call openbf(lunin,'IN',lunin)

C     Loop through input tank 004003 reading in one bufr msg at a time
      cnt=0
      do while (ireadmg(lunin,subset,idate).eq.0)
C       Loop through bufr msg reading in one report at a time
        do while (ireadsb(lunin).eq.0)
C         Use ufbint to pull out RPID from report
          call ufbint(lunin,datbl,1,1,iret,'RPID')
          write(13,'(a)') stn(1)
          cnt=cnt+1
        end do  ! while (ireadsb ...)
      end do  ! while (ireadmg ...)
      write(13,*) '---cnt = ', cnt, '---'

      close(13)                 ! close 004003.IDs
      call closbf(lunin)        ! close input tank 004003

C     Open bufr tank 004103 to read out ACRN
C     If ACRN is missing, read out ACID
      lunin=12
      open(lunin,form='UNFORMATTED')

C     Open output file that lists ACRNs (ACIDs) in ascii
      open(unit=14,
     . file=
     . "$workdir/004103.IDs")

      call datelen(10)

      call openbf(lunin,'IN',lunin)

C     Loop through input tank 004103 reading in one bufr msg at a time
      cnt=0
      do while (ireadmg(lunin,subset,idate).eq.0)
C       Loop through bufr msg reading in one report at a time
        do while (ireadsb(lunin).eq.0)
C         Use ufbint to pull out ACRN (or ACID) from report
          call ufbint(lunin,datbl,1,1,iret,'ACRN')
          if(ibfms(datbl(1)).eq.1) then    ! ACRN is missing
            call ufbint(lunin,datbl,1,1,iret,'ACID')
          end if
          write(14,'(a)') stn(1)
          cnt=cnt+1
        end do  ! while (ireadsb ...)
      end do  ! while (ireadmg ...)
      write(14,*) '---cnt = ', cnt, '---'

      close(14)                 ! close 004103.IDs
      call closbf(lunin)        ! close input tank 004103

      stop

      end  ! program aircft_tank

inputEOF
#####6###1#########2#########3#########4#########5#########6#########7##

#ifort -c -O2 -convert big_endian -list -auto aircft_tank.f
ifort -c -O2 -list -auto aircft_tank.f

ifort aircft_tank.o /nwprod2/lib/bufr/v11.1.0/libbufr_v11.1.0_4_64.a /nwprod2/lib/w3nco/v2.0.6/libw3nco_v2.0.6_4.a -o aircft_tank

rm $workdir/fort.*

ln -sf $tank/$PDY/b004/xx003 fort.11
ln -sf $tank/$PDY/b004/xx103 fort.12

time -p ./aircft_tank > $workdir/aircft_tank.out 2> errfile
err=$? 

cat errfile >> $workdir/aircft_tank.out

echo "err='$err' working dir = '$workdir'"

if test "$err" -ne 0
then
  echo "aircft_tank.sh failed - abnormal stop"
else
  echo "aircft_tank.sh successful - normal end of script"
fi

emlfl=$workdir/email.$PDY

echo "All UNIQUE IDs!" > $emlfl
echo "" >> $emlfl

# Strip to unique report IDs
tankarr=( "003" "103" )
for xx in ${tankarr[@]}
do
  # Remove total count info
  head -n -1 $workdir/004$xx.IDs > $workdir/004$xx.IDs.stripped
  # Strip to unique report IDs
  cat $workdir/004$xx.IDs.stripped | sort | uniq > $workdir/004$xx.IDs.unique
  # Resolve into expected IDs
  if [ "$xx" = "003" ]; then
    echo "--- Start 004$xx ---" >> $emlfl
    basearr=( "AFZA" "AU" "CNC" "CNF" "JP" "NZL" )
    for base in ${basearr[@]}
    do
      ttlcnt=$(grep "^$base" $workdir/004$xx.IDs.unique | wc -l)
      echo "Total $base reports: $ttlcnt" > $workdir/004$xx.IDs.$base
      if [ "$base" = "AFZA" ]; then
        subarr=( "AFZA0" "AFZA1" "AFZA2" "AFZA3" "AFZA4" "AFZA5" "AFZA6" "AFZA7" "AFZA8" "AFZA9" )
      elif [ "$base" = "AU" ]; then
        subarr=( "AU00" "AU01" )
      elif [ "$base" = "CNC" ]; then
        subarr=( "CNCOVM" "CNCOVL" "CNCMVT" "CNCMTS" "CNCSVN" "CNCSZT" "CNCSXK" "CNCSZN" "CNCSVM" "CNCSZL" )
      elif [ "$base" = "CNF" ]; then
        subarr=( "CNFL" "CNFM" "CNFN" "CNFO" "CNFP" "CNFQ" "CNFR" )
      elif [ "$base" = "JP" ]; then
        subarr=( "JP9Z4" "JP9Z5" "JP9Z8" "JP9ZV" "JP9ZX" )
      else
        subarr=( "NZL00" "NZL01" "NZL02" "NZL03" "NZL04" "NZL05" "NZL06" "NZL07" "NZL08" "NZL09" )
      fi
      for elem in ${subarr[@]}
      do
        res=$(grep "^$elem" $workdir/004$xx.IDs.unique | wc -l)
        echo "Total $elem* reports: $res" >> $workdir/004$xx.IDs.$base
      done
      echo " " >> $emlfl
      cat $workdir/004$xx.IDs.$base >> $emlfl
    done
    # A few IDs that have no further resolution
    basearr=( "VA0" "CNG" "AEA" "AFR" "ARG" "AZA" "DTA" "IBE" "KLM" "TAM" "TAP" "UAE" )
    for elem in ${basearr[@]}
    do
      ttlcnt=$(grep "^$elem" $workdir/004$xx.IDs.unique | wc -l)
      echo "Total $elem reports: $ttlcnt" > $workdir/004$xx.IDs.$elem
      echo "" >> $emlfl
      cat $workdir/004$xx.IDs.$elem >> $emlfl
    done
    # Logic to handle potential new or unaccounted for IDs
    pattern="JP -e NZL -e CNF -e CNC -e AU -e AFZA -e VA0 -e CNG -e AEA -e AFR -e ARG -e AZA -e DTA -e IBE -e KLM -e TAM -e TAP -e UAE"
    newids_cnt=$(grep -v -e $pattern $workdir/004$xx.IDs.unique | wc -l)
    if [ $newids_cnt > 0 ]; then
      newids=$(grep -v -e $pattern $workdir/004$xx.IDs.unique | sort | uniq)
      echo "" >> $emlfl
      echo "Total new or unaccounted for IDs: " $newids_cnt >> $emlfl
      echo $newids >> $emlfl
      echo "" >> $emlfl
    fi
  else
    # tank 004103
    echo "--- Start 004$xx ---" >> $emlfl
    # A few IDs that have no further resolution
    basearr=( "AFZA" "AU" "CNC" "CNF" )
    for base in ${basearr[@]}
    do
      ttlcnt=$(grep "^$base" $workdir/004$xx.IDs.unique | wc -l)
      echo "Total $base reports: $ttlcnt" > $workdir/004$xx.IDs.$base
      echo "" >> $emlfl
      cat $workdir/004$xx.IDs.$base >> $emlfl
    done
    basearr=( "AG" "ANZ" "HK" "JP" "NZL" "QFA" "SL" )
    for base in ${basearr[@]}
    do
      ttlcnt=$(grep "^$base" $workdir/004$xx.IDs.unique | wc -l)
      echo "Total $base reports: $ttlcnt" > $workdir/004$xx.IDs.$base
      if [ "$base" = "AG" ]; then
        subarr=( "AG1000" "AG1001" "AG1002" "AG1003" "AG1004" )
      elif [ "$base" = "ANZ" ]; then
        subarr=( "ANZ1" "ANZ2" "ANZ3" "ANZ4" "ANZ5" "ANZ6" "ANZ7" "ANZ8" "ANZ9" )
      elif [ "$base" = "HK" ]; then
        subarr=( "HK0001" "HK0002" "HK0004" "HK0006" "HK0007" "HK0008" "HK0009" "HK0010" "HK0011" "HK0012" "HK0013" "HK0014" "HK0015" )
      elif [ "$base" = "JP" ]; then
        subarr=( "JP9Z4" "JP9Z5" "JP9Z8" "JP9ZV" "JP9ZX" )
      elif [ "$base" = "NZL" ]; then
        subarr=( "NZL00" "NZL01" "NZL02" "NZL03" "NZL04" "NZL05" "NZL06" "NZL07" "NZL08" "NZL09" )
      elif [ "$base" = "QFA" ]; then
        subarr=( "QFA1" "QFA2" "QFA3" "QFA4" "QFA7" "QFA8" "QFA9" )
      else
        subarr=( "SL000" "SL001" "SL002" "SL003" "SL004" "SL005" "SL006" "SL007" "SL008" "SL009" "SL010" "SL011" "SL012" "SL013" "SL014" "SL015" )
      fi
      for elem in ${subarr[@]}
      do
        res=$(grep "^$elem" $workdir/004$xx.IDs.unique | wc -l)
        echo "Total $elem* reports: $res" >> $workdir/004$xx.IDs.$base
      done
      echo "" >> $emlfl
      cat $workdir/004$xx.IDs.$base >> $emlfl
    done
    # Hodge-podge IDs with no further resolution
    IDsarr=( "AAL" "ACA" "ACI" "AFR" "ASY" "AVN" "AXM" "CAL" "CCA" "CES" "CSN" "DAL" "FDX" "FJA" "FJI" "HAL" "IBE" "ICE" "JST" "KAL" "KIW" "LAN" "LOBO" "LUC" "MAS" "MXD" "PAC" "PAL" "RCH" "RZO" "SIA" "SQC" "TAP" "TCV" "THA" "THT" "TMN" "UAE" "UAL" "UPS" "VOZ" "XAX" "^N[0-9]" )
    for elem in ${IDsarr[@]}
    do
      ttlcnt=$(grep "^$elem" $workdir/004$xx.IDs.unique | wc -l)
      if [ $ttlcnt -ge 100 ]; then
        alert=" ....... >> 100 !!"
      else
        alert=""
      fi
      echo "Total $elem reports: $ttlcnt" > $workdir/004$xx.IDs.$base
      echo "" >> $emlfl
      cat $workdir/004$xx.IDs.$base >> $emlfl
    done
    # Logic to handle potential new or unaccounted for IDs
    pattern="JP -e NZL -e HK0 -e AXM -e ANZ -e MXD -e SIA -e AVN -e ACA -e FJA -e LAN -e TAP -e DAL -e CSN -e LOBO -e ACI -e AFR -e VOZ -e THT -e FJI -e UAL -e QFA -e FDX -e JST -e KAL -e MAS -e THA -e UAE -e UPS -e HAL -e TMN -e RZO -e CAL -e SQC -e PAL -e TCV -e ASY -e RCH -e IBE -e ICE -e PAC -e LUC -e KIW -e AAL -e CES -e AG -e CCA -e XAX -e SL"
    newids_cnt=$(grep -v -e $pattern -e "^N[0-9]" $workdir/004$xx.IDs.unique | wc -l)
    if [ $newids_cnt > 0 ]; then
      newids=$(grep -v -e $pattern -e "^N[0-9]" $workdir/004$xx.IDs.unique | sort | uniq)
      echo "" >> $emlfl
      echo "Total new or unaccounted IDs: " $newids_cnt >> $emlfl
      echo $newids >> $emlfl
    fi
  fi  # end if for tank 004003 vs. tank 004103
done

# Send email
addy=shelley.melchior@noaa.gov
sbj="$PDY amdar(b) tanks"
mail -s "$sbj" $addy < $emlfl

#end aircft_tank.sh

# KEY
#AAL - American Airlines
#ACA - Air Canada
#ACI - Air Caledonie International
#AFR - Air France
#AG  - Argentina AMDAR (compiled and broadcast from Natl Meteo Svc of Argentina)
#ANZ - Air New Zealand
#AVN - Air Vanuatu
#AXM - AirAsia (as you know)
#CAL - China Airlines
#CCA - Air China
#CES - China Eastern Airlines
#CFC - Canadian Forces
#CNC - Corporacion Aereo Cencor (?)
#CNG - Coastal Airways (?)
#CSN - China Southern Airlines
#DAL - Delta Airlines
#FJA - Fijian Airways
#FJI - Fiji Airways
#GAF - German Air Force
#HAL - Hawaiian Airlines
#KAL - Korean Airlines
#KIW - Kiwi International
#LAN - LAN Chile
#LOBO - from Portugal (military?)
#MAS - Malaysian Airlines
#QFA - Qantas Airlines
#SIA - Singapore Airlines
#SL  - South America (LATAM)
#SQC - Singapore Airlines Cargo
#TAP - Transportes Aereos Portugueses (Portugal)
#TCV - Cabo Verde Airlines
#THT - Air Tahiti
#TMN - Tasman Cargo Airlines
#UAE - (United Arab) Emirates
#UAL - United Airlines
#VOZ - Virgin Australia
#XAX - Air Asia X (long-haul, low-cost affiliate carrier of AirAsia Group) 

