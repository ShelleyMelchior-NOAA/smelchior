#!/bin/bash
#PBS -N rsync2cactus
#PBS -o /u/shelley.melchior/rsync_cactus.out
#PBS -e /u/shelley.melchior/rsync_cactus.out
#PBS -l select=1:ncpus=1:mem=1000MB
#PBS -q dev_transfer
#PBS -A VERF-DEV
#PBS -l walltime=03:30:00

module load rsync/3.2.2

#modelarr="cmce ecme gefs gfs naefs"
modelarr="ccpa gdas gfs"
#modelarr="atmos"
#dtgarr="20210401 20210402"
#dtgarr="20210401 20210402 20210403 20210404 20210405 20210406 20210407 20210408 20210409 20210410 20210411 20210412 20210413 20210414 20210415 20210416 20210417 20210418 20210419 20210420 20210421 20210422 20210423 20210424 20210425 20210426 20210427 20210428 20210429 20210430"
dtgarr="20210403 20210404 20210405 20210406 20210407 20210408 20210409 20210410 20210411 20210412 20210413 20210414 20210415 20210416 20210417 20210418 20210419 20210420 20210421 20210422 20210423 20210424 20210425 20210426 20210427 20210428 20210429 20210430"
for dtg in ${dtgarr[@]}
do
  for model in ${modelarr[@]}
  do
    echo $model
    echo $dtg
    echo "rsync -ahr -P /lfs/h2/emc/pgctemp/anl/$model.$dtg cdxfer.wcoss2.ncep.noaa.gov:/lfs/h2/emc/pgctemp/anl/."
    rsync -ahr -P /lfs/h2/emc/pgctemp/anl/$model.$dtg cdxfer.wcoss2.ncep.noaa.gov:/lfs/h2/emc/pgctemp/anl/.
  done
done

#rsync -ahr -P /lfs/h2/emc/vpppg/noscrub/steven.simon/metplusworkspace/EVS cdxfer.wcoss2.ncep.noaa.gov:/lfs/h2/emc/vpppg/noscrub/shelley.melchior/forSSi/EVS/.

