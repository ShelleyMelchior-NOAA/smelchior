
# It turns out wildcards (*) are not support for wget. So you will need to do several nested loops and arrays.

# wget command example
#wget https://noaa-gefs-pds.s3.amazonaws.com/gefs.YYYYMMDD/CC/atmos/pgrb2ap5/gep${member}.t${cyc}z.pgrb2a.0p50.f${flead}
echo $(date)

url="https://noaa-gefs-pds.s3.amazonaws.com"
#dest="/lfs/h2/emc/pgctemp/gefs_forecasts/nodd_output"
PDY=$1
cyclearr="00 06 12 18"
date_switch20180726=20180726
date_switch20200922=20200922
if [[ "$PDY" > "$date_switch20200922" ]]; then
    memberarr="01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30"
else
    memberarr="01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20"
fi
forecastleadarr="000 006 012 018 024 030 036 042 048 054 060 066 072 078 084 090 096 102 108 114 120 126 132 138 144 150 156 162 168 174 180 186 192 198 204 210 216 222 228 234 240 246 252 258 264 270 276 282 288 294 300 306 312 318 324 330 336 342 348 354 360 366 372 378 384"
if [ "$PDY" -gt "$date_switch20180726" ] && [ "$PDY" -le "$date_switch20200922" ]; then
  forecastleadarr="00 06 12 18 24 30 36 42 48 54 60 66 72 78 84 90 96 102 108 114 120 126 132 138 144 150 156 162 168 174 180 186 192 198 204 210 216 222 228 234 240 246 252 258 264 270 276 282 288 294 300 306 312 318 324 330 336 342 348 354 360 366 372 378 384"
fi


for cyc in ${cyclearr[@]}
do
  for mem in ${memberarr[@]}
  do
    for flead in ${forecastleadarr[@]}
    do	    
      echo $cyc
      echo $mem
      echo $flead
      if [ ! -d $dest/gefs.${PDY}/${cyc}/atmos ]; then
          mkdir -p $dest/gefs.${PDY}/${cyc}/atmos
      fi
      if [ "$PDY" -gt "$date_switch20200922" ]; then
          file_name=gep${mem}.t${cyc}z.pgrb2a.0p50.f${flead}
      else
          file_name=gep${mem}.t${cyc}z.pgrb2af${flead}
	  if [ "$PDY" -gt "$date_switch20180726" ] && [ "$PDY" -le "$date_switch20200922" ]; then
        	  if [[ "$flead" -lt 100 ]]; then
	            flead2="0"$flead
	          else
	            flead2=$flead
		  fi
	  fi
	  flead2=$flead
	  echo $flead2
	  file_name2=gep${mem}.t${cyc}z.pgrb2a.0p50.f${flead2}
      fi
      if [ "$PDY" -gt "$date_switch20180726" ]; then
        echo "wget -O $dest/gefs.${PDY}/${cyc}/atmos/${file_name2} $url/gefs.${PDY}/${cyc}/pgrb2a/${file_name}"
        wget -O $dest/gefs.${PDY}/${cyc}/atmos/${file_name2} $url/gefs.${PDY}/${cyc}/pgrb2a/${file_name} -q -o /dev/null
      else
        echo "wget -O $dest/gefs.${PDY}/${cyc}/atmos/${file_name2} $url/gefs.${PDY}/${cyc}/${file_name}"
        wget -O $dest/gefs.${PDY}/${cyc}/atmos/${file_name2} $url/gefs.${PDY}/${cyc}/${file_name} -q -o /dev/null
      fi
    done  
  done
done

echo $(date)
