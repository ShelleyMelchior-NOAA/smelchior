# nodd_wrapper.sh
# This script wraps around arraytest.sh to run on many dates

# Define incoming arguments
datestart=$1           # for example, 20230101
dateend=$2             # for example, 20230201
export NODD_SCRIPT_ROOT=/lfs/h2/emc/vpppg/noscrub/steven.simon/nodd_scripts
cd $NODD_SCRIPT_ROOT
echo "Starting on: $datestart"
echo "Ending on: $dateend"

# Define array of dates upon which to operate
while [[ "$datestart" != "$dateend" ]]; do
  # Kick off the driver script
  #echo "./array_test.sh $datestart"
  echo "sh $NODD_SCRIPT_ROOT/arraytest.sh $datestart"
  #./array_test.sh $datestart
  sh $NODD_SCRIPT_ROOT/arraytest.sh $datestart
  datestart=$(date --date "$datestart + 1 day" +"%Y%m%d")
done
