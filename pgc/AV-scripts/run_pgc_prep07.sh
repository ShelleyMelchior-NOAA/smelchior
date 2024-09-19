#!/bin/bash -l

rundate=20190701
enddate=20190731

rundir=/lfs/h2/emc/ptmp/${USER}/pgc_drivers
mkdir -p $rundir
cd $rundir

while [[ "$rundate" -le "$enddate" ]]; do
  echo $rundate
  if [ -s pgc_prep.${rundate}.sh ]; then
     rm -f pgc_prep.${rundate}.sh
  fi

# create job card ###################################################
touch pgc_prep.${rundate}.sh
echo '#PBS -N jevs_global_ens_atmos_prep' >> pgc_prep.${rundate}.sh
echo '#PBS -j oe' >> pgc_prep.${rundate}.sh 
echo '#PBS -S /bin/bash' >> pgc_prep.${rundate}.sh
echo '#PBS -q dev' >> pgc_prep.${rundate}.sh
echo '#PBS -A VERF-DEV' >> pgc_prep.${rundate}.sh
echo '#PBS -l walltime=06:00:00' >> pgc_prep.${rundate}.sh
echo '#PBS -l place=vscatter:exclhost,select=2:ncpus=42:mem=500GB' >> pgc_prep.${rundate}.sh
echo '#PBS -l debug=true' >> pgc_prep.${rundate}.sh
echo ' ' >> pgc_prep.${rundate}.sh
echo 'set -x' >> pgc_prep.${rundate}.sh
echo ' ' >> pgc_prep.${rundate}.sh
echo export PDY=${rundate} >> pgc_prep.${rundate}.sh
echo ' ' >> pgc_prep.${rundate}.sh
echo 'export OMP_NUM_THREADS=1' >> pgc_prep.${rundate}.sh
echo 'export HOMEevs=/lfs/h2/emc/vpppg/noscrub/${USER}/EVS' >> pgc_prep.${rundate}.sh
echo 'source $HOMEevs/versions/run.ver' >> pgc_prep.${rundate}.sh
echo ' ' >> pgc_prep.${rundate}.sh
echo 'export envir=prod' >> pgc_prep.${rundate}.sh
echo 'export NET=evs' >> pgc_prep.${rundate}.sh
echo 'export RUN=atmos' >> pgc_prep.${rundate}.sh
echo 'export STEP=prep' >> pgc_prep.${rundate}.sh
echo 'export COMPONENT=global_ens' >> pgc_prep.${rundate}.sh
echo 'export VERIF_CASE=grid2grid' >> pgc_prep.${rundate}.sh
echo 'export MODELNAME=gefs' >> pgc_prep.${rundate}.sh
echo ' ' >> pgc_prep.${rundate}.sh
echo 'module reset' >> pgc_prep.${rundate}.sh
echo 'module load prod_envir/${prod_envir_ver}' >> pgc_prep.${rundate}.sh
echo ' ' >> pgc_prep.${rundate}.sh
echo 'source $HOMEevs/dev/modulefiles/$COMPONENT/${COMPONENT}_${STEP}.sh' >> pgc_prep.${rundate}.sh
echo ' ' >> pgc_prep.${rundate}.sh
echo 'evs_ver_2d=$(echo $evs_ver | cut -d"." -f1-2)' >> pgc_prep.${rundate}.sh
echo ' ' >> pgc_prep.${rundate}.sh
echo 'export KEEPDATA=YES' >> pgc_prep.${rundate}.sh
echo ' ' >> pgc_prep.${rundate}.sh
echo 'export vhr=00' >> pgc_prep.${rundate}.sh
echo 'export COMIN=/lfs/h2/emc/vpppg/noscrub/${USER}/wpc_pgc/$NET/$evs_ver_2d' >> pgc_prep.${rundate}.sh
echo 'export COMINgefs=/lfs/h2/emc/pgctemp/gefs_forecasts/nodd_output' >> pgc_prep.${rundate}.sh
echo 'export COMINgfs=/lfs/h2/emc/pgctemp/analyses' >> pgc_prep.${rundate}.sh
echo 'export COMINccpa=/lfs/h2/emc/pgctemp/analyses' >> pgc_prep.${rundate}.sh
echo 'export COMINobsproc=/lfs/h2/emc/pgctemp/analyses' >> pgc_prep.${rundate}.sh
echo 'export COMOUT=/lfs/h2/emc/vpppg/noscrub/${USER}/wpc_pgc/$NET/$evs_ver_2d' >> pgc_prep.${rundate}.sh
echo 'export FIXevs=/lfs/h2/emc/vpppg/noscrub/emc.vpppg/verification/EVS_fix' >> pgc_prep.${rundate}.sh
echo 'export DATAROOT=/lfs/h2/emc/stmp/${USER}/evs_test/$envir/tmp' >> pgc_prep.${rundate}.sh
echo ' ' >> pgc_prep.${rundate}.sh
echo 'export job=${PBS_JOBNAME:-jevs_${MODELNAME}_${VERIF_CASE}_${STEP}}' >> pgc_prep.${rundate}.sh
echo 'export jobid=$job.${PBS_JOBID:-$$}' >> pgc_prep.${rundate}.sh
echo ' ' >> pgc_prep.${rundate}.sh
echo '#export SENDMAIL=YES' >> pgc_prep.${rundate}.sh
echo 'export MAILTO="shelley.melchior@noaa.gov"' >> pgc_prep.${rundate}.sh
echo ' ' >> pgc_prep.${rundate}.sh
echo 'if [ -z "$MAILTO" ]; then' >> pgc_prep.${rundate}.sh
echo '   echo "MAILTO variable is not defined. Exiting without continuing."' >> pgc_prep.${rundate}.sh
echo 'else' >> pgc_prep.${rundate}.sh
echo '   ${HOMEevs}/jobs/JEVS_GLOBAL_ENS_PREP' >> pgc_prep.${rundate}.sh
echo 'fi' >> pgc_prep.${rundate}.sh

#####################################################################

  qsub pgc_prep.${rundate}.sh
  sleep 20m

  rundate=$(date --date "$rundate + 1 day" +"%Y%m%d")
done

exit
