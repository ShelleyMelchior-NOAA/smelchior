#!/bin/ksh
# Russ Treadon's stand alone test for prepobs_prepdata

#BSUB -J test_prepdata
#BSUB -o test_prepdata.o%J
#BSUB -e test_prepdata.o%J
#BSUB -q devmax
#BSUB -P FV3GFS-T2O
#BSUB -W 00:10
#BSUB -R span[ptile=1]
#BSUB -R affinity[core(1)]
#BSUB -n 1
#BSUB -x

set -ax
if [ ! -z $MODULESHOME ]; then
    . $MODULESHOME/init/bash
else
    . /opt/modules/default/init/bash
fi

module purge
module load EnvVars/1.0.3
module load lsf/10.1
module load ips/18.0.1.163
module load impi/18.0.1
module load prod_util/1.1.0
module load prod_envir/1.1.0
module load NetCDF/4.5.0

module list


export CDATE=2018011006
export CDUMP=gfs

##export compression=nemsio
##export format=nemsio

##export compression=nc_lossless
export compression=nc_lossy
export format=nc


DATA=/gpfs/dell2/stmp/$LOGNAME/test_prepdata.$compression.run2
rm -rf $DATA
mkdir -p $DATA
cd $DATA

export PDY=`echo $CDATE | cut -c1-8`
export cyc=`echo $CDATE | cut -c9-10`

##export COMIN=$COMROOTp3/gfs/para/$CDUMP.$PDY/$cyc
##export COMSP=$COMIN/$CDUMP.t${cyc}z.

export COMIN=/gpfs/dell2/emc/modeling/noscrub/emc.glopara/git/obsproc/netcdf/obsproc_prep_RB-5.2.0/CASES/$CDUMP.${PDY}_$compression/$cyc/
DMPROOT=`echo $NWROOTp1 | cut -d"/" -f1-3`
export COMSP=$DMPROOT/emc/globaldump/$CDATE/$CDUMP/$CDUMP.t${cyc}z.

export dump_dir=$COMIN
export COMOUT=/gpfs/dell3/ptmp/$LOGNAME/test_prepdata/$CDUMP.$PDY/$cyc

export PREPDATA_STDIN=/gpfs/dell2/emc/modeling/noscrub/emc.glopara/git/obsproc/netcdf/obsproc_prep_RB-5.2.0/prfv3rt3c_gdasprep_12.11061863/prepdata.stdin
##export PREPDATA_STDIN=/gpfs/dell2/emc/modeling/noscrub/emc.glopara/git/obsproc/netcdf/obsproc_prep_RB-5.2.0/prfv3rt3c_gdasprep_12.11061863/prepdata.stdin.preven_false

##export PRPX=/gpfs/dell2/emc/modeling/noscrub/emc.glopara/git/obsproc/OT-obsproc_prep.v5.2.0-20190614/exec/prepobs_prepdata
##export PRPX=/gpfs/dell2/emc/modeling/noscrub/emc.glopara/git/obsproc/netcdf/obsproc_prep_RB-5.2.0/exec/prepobs_prepdata
export PRPX=/gpfs/dell2/emc/modeling/noscrub/emc.glopara/git/obsproc/OT-obsproc_prep.v5.2.0-20190614.netcdf/exec/prepobs_prepdata
export PRPT=/gpfs/dell1/nco/ops/nwpara/obsproc_prep.v5.2.0/fix/prepobs_prep.bufrtable
export PRVT=/gpfs/dell2/emc/modeling/noscrub/emc.glopara/git/global-workflow/feature_dev-v15.2.errtable/fix/fix_gsi/prepobs_errtable.global
export LANDC=/gpfs/dell2/emc/modeling/noscrub/emc.glopara/git/obsproc/OT-obsproc_prep.v5.2.0-20190614/fix/prepobs_landc

export SGES=$COMIN/$CDUMP.t${cyc}z.atmges.$format
export SGESA=/dev/null
export BUFRLIST="adpupa proflr aircar aircft satwnd adpsfc  sfcshp vadwnd wdsatr ascatw rassda gpsipw"

BUFRLIST_all="adpupa aircar aircft satwnd proflr vadwnd rassda adpsfc sfcshp sfcbog msonet spssmi erscat qkswnd wdsatr ascatw rtovs atovs goesnd gpsipw"
set -A BUFRLIST_all_array `echo $BUFRLIST_all` # this works on all platforms

export tmmark=tm00
export dump_dir=$DATA

# Copy input to $DATA.  Create files.
for name in ${BUFRLIST} ;do
   > $name
   if [ -s ${COMSP}${name}.${tmmark}.bufr_d ]; then
      cp ${COMSP}${name}.${tmmark}.bufr_d $name
   fi
done

echo "      $CDATE" > cdate10.dat


# Set variables
export FORT11=$DATA/cdate10.dat
export FORT12=$PRPT
export FORT15=$LANDC

ln -sf $SGES              fort.18
ln -sf $SGESA             fort.19
export FORT20=$PRVT
export FORT21=$dump_dir/${BUFRLIST_all_array[0]}
export FORT22=$dump_dir/${BUFRLIST_all_array[1]}
export FORT23=$dump_dir/${BUFRLIST_all_array[2]}
export FORT24=$dump_dir/${BUFRLIST_all_array[3]}
export FORT25=$dump_dir/${BUFRLIST_all_array[4]}
export FORT26=$dump_dir/${BUFRLIST_all_array[5]}
export FORT27=$dump_dir/${BUFRLIST_all_array[6]}
export FORT31=$dump_dir/${BUFRLIST_all_array[7]}
export FORT32=$dump_dir/${BUFRLIST_all_array[8]}
export FORT33=$dump_dir/${BUFRLIST_all_array[9]}
export FORT34=$dump_dir/${BUFRLIST_all_array[10]}
export FORT35=$dump_dir/${BUFRLIST_all_array[11]}
export FORT36=$dump_dir/${BUFRLIST_all_array[12]}
export FORT37=$dump_dir/${BUFRLIST_all_array[13]}
export FORT38=$dump_dir/${BUFRLIST_all_array[14]}
export FORT39=$dump_dir/${BUFRLIST_all_array[15]}
export FORT41=$dump_dir/${BUFRLIST_all_array[16]}
export FORT42=$dump_dir/${BUFRLIST_all_array[17]}
export FORT46=$dump_dir/${BUFRLIST_all_array[18]}
export FORT48=$dump_dir/${BUFRLIST_all_array[19]}
export FORT51=prepda
export FORT52=prevents.filtering.prepdata

##export IOBUF_PARAMS='*prevents.filtering.prepdata:verbose'

cp $PREPDATA_STDIN stdin

# Execute prepobs_prepdata
$PRPX < stdin 1> stdout 2> stderr
rc=$?

exit

