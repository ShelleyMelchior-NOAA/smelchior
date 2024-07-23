#!/bin/bash
#PBS -N run_gefs_nodd_scripts
#PBS -j oe
#PBS -o /lfs/h2/emc/vpppg/noscrub/shelley.melchior/pgc/nodd_output/log_gefs_pgc_data_20200927_out.txt
#PBS -q "dev_transfer"
#PBS -A VERF-DEV
#PBS -l walltime=06:00:00
#PBS -l select=1:ncpus=1:mem=50GB
#PBS -l debug=true

set -x

export STARTDATE=20200927
export ENDDATE=20200928 #Not inclusive

. /lfs/h2/emc/vpppg/noscrub/$USER/pgc/SSh-scripts/nodd_wrapper.sh $STARTDATE $ENDDATE
