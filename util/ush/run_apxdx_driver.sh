. /u/Shelley.Melchior/.bashrc

set -x

# Set up driver to run on WCOSS ph3: mars/venus
module load ips/18.0.5.274
module load prod_util/1.1.6
module load prod_envir/1.1.0

# bufr_util is now in operations; no longer need JA's installation
#module use -a /gpfs/dell2/emc/obsproc/noscrub/Jeff.Ator/NCEPLIBS-bufr/modulefiles
module load bufr_util/1.0.0

#export APXDX_EXCLUDE=xx002

export APXDX_TYPE=decoder
#export APXDX_TYPE=satingest

envir=prod
TANK_ROOT=$DCOMROOT/${envir}


BUFRTAB_ROOT=$NWROOT/decoders/decod_shared/fix
#BUFRTAB_ROOT=$NWROOT/obsproc_satingest.v3.10.4/fix

# satingest
#BUFRTAB=bufrtab.003
#BUFRTAB=bufrtab.005
#BUFRTAB=bufrtab.008
#BUFRTAB=bufrtab.012
#BUFRTAB=bufrtab.021

# decoder
BUFRTAB=bufrtab.000
#BUFRTAB=bufrtab.001
#BUFRTAB=bufrtab.002
#BUFRTAB=bufrtab.004
#BUFRTAB=bufrtab.006
#BUFRTAB=bufrtab.007
#BUFRTAB=bufrtab.031
#BUFRTAB=bufrtab.255

# Dev location for apxdx scripts, for testing and development
export utilush=/gpfs/dell2/emc/obsproc/noscrub/$USER/gitwkspc/EMC_obsproc/util/ush
export utilexec=/gpfs/dell2/emc/obsproc/noscrub/Jeff.Ator/NCEPLIBS-bufr/utilities/apxdx

#sh $RUN_APXDX $TANK_ROOT ${BUFRTAB_ROOT}/${BUFRTAB}  #command to run prod version (must have bufr_util module loaded)
echo "sh ${utilush}/run_apxdx.sh $TANK_ROOT ${BUFRTAB_ROOT}/${BUFRTAB}"
sh ${utilush}/run_apxdx.sh $TANK_ROOT ${BUFRTAB_ROOT}/${BUFRTAB}

