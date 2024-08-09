# nodd_wrapper_20members.sh
# This script wraps around arraytest_20members.sh to run on many dates

# Define incoming arguments
datestart=$1           # for example, 20230101
dateend=$2             # for example, 20230201
export NODD_SCRIPT_ROOT=/lfs/h2/emc/vpppg/noscrub/shelley.melchior/pgc/AV-scripts
export dest=/lfs/h2/emc/pgctemp/gefs_forecasts/nodd_output
cd $NODD_SCRIPT_ROOT
echo "Starting on: $datestart"
echo "Ending on: $dateend"

# Define array of dates upon which to operate
while [[ "$datestart" != "$dateend" ]]; do
  # Kick off the driver script
  #echo "./array_test.sh $datestart"
  echo "sh $NODD_SCRIPT_ROOT/arraytest_20members.sh $datestart"
  #./array_test.sh $datestart
  sh $NODD_SCRIPT_ROOT/arraytest_20members.sh $datestart
  chmod -R 775 $dest/gefs.${datestart}
  datestart=$(date --date "$datestart + 1 day" +"%Y%m%d")
done
