#submit many evs jobs to qsub

submitdir=/lfs/h2/emc/vpppg/noscrub/shelley.melchior/githubwkspc/forks/PS/EVS/dev/drivers/scripts/stats/analyses
rundir=/lfs/h2/emc/ptmp/$USER/EVS_out
mkdir -p $rundir
cd $rundir

# single driver, many vhr's
driver=$submitdir/jevs_analyses_rtma_ru_grid2obs_stats.sh
#vhr_arr=( 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 )
vhr_arr=( 23 )
for vhr in ${vhr_arr[@]}; do
  echo "qsub -v vhr=$vhr $driver"
  qsub -v vhr=$vhr $driver
done

exit

# many drivers
for driver in $submitdir/jevs_cam_href*90*
do
  echo "qsub $driver"
  qsub $driver
done

