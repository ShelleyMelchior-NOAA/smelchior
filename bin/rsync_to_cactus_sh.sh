#!/bin/bash
#PBS -N rsync2cactus
#PBS -o /u/shelley.melchior/rsync_cactus.out
#PBS -e /u/shelley.melchior/rsync_cactus.out
#PBS -l select=1:ncpus=1:mem=1000MB
#PBS -q dev_transfer
#PBS -A VERF-DEV
#PBS -l walltime=02:00:00

module load rsync/3.2.2

dtgarr="20240418 20240419 20240420"
#dtgarr="20240407 20240408 20240409 20240410 20240411 20240412 20240413 20240414 20240415 20240416 20240417 20240418 20240419 20240420"
for dtg in ${dtgarr[@]}
do
  echo $dtg
  echo "rsync -ahr -P /lfs/h2/emc/vpppg/noscrub/shannon.shields/EVS_Data/evs/v1.0/prep/subseasonal/atmos.$dtg cdxfer.wcoss2.ncep.noaa.gov:/lfs/h2/emc/vpppg/noscrub/shelley.melchior/forSS/."
  rsync -ahr -P /lfs/h2/emc/vpppg/noscrub/shannon.shields/EVS_Data/evs/v1.0/prep/subseasonal/atmos.$dtg cdxfer.wcoss2.ncep.noaa.gov:/lfs/h2/emc/vpppg/noscrub/shelley.melchior/forSS/.
done

#rsync -ahr -P /lfs/h2/emc/vpppg/noscrub/shannon.shields/EVS_Data/evs/v1.0/prep/subseasonal/atmos.20240312 ddxfer.wcoss2.ncep.noaa.gov:/lfs/h2/emc/vpppg/noscrub/shelley.melchior/forSS/.

