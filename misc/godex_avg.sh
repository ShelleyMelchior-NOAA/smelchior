# Generate monthly average counts for GODEX slides

# Usage and incoming var information
test $# -lt 2 && echo "Usage: $0 <bbb.xxx> <YYYY>"
test $# -lt 2 && exit

# Define yyyymm array
if [ "$2" = "2018" ]; then
  yyyymmarr=(201810 201811 201812)
elif [ "$2" = "2019" ]; then
  yyyymmarr=(201901 201902 201903 201904 201905 201906 201907 201908 201909 201910 201911 201912)
elif [ "$2" = "2020" ]; then
  yyyymmarr=(202001 202002 202003 202004 202005)
else
  echo "<YYYY> can only be 2018, 2019, or 2020."
  exit
fi

# format $1 for grep command
b=$(echo $1 | awk -F'.' '{print $1}')
x=$(echo $1 | awk -F'.' '{print $2}')
bx="${b}\.${x}"

# Loop through yyyymmarr elements
yravgxcl="=AVERAGE("
for yyyymm in ${yyyymmarr[@]}; do
  # Define gdascount dir
  gcd=$COMROOT/gfs/prod/gdascounts/data_counts.$yyyymm
  echo "gdascounts dir is: $gcd"

  # Test that $gcd exists
  if [ ! -d "$gcd" ]
  then
    echo "gdas counts dir DOES NOT exist!"
    exit
  fi

  rpts_arr=($(grep "$bx" $gcd/gdas.t00z.status.tm00.bufr_d.${yyyymm}* | grep HAS | rev | awk -F' ' '{print $2}' | rev))

  echo "Reports for ${yyyymm}:"
  echo ${rpts_arr[*]}

  arrsiz=${#rpts_arr[*]}
  echo $arrsiz

  # Calculate sum 
  sum=0
  cntr=$arrsiz
  echo "counter is: $cntr"
  while [ $cntr -gt 0 ]
  do
    element=${rpts_arr[`expr $cntr - 1`]}
    # check to make sure $element is a number
    if [[ $element =~ "HAS" ]]; then
      element=$(echo $element | cut -c4-)
    fi
    sum=`expr $sum + $element`
    cntr=`expr $cntr - 1`
  done

  # Calculate average
  avg=`echo "$sum / $arrsiz" | bc -l`
  avg_int=`printf "%.0f\n" $avg`
  echo "Average for $1 for ${yyyymm} is: $avg_int"
  yravgxcl="${yravgxcl}$avg_int,"
done   # for yyyymm

yravgxcl_formatted=$(echo ${yravgxcl} | rev | cut -c2- | rev)
echo "${yravgxcl_formatted})"
