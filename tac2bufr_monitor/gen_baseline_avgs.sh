# Generate averages for the 4 cycles (00, 06, 12, 18) represented in the 9 
# dates stored in /meso/noscrub/Shelley.Melchior/TAC2BUFR/10day 
# Averages:
#  binv subset counts
#  AFZA total reprots, unique IDs, binned ID prefixes 
#  AU total reprots, unique IDs, binned ID prefixes 
#  CNC total reprots, unique IDs, binned ID prefixes 
#  CNF total reprots, unique IDs, binned ID prefixes 
#  EU total reprots, unique IDs, binned ID prefixes 
#  JP total reprots, unique IDs, binned ID prefixes 
#  NZL total reprots, unique IDs, binned ID prefixes 

tendaydir=/meso/noscrub/Shelley.Melchior/TAC2BUFR/10day
cd $tendaydir
subsetsummary=$tendaydir/subsetsummary.txt
[[ -e $subsetsummary ]] && rm $subsetsummary
touch $subsetsummary

cycarr=( 00 06 12 18 )

# --- BINV / GO_CHKDAT ---

# all dates and cycles
ttl=0
i=0
for file in $tendaydir/NC004003.201??????? ; do
  go_chkdat $file > rpts
  count=$(cat rpts | awk -F' rpts' '{print $1}' | awk -F'NC004003' '{print $NF}' | sed 's/^ *//g')
  ttl=`expr $ttl + $count`
  i=`expr $i + 1`
done
avg=$(echo "scale=2; ${ttl}/${i}" | bc)
echo "Avg rpts for all dates/cycles: $avg"
echo "Avg rpts for all dates/cycles: $avg" >> $subsetsummary

for cyc in ${cycarr[@]}
do
  ttl=0
  i=0
  for file in $tendaydir/NC004003.201?????${cyc} ; do
    go_chkdat $file > rpts
    count=$(cat rpts | awk -F' rpts' '{print $1}' | awk -F'NC004003' '{print $NF}' | sed 's/^ *//g')
    ttl=`expr $ttl + $count`
    i=`expr $i + 1`
  done
  avg=$(echo "scale=2; ${ttl}/${i}" | bc)
  echo "Avg rpts for ${cyc}z: $avg"
  echo "Avg rpts for ${cyc}z: $avg" >> $subsetsummary
done
rm rpts


# --- AFZA ---

AFZAarr=( "AFZA_reports" "AFZA_unique_IDs" "AFZA0\*_reports" "AFZA1\*_reports" "AFZA2\*_reports" "AFZA3\*_reports" "AFZA4\*_reports" "AFZA5\*_reports" "AFZA6\*_reports" "AFZA7\*_reports" "AFZA8\*_reports" "AFZA9\*_reports" )

for cyc in ${cycarr[@]}
do
  for elem in ${AFZAarr[@]}
  do
    if [ "$elem" = "${AFZAarr[1]}" ]; then
      elem1=$(echo $elem | cut -d'_' -f1)
      elem2=$(echo $elem | cut -d'_' -f2)
      elem3=$(echo $elem | cut -d'_' -f3)
      elem="${elem1} ${elem2} ${elem3}"
    else
      elem1=$(echo $elem | cut -d'_' -f1)
      elem2=$(echo $elem | cut -d'_' -f2)
      elem="${elem1} ${elem2}"
    fi
    ttl=0
    i=0
    for file in $tendaydir/NC004003.201?????${cyc}.AFZA ; do
      total=$(cat ${file} | grep "${elem}:" | cut -d':' -f2 | sed 's/^ *//g')
      ttl=`expr $ttl + $total`
      i=`expr $i + 1`
    done
    avg=$(echo "scale=2; ${ttl}/${i}" | bc)
    echo "Avg ${elem} for ${cyc}z: $avg"
    echo "Avg ${elem} for ${cyc}z: $avg" >> $subsetsummary
  done
done

# --- AU ---

AUarr=( "AU_reports" "AU_unique_IDs" "AU00\*_reports" "AU01\*_reports" )

for cyc in ${cycarr[@]}
do
  for elem in ${AUarr[@]}
  do
    if [ "$elem" = "${AUarr[1]}" ]; then
      elem1=$(echo $elem | cut -d'_' -f1)
      elem2=$(echo $elem | cut -d'_' -f2)
      elem3=$(echo $elem | cut -d'_' -f3)
      elem="${elem1} ${elem2} ${elem3}"
    else
      elem1=$(echo $elem | cut -d'_' -f1)
      elem2=$(echo $elem | cut -d'_' -f2)
      elem="${elem1} ${elem2}"
    fi
    ttl=0
    i=0
    for file in $tendaydir/NC004003.201?????${cyc}.AU ; do
      total=$(cat ${file} | grep "${elem}:" | cut -d':' -f2 | sed 's/^ *//g')
      ttl=`expr $ttl + $total`
      i=`expr $i + 1`
    done
    avg=$(echo "scale=2; ${ttl}/${i}" | bc)
    echo "Avg ${elem} for ${cyc}z: $avg"
    echo "Avg ${elem} for ${cyc}z: $avg" >> $subsetsummary
  done
done

# --- CNC ---

CNCarr=( "CNC_reports" "CNC_unique_IDs" "CNCOVM_reports" "CNCOVL_reports" "CNCMVT_reports" "CNCMTS_reports" "CNCSVN_reports" "CNCSXK_reports")

for cyc in ${cycarr[@]}
do
  for elem in ${CNCarr[@]}
  do
    if [ "$elem" = "${CNCarr[1]}" ]; then
      elem1=$(echo $elem | cut -d'_' -f1)
      elem2=$(echo $elem | cut -d'_' -f2)
      elem3=$(echo $elem | cut -d'_' -f3)
      elem="${elem1} ${elem2} ${elem3}"
    else
      elem1=$(echo $elem | cut -d'_' -f1)
      elem2=$(echo $elem | cut -d'_' -f2)
      elem="${elem1} ${elem2}"
    fi
    ttl=0
    i=0
    for file in $tendaydir/NC004003.201?????${cyc}.CNC ; do
      total=$(cat ${file} | grep "${elem}:" | cut -d':' -f2 | sed 's/^ *//g')
      ttl=`expr $ttl + $total`
      i=`expr $i + 1`
    done
    avg=$(echo "scale=2; ${ttl}/${i}" | bc)
    echo "Avg ${elem} for ${cyc}z: $avg"
    echo "Avg ${elem} for ${cyc}z: $avg" >> $subsetsummary
  done
done

# --- CNF ---

CNFarr=( "CNF_reports" "CNF_unique_IDs" "CNFL\*_reports" "CNFM\*_reports" "CNFN\*_reports" "CNFO\*_reports" "CNFP\*_reports" "CNFQ\*_reports" "CNFR\*_reports" )

for cyc in ${cycarr[@]}
do
  for elem in ${CNFarr[@]}
  do
    if [ "$elem" = "${CNFarr[1]}" ]; then
      elem1=$(echo $elem | cut -d'_' -f1)
      elem2=$(echo $elem | cut -d'_' -f2)
      elem3=$(echo $elem | cut -d'_' -f3)
      elem="${elem1} ${elem2} ${elem3}"
    else
      elem1=$(echo $elem | cut -d'_' -f1)
      elem2=$(echo $elem | cut -d'_' -f2)
      elem="${elem1} ${elem2}"
    fi
    ttl=0
    i=0
    for file in $tendaydir/NC004003.201?????${cyc}.CNF ; do
      total=$(cat ${file} | grep "${elem}:" | cut -d':' -f2 | sed 's/^ *//g')
      ttl=`expr $ttl + $total`
      i=`expr $i + 1`
    done
    avg=$(echo "scale=2; ${ttl}/${i}" | bc)
    echo "Avg ${elem} for ${cyc}z: $avg"
    echo "Avg ${elem} for ${cyc}z: $avg" >> $subsetsummary
  done
done

# --- EU ---

EUarr=( "EU_reports" "EU_unique_IDs" "EU0\*_reports" "EU1\*_reports" "EU2\*_reports" "EU3\*_reports" "EU4\*_reports" "EU5\*_reports" "EU6\*_reports" "EU7\*_reports" "EU8\*_reports" "EU9\*_reports" )

for cyc in ${cycarr[@]}
do
  for elem in ${EUarr[@]}
  do
    if [ "$elem" = "${EUarr[1]}" ]; then
      elem1=$(echo $elem | cut -d'_' -f1)
      elem2=$(echo $elem | cut -d'_' -f2)
      elem3=$(echo $elem | cut -d'_' -f3)
      elem="${elem1} ${elem2} ${elem3}"
    else
      elem1=$(echo $elem | cut -d'_' -f1)
      elem2=$(echo $elem | cut -d'_' -f2)
      elem="${elem1} ${elem2}"
    fi
    ttl=0
    i=0
    for file in $tendaydir/NC004003.201?????${cyc}.EU ; do
      total=$(cat ${file} | grep "${elem}:" | cut -d':' -f2 | sed 's/^ *//g')
      ttl=`expr $ttl + $total`
      i=`expr $i + 1`
    done
    avg=$(echo "scale=2; ${ttl}/${i}" | bc)
    echo "Avg ${elem} for ${cyc}z: $avg"
    echo "Avg ${elem} for ${cyc}z: $avg" >> $subsetsummary
  done
done

# --- JP ---

JParr=( "JP_reports" "JP_unique_IDs" "JP9Z4\*_reports" "JP9Z5\*_reports" "JP9Z8\*_reports" "JP9ZV\*_reports" "JP9ZX\*_reports" )

for cyc in ${cycarr[@]}
do
  for elem in ${JParr[@]}
  do
    if [ "$elem" = "${JParr[1]}" ]; then
      elem1=$(echo $elem | cut -d'_' -f1)
      elem2=$(echo $elem | cut -d'_' -f2)
      elem3=$(echo $elem | cut -d'_' -f3)
      elem="${elem1} ${elem2} ${elem3}"
    else
      elem1=$(echo $elem | cut -d'_' -f1)
      elem2=$(echo $elem | cut -d'_' -f2)
      elem="${elem1} ${elem2}"
    fi
    ttl=0
    i=0
    for file in $tendaydir/NC004003.201?????${cyc}.JP ; do
      total=$(cat ${file} | grep "${elem}:" | cut -d':' -f2 | sed 's/^ *//g')
      ttl=`expr $ttl + $total`
      i=`expr $i + 1`
    done
    avg=$(echo "scale=2; ${ttl}/${i}" | bc)
    echo "Avg ${elem} for ${cyc}z: $avg"
    echo "Avg ${elem} for ${cyc}z: $avg" >> $subsetsummary
  done
done

# --- NZL ---

NZLarr=( "NZL_reports" "NZL_unique_IDs" "NZL00\*_reports" "NZL01\*_reports" "NZL02\*_reports" "NZL03\*_reports" "NZL04\*_reports" "NZL05\*_reports" "NZL06\*_reports" "NZL07\*_reports" "NZL08\*_reports" "NZL09\*_reports" )

for cyc in ${cycarr[@]}
do
  for elem in ${NZLarr[@]}
  do
    if [ "$elem" = "${NZLarr[1]}" ]; then
      elem1=$(echo $elem | cut -d'_' -f1)
      elem2=$(echo $elem | cut -d'_' -f2)
      elem3=$(echo $elem | cut -d'_' -f3)
      elem="${elem1} ${elem2} ${elem3}"
    else
      elem1=$(echo $elem | cut -d'_' -f1)
      elem2=$(echo $elem | cut -d'_' -f2)
      elem="${elem1} ${elem2}"
    fi
    ttl=0
    i=0
    for file in $tendaydir/NC004003.201?????${cyc}.NZL ; do
      total=$(cat ${file} | grep "${elem}:" | cut -d':' -f2 | sed 's/^ *//g')
      ttl=`expr $ttl + $total`
      i=`expr $i + 1`
    done
    avg=$(echo "scale=2; ${ttl}/${i}" | bc)
    echo "Avg ${elem} for ${cyc}z: $avg"
    echo "Avg ${elem} for ${cyc}z: $avg" >> $subsetsummary
  done
done

exit
