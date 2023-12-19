#!/bin/bash

# Simple shell script to submit many EVS drivers into scheduler

#####

driverdir=/lfs/h2/emc/vpppg/noscrub/shelley.melchior/githubwkspc/forks/SS/EVS/dev/drivers/scripts/plots/global_ens
for driver in "$driverdir"/*; do
  echo $driver
  qsub $driver
done

#####

#driver=/lfs/h2/emc/vpppg/noscrub/shelley.melchior/githubwkspc/forks/HCH/EVS/dev/drivers/scripts/stats/aqm/jevs_aqm_grid2obs_stats.sh

#vhrlist=( 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 )
#vhrlist=( 23 )
#for i in "${vhrlist[@]}"
#  do
#    echo "qsub -v vhr=$i $driver"
#    qsub -v vhr=$i $driver
#done
