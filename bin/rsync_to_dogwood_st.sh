#!/bin/bash
#PBS -N rsync2dogwood
#PBS -o /u/shelley.melchior/rsync_dogwood.out
#PBS -e /u/shelley.melchior/rsync_dogwood.out
#PBS -l select=1:ncpus=1:mem=1000MB
#PBS -q dev_transfer
#PBS -A VERF-DEV
#PBS -l walltime=03:30:00

module load rsync/3.2.2

#dtgarr="20240325"
#modelarr="cmce ecme gefs gfs naefs"
modelarr="atmos"
dtgarr="20240321 20240320"
for dtg in ${dtgarr[@]}
do
  for model in ${modelarr[@]}
  do
    echo $dtg
    echo "rsync -ahr -P /lfs/h2/emc/vpppg/noscrub/steven.simon/evs/v1.0/prep/global_ens/$model.$dtg ddxfer.wcoss2.ncep.noaa.gov:/lfs/h2/emc/vpppg/noscrub/shelley.melchior/forSSi/16dayprep/."
    rsync -ahr -P /lfs/h2/emc/vpppg/noscrub/steven.simon/evs/v1.0/prep/global_ens/$model.$dtg ddxfer.wcoss2.ncep.noaa.gov:/lfs/h2/emc/vpppg/noscrub/shelley.melchior/forSSi/16dayprep/.
  done
done

#rsync -ahr -P /lfs/h2/emc/vpppg/noscrub/steven.simon/evs/v1.0/stats/global_ens/gefs.20240326 ddxfer.wcoss2.ncep.noaa.gov:/lfs/h2/emc/vpppg/noscrub/shelley.melchior/forSSi/snow-bug-stats/.

