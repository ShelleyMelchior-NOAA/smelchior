# Run dumpjb for dump group: aircft

set -x

#PDY=20151222    # exported from trigger
#cyc=00         # exported from trigger
CDATE=${PDY}${cyc}

workdir=/ptmpp1/$USER/dump_aircft.$CDATE.$$
[ -d $workdir ] || mkdir -p $workdir
cd $workdir

export TMPDIR=$workdir

export LALO=0

CRAD=3.0

export DTIM_latest_aircft=+3.25
export DTIM_earliest_aircft=-3.25

export HOMEobsproc_dump=/nwprod/obsproc_dump.v3.3.0
#export HOMEobsproc_dump=/meso/save/$USER/svnwkspc/VS/obsproc_dump
#export DUMP=/meso/save/Shelley.Melchior/svnwkspc/VS/obsproc_dump/ush/dumpjb
#export CORX=/meso/save/Shelley.Melchior/svnwkspc/VS/obsproc_dump/exec/bufr_dupcor
#export AIRX=/meso/save/Shelley.Melchior/svnwkspc/VS/obsproc_dump/exec/bufr_dupair
#export SATX=/meso/save/Shelley.Melchior/svnwkspc/VS/obsproc_dump/exec/bufr_dupsat
#export EDTX=/meso/save/Shelley.Melchior/svnwkspc/VS/obsproc_dump/exec/bufr_edtbfr
#export obsproc_shared_bufr_dumplist_ver=v1.2.0
export LIST=/meso/save/$USER/svnwkspc/VS/obsproc_shared/bufr_dumplist/fix/bufr_dumplist
export EPRM=/dcom/us007003/sdmedit

#export DCOMROOT=/dcomdev
export DCOMROOT=/dcom
export TANK=${DCOMROOT}/us007003

$HOMEobsproc_dump/ush/dumpjb $CDATE $CRAD aircft
#$DUMP $CDATE $CRAD aircft

# Perform aircft data monitoring

cd $workdir
bufrd=aircft.ibm
emailfile=email.${PDY}${cyc}

# Do a quick bufr inventory on NC004003 and NC004103
echo "---- BINV ----"
which binv
binv $workdir/${bufrd} | tee $emailfile

# Get average count of reports for ${cyc}
tendaydir=/meso/noscrub/${USER}/TAC2BUFR/10day
subsetsummary=${tendaydir}/subsetsummary.txt
avg=$(cat ${subsetsummary} | grep "Avg rpts for ${cyc}z:" | cut -d':' -f2 | sed 's/^ *//g')
echo "Baseline average NC004003 report counts for ${cyc}z: ${avg}"
echo "Baseline average NC004003 report counts for ${cyc}z: ${avg}" >> $emailfile

# Run bufr_listdumps on aircft.ibm
# output writes to /stmpp1/$USER/listdumps
listdumps=/meso/save/$USER/svnwkspc/melchior/listdumps/listdumps.sh
sh $listdumps ${workdir}/${bufrd} aircft
cp /stmpp1/$USER/listdumps/listdumps.output.aircft $workdir/listdumps.${PDY}${cyc}

# Separate tank 004003 reports
grep "RT 41/  3" $workdir/listdumps.${PDY}${cyc} > $workdir/listdumps.${PDY}${cyc}.004003
# Separate tank 004103 reports
grep "RT 41/103" $workdir/listdumps.${PDY}${cyc} > $workdir/listdumps.${PDY}${cyc}.004103

# strip list down to just IDs
cat $workdir/listdumps.${PDY}${cyc}.004003 | cut -d' ' -f2 > $workdir/listdumps.${PDY}${cyc}.004003.stripped
cat $workdir/listdumps.${PDY}${cyc}.004103 | cut -d' ' -f2 > $workdir/listdumps.${PDY}${cyc}.004103.stripped


# parse through listdumps output to gather report counts
# tank: NC004003
echo "" >> $emailfile
echo "---- NC004003 ----" >> $emailfile
echo "" >> $emailfile
fileroot=listdumps.${PDY}${cyc}.004003
basearr=( "AFZA" "AU" "CNC" "CNF" "JP" "NZL" )
for base in ${basearr[@]}
do
  grep '^$base' ${fileroot}.stripped > ${fileroot}.${base}
  ttlcnt=$(grep "^$base" ${fileroot}.stripped | wc -l)
  echo "Total $base reports: $ttlcnt" >> ${fileroot}.${base}
  avg=$(cat ${subsetsummary} | grep "$base reports for ${cyc}z" | cut -d':' -f2 | sed 's/^ *//g')
  change=$(echo "scale=2; (${ttlcnt}-${avg})/(${avg})*100" | bc)
  echo "Total $base reports: ${ttlcnt} (${avg}) ... ${change}%" >> $emailfile
  unq=$(expr $(grep "^$base" ${fileroot}.stripped | sort | uniq | wc -l)) 
  echo "Total $base unique IDs: $unq" >> ${fileroot}.${base}
  echo "Total $base unique IDs: $unq" >> $emailfile
  # get avg baseline counts and write to $emailfile
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
    res=$(grep "^${elem}" ${fileroot}.stripped | wc -l)
    echo "Total ${elem}* reports: $res" >> ${fileroot}.${base}
    avg=$(cat ${subsetsummary} | grep ${elem} | grep "reports for ${cyc}z" | cut -d':' -f2 | sed 's/^ *//g')
    echo "Total ${elem}* reports: ${res} (${avg})" >> $emailfile
  done
  echo "" >> $emailfile
done
# No longer need to process EU reports in NC004003.  All EU TAC format reports
# are now populating dedicated tank, NC004006.
echo "EU report counts in BUFR format are in NC004006:" >> $emailfile
# Get report counts from b004/xx006
eufile=/meso/noscrub/${USER}/TAC2BUFR/10day/NC004006.EU
/u/Jeff.Whiting/bin/go_chkdat /dcom/us007003/${PDY}/b004/xx006 >> $emailfile
test=$(grep "${PDY}" ${eufile} | wc -l)
if [ "$test" -eq "0" ]; then
  /u/Jeff.Whiting/bin/go_chkdat /dcom/us007003/${PDY}/b004/xx006 >> $eufile
fi
echo "" >> $emailfile

# Also monitor Candadian AMDAR tank (camdar; 004009)
# Get report counts from b004/xx009
echo "Canadian AMDAR report counts in BUFR format are in NC004009:" >> $emailfile
/u/Jeff.Whiting/bin/go_chkdat /dcom/us007003/${PDY}/b004/xx009 >> $emailfile
echo "" >> $emailfile

# For those IDs where there is no further resolution
IDsarr=( "VA0" "CNG" "AEA" "AFR" "ARG" "AZA" "DTA" "IBE" "KLM" "TAM" "TAP" "UAE" )
for elem in ${IDsarr[@]}
do
  grep "^$elem" ${fileroot}.stripped > ${fileroot}.${elem}
  ttlcnt=$(grep "^$elem" ${fileroot}.stripped | wc -l)
  echo "Total $elem reports: $ttlcnt" >> ${fileroot}.${elem}
  echo "Total $elem reports: $ttlcnt" >> $emailfile
  unq=$(expr $(grep "^$elem" ${fileroot}.stripped | sort | uniq | wc -l))
  echo "Total $elem unique IDs: $unq" >> ${fileroot}.${elem}
  echo "Total $elem unique IDs: $unq" >> $emailfile
  echo "" >> $emailfile
done

# add logic to deal w/ potential new or unaccounted IDs
pattern="JP -e NZL -e CNF -e CNC -e AU -e AFZA -e VA0 -e CNG -e AEA -e AFR -e ARG -e AZA -e DTA -e IBE -e KLM -e TAM -e TAP -e UAE"
newids_cnt=$(grep -v -e $pattern ${fileroot}.stripped | wc -l)
if [ $newids_cnt > 0 ]; then
  newids=$(grep -v -e $pattern ${fileroot}.stripped | sort | uniq -c)
  echo "Total new or unaccounted IDs: " $newids_cnt >> $emailfile
  echo $newids >> $emailfile
  echo "" >> $emailfile
fi

# parse through listdumps output to gather report counts
# tank: NC004103
echo "---- NC004103 ----" >> $emailfile
echo "" >> $emailfile
fileroot=listdumps.${PDY}${cyc}.004103
# For those IDs where there is no further resolution
IDsarr=( "AFZA" "AU" "CNC" "CNF" )
for elem in ${IDsarr[@]}
do
  grep "^$elem" ${fileroot}.stripped > ${fileroot}.${elem}
  ttlcnt=$(grep "^$elem" ${fileroot}.stripped | wc -l)
  echo "Total $elem reports: $ttlcnt" >> ${fileroot}.${elem}
  echo "Total $elem reports: $ttlcnt" >> $emailfile
  echo "" >> $emailfile
done
basearr=( "AG" "ANZ" "HK" "JP" "NZL" "QFA" "SL" )
for base in ${basearr[@]}
do
  grep "^$base" ${fileroot}.stripped > ${fileroot}.${base}
  ttlcnt=$(grep "^$base" ${fileroot}.stripped | wc -l)
  echo "Total $base reports: $ttlcnt" >> ${fileroot}.${base}
  echo "Total $base reports: $ttlcnt" >> $emailfile
  unq=$(expr $(grep "^$base" ${fileroot}.stripped | sort | uniq | wc -l))
  echo "Total $base unique IDs: $unq" >> ${fileroot}.${base}
  echo "Total $base unique IDs: $unq" >> $emailfile
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
    res=$(grep "^${elem}" ${fileroot}.stripped | wc -l)
    echo "Total ${elem}* reports: ${res}" >> ${fileroot}.${base}
    echo "Total ${elem}* reports: ${res}" >> $emailfile
  done
  echo "" >> $emailfile
done
#echo "" >> $emailfile
# For those IDs where there is no further resolution
IDsarr=( "AAL" "ACA" "ACI" "AFR" "ASY" "AVN" "AXM" "CAL" "CCA" "CES" "CSN" "DAL" "FDX" "FJA" "FJI" "HAL" "IBE" "ICE" "JST" "KAL" "KIW" "LAN" "LOBO" "LUC" "MAS" "MXD" "PAC" "PAL" "RCH" "RZO" "SIA" "SQC" "TAP" "TCV" "THA" "THT" "TMN" "UAE" "UAL" "UPS" "VOZ" "XAX" "^N[0-9]" )
for elem in ${IDsarr[@]}
do
  pwd
  grep "${elem}" ${fileroot}.stripped > ${fileroot}.${elem}
  ttlcnt=$(grep "${elem}" ${fileroot}.stripped | wc -l)
  if [ $ttlcnt -ge 100 ]; then
    alert=" ....... >> 100 !!"
  else
    alert=""
  fi
  echo "Total ${elem} reports: $ttlcnt" >> ${fileroot}.${elem}
  echo "Total ${elem} reports: $ttlcnt $alert" >> $emailfile
  unq=$(expr $(grep "${elem}" ${fileroot}.stripped | sort | uniq | wc -l))
# echo "Total ${elem} unique IDs: $unq" >> ${fileroot}.${elem}
# echo "Total ${elem} unique IDs: $unq" >> $emailfile
  echo "" >> $emailfile
done

# add logic to deal w/ potential new or unaccounted IDs
pattern="JP -e NZL -e HK0 -e AXM -e ANZ -e MXD -e SIA -e AVN -e ACA -e FJA -e LAN -e TAP -e DAL -e CSN -e LOBO -e ACI -e AFR -e VOZ -e THT -e FJI -e UAL -e QFA -e FDX -e JST -e KAL -e MAS -e THA -e UAE -e UPS -e HAL -e TMN -e RZO -e CAL -e SQC -e PAL -e TCV -e ASY -e RCH -e IBE -e ICE -e PAC -e LUC -e KIW -e AAL -e CES -e AG -e CCA -e XAX -e SL"
newids_cnt=$(grep -v -e $pattern -e "^N[0-9]" ${fileroot}.stripped | wc -l)
if [ $newids_cnt > 0 ]; then
  newids=$(grep -v -e $pattern -e "^N[0-9]" ${fileroot}.stripped | sort | uniq -c)
  echo "Total new or unaccounted IDs: " $newids_cnt >> $emailfile
  echo $newids >> $emailfile
fi

# NC004006 counts have stablized; no longer necessary to monitor these counts
# Write NC004006 counts to $emailfile for comparison; 00Z cycle only
: <<"SKIP"
if [ "$cyc" == "00" ]; then
  echo "" >> $emailfile
  cat ${eufile} >> $emailfile
fi
SKIP

# add note/key to bottom of email
echo "" >> $emailfile
echo "" >> $emailfile
echo "Numbers set off in '(' and ')' represent averages calculated from the 10 day baseline for NC004003." >> $emailfile


# email cron summary
addy=shelley.melchior@noaa.gov
sbj="amdar tank summary - ${PDY}${cyc} - dumpjb"
mail -s "$sbj" $addy < $emailfile

echo "---- DONE ----"

exit

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
