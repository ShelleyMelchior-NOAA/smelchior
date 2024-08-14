#!/bin/bash

# Script to rename GEFS forecast files downloaded from NODD to be in the convention expected by EVS
# for subsequent prep and stats processing.

PDY=$1  # PDY passed in as argument

memberarr="01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20"
cyclearr="00 06 12 18"
forecastleadarr="00 06 12 18 24 30 36 42 48 54 60 66 72 78 84 90 96 102 108 114 120 126 132 138 144 150 156 162 168 174 180 186 192 198 204 210 216 222 228 234 240 246 252 258 264 270 276 282 288 294 300 306 312 318 324 330 336 342 348 354 360 366 372 378 384"

for cyc in ${cyclearr[@]}; do
  #dir=/lfs/h2/emc/ptmp/shelley.melchior/gefs.${PDY}/${cyc}/atmos
  dir=/lfs/h2/emc/pgctemp/gefs_forecasts/nodd_output/gefs.${PDY}/${cyc}/atmos
  cd $dir
  pwd
  for mem in ${memberarr[@]}; do
    for flead in ${forecastleadarr[@]}; do
      for file in gep${mem}.t${cyc}z.pgrb2af${flead}; do
	echo $file
        filenew=$(echo $file | sed 's/gep'${mem}'\.t'${cyc}'z\.pgrb2a/gep'${mem}'\.t'${cyc}'z\.pgrb2a\.0p50\./')
	echo $filenew
	mv $file $filenew
	if [[ "$flead" -lt 100 ]]; then
	  flead2="0"$flead
	  mv gep${mem}.t${cyc}z.pgrb2a.0p50.f${flead} gep${mem}.t${cyc}z.pgrb2a.0p50.f${flead2}
	fi
      done
    done
  done
done

exit
