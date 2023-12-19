#submit many evs jobs to qsub

submitdir=/lfs/h2/emc/vpppg/noscrub/shelley.melchior/githubwkspc/forks/BZ/EVS/dev/drivers/scripts/plots/cam
rundir=/lfs/h2/emc/ptmp/$USER/EVS_out
mkdir -p $rundir
cd $rundir

for driver in $submitdir/jevs_cam_href*
do
  echo "qsub $driver"
  qsub $driver
done

