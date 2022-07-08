# cron job started on: 04/23/13 on emcdev 
# cron job turned off: 05/14/14 -- scp now initiated on wcoss
# normal operating time: 0820 (server is on ET)

# get current date
dateflag=$(date +%Y%m%d)

# scp files from wcoss (gyre and tide) to emcdev

wcossdir="/ptmpp1/Shelley.Melchior/obs_dump/log"
emcdevdir="/var/www/html/smelchior/obsdumpmonitor"

# tide 
echo "begin tide processing"
srvr="tide"
login="Shelley.Melchior@tide.ncep.noaa.gov"
emcdevdir_t="$emcdevdir/$srvr"

# Test if wcoss processing is complete
scp $login:$wcossdir/done.* $emcdevdir_t
if [ $? = 0 ] 
then
  # wcoss processing complete; test for most current date
  datetest=$(ls $emcdevdir_t/done.???????? | cut -d'.' -f2)
  rm $emcdevdir_t/done.????????
  if [ $dateflag = $datetest ] 
  then
    echo "dates agree; proceed"
    scp $login:$wcossdir/viewspalog.$dateflag.log $emcdevdir_t/viewspalog
    scp $login:$wcossdir/filestats.$dateflag.log $emcdevdir_t/filestats
    scp $login:$wcossdir/serverstats.$dateflag.log $emcdevdir_t/serverstats
    scp $login:$wcossdir/view11.$dateflag.log $emcdevdir_t/view11
    #scp $login:$wcossdir/view22n.$dateflag.log $emcdevdiv_g/view22n
    scp $login:$wcossdir/view22n_2.$dateflag.log $emcdevdir_t/view22n_2
    scp $login:$wcossdir/view22n_3.$dateflag.log $emcdevdir_t/view22n_3
    scp $login:$wcossdir/view22n_4.$dateflag.log $emcdevdir_t/view22n_4
    scp $login:$wcossdir/view22n_5.$dateflag.log $emcdevdir_t/view22n_5
    scp $login:$wcossdir/view22n_6.$dateflag.log $emcdevdir_t/view22n_6
    scp $login:$wcossdir/view22n_7a.$dateflag.log $emcdevdir_t/view22n_7a
    scp $login:$wcossdir/view22n_7b.$dateflag.log $emcdevdir_t/view22n_7b
    scp $login:$wcossdir/view22n_8.$dateflag.log $emcdevdir_t/view22n_8
    scp $login:$wcossdir/view22n_9.$dateflag.log $emcdevdir_t/view22n_9
    scp $login:$wcossdir/view22n_10.$dateflag.log $emcdevdir_t/view22n_10
    scp $login:$wcossdir/view22n_11.$dateflag.log $emcdevdir_t/view22n_11
    scp $login:$wcossdir/view22n_12.$dateflag.log $emcdevdir_t/view22n_12
    scp $login:$wcossdir/view22n_13.$dateflag.log $emcdevdir_t/view22n_13
    scp $login:$wcossdir/view22n_14.$dateflag.log $emcdevdir_t/view22n_14
    scp $login:$wcossdir/view22n_15.$dateflag.log $emcdevdir_t/view22n_15
    scp $login:$wcossdir/view22n_16.$dateflag.log $emcdevdir_t/view22n_16
    scp $login:$wcossdir/view22n_17.$dateflag.log $emcdevdir_t/view22n_17
    scp $login:$wcossdir/view22n_18.$dateflag.log $emcdevdir_t/view22n_18
    scp $login:$wcossdir/view22n_19.$dateflag.log $emcdevdir_t/view22n_19
    scp $login:$wcossdir/view22n_20.$dateflag.log $emcdevdir_t/view22n_20
    scp $login:$wcossdir/view22n_21.$dateflag.log $emcdevdir_t/view22n_21
    scp $login:$wcossdir/view22n_22.$dateflag.log $emcdevdir_t/view22n_22
    scp $login:$wcossdir/view22n_23.$dateflag.log $emcdevdir_t/view22n_23
    scp $login:$wcossdir/view22n_24.$dateflag.log $emcdevdir_t/view22n_24
    scp $login:$wcossdir/view22n_25.$dateflag.log $emcdevdir_t/view22n_25
    scp $login:$wcossdir/view22n_26.$dateflag.log $emcdevdir_t/view22n_26
    scp $login:$wcossdir/view22n_27.$dateflag.log $emcdevdir_t/view22n_27
    scp $login:$wcossdir/view22n_28.$dateflag.log $emcdevdir_t/view22n_28
    scp $login:$wcossdir/view22n_29.$dateflag.log $emcdevdir_t/view22n_29
    scp $login:$wcossdir/view22n_30.$dateflag.log $emcdevdir_t/view22n_30
    scp $login:$wcossdir/view22n_31.$dateflag.log $emcdevdir_t/view22n_31
    #scp $login:$wcossdir/view22y.$dateflag.log $emcdevdir_t/view22y
    scp $login:$wcossdir/view22y_2.$dateflag.log $emcdevdir_t/view22y_2
    scp $login:$wcossdir/view22y_3.$dateflag.log $emcdevdir_t/view22y_3
    scp $login:$wcossdir/view22y_4.$dateflag.log $emcdevdir_t/view22y_4
    scp $login:$wcossdir/view22y_5.$dateflag.log $emcdevdir_t/view22y_5
    scp $login:$wcossdir/viewfail.$dateflag.log $emcdevdir_t/viewfail
    echo "tide processing complete"
  else
    echo "dates do not agree; abort"
  fi 
else
  echo "done file missing; abort"
fi


# gyre 
echo "begin gyre processing"
srvr="gyre"
login="Shelley.Melchior@gyre.ncep.noaa.gov"
emcdevdiv_g="$emcdevdir/$srvr"

# Test if wcoss processing is complete
scp $login:$wcossdir/done.* $emcdevdiv_g
if [ $? = 0 ] 
then
  # wcoss processing complete; test for most current date
  datetest=$(ls $emcdevdiv_g/done.???????? | cut -d'.' -f2)
  arr=($datetest)
  len=${#arr[@]}
  datetest=${arr[$len-1]}
  rm $emcdevdiv_g/done.????????
  if [ $dateflag = $datetest ] 
  then
    echo "dates agree; proceed"
    scp $login:$wcossdir/viewspalog.$dateflag.log $emcdevdiv_g/viewspalog
    scp $login:$wcossdir/filestats.$dateflag.log $emcdevdiv_g/filestats
    scp $login:$wcossdir/serverstats.$dateflag.log $emcdevdiv_g/serverstats
    scp $login:$wcossdir/view11.$dateflag.log $emcdevdiv_g/view11
    #scp $login:$wcossdir/view22n.$dateflag.log $emcdevdiv_g/view22n
    scp $login:$wcossdir/view22n_2.$dateflag.log $emcdevdiv_g/view22n_2
    scp $login:$wcossdir/view22n_3.$dateflag.log $emcdevdiv_g/view22n_3
    scp $login:$wcossdir/view22n_4.$dateflag.log $emcdevdiv_g/view22n_4
    scp $login:$wcossdir/view22n_5.$dateflag.log $emcdevdiv_g/view22n_5
    scp $login:$wcossdir/view22n_6.$dateflag.log $emcdevdiv_g/view22n_6
    scp $login:$wcossdir/view22n_7a.$dateflag.log $emcdevdiv_g/view22n_7a
    scp $login:$wcossdir/view22n_7b.$dateflag.log $emcdevdiv_g/view22n_7b
    scp $login:$wcossdir/view22n_8.$dateflag.log $emcdevdiv_g/view22n_8
    scp $login:$wcossdir/view22n_9.$dateflag.log $emcdevdiv_g/view22n_9
    scp $login:$wcossdir/view22n_10.$dateflag.log $emcdevdiv_g/view22n_10
    scp $login:$wcossdir/view22n_11.$dateflag.log $emcdevdiv_g/view22n_11
    scp $login:$wcossdir/view22n_12.$dateflag.log $emcdevdiv_g/view22n_12
    scp $login:$wcossdir/view22n_13.$dateflag.log $emcdevdiv_g/view22n_13
    scp $login:$wcossdir/view22n_14.$dateflag.log $emcdevdiv_g/view22n_14
    scp $login:$wcossdir/view22n_15.$dateflag.log $emcdevdiv_g/view22n_15
    scp $login:$wcossdir/view22n_16.$dateflag.log $emcdevdiv_g/view22n_16
    scp $login:$wcossdir/view22n_17.$dateflag.log $emcdevdiv_g/view22n_17
    scp $login:$wcossdir/view22n_18.$dateflag.log $emcdevdiv_g/view22n_18
    scp $login:$wcossdir/view22n_19.$dateflag.log $emcdevdiv_g/view22n_19
    scp $login:$wcossdir/view22n_20.$dateflag.log $emcdevdiv_g/view22n_20
    scp $login:$wcossdir/view22n_21.$dateflag.log $emcdevdiv_g/view22n_21
    scp $login:$wcossdir/view22n_22.$dateflag.log $emcdevdiv_g/view22n_22
    scp $login:$wcossdir/view22n_23.$dateflag.log $emcdevdiv_g/view22n_23
    scp $login:$wcossdir/view22n_24.$dateflag.log $emcdevdiv_g/view22n_24
    scp $login:$wcossdir/view22n_25.$dateflag.log $emcdevdiv_g/view22n_25
    scp $login:$wcossdir/view22n_26.$dateflag.log $emcdevdiv_g/view22n_26
    scp $login:$wcossdir/view22n_27.$dateflag.log $emcdevdiv_g/view22n_27
    scp $login:$wcossdir/view22n_28.$dateflag.log $emcdevdiv_g/view22n_28
    scp $login:$wcossdir/view22n_29.$dateflag.log $emcdevdiv_g/view22n_29
    scp $login:$wcossdir/view22n_30.$dateflag.log $emcdevdiv_g/view22n_30
    scp $login:$wcossdir/view22n_31.$dateflag.log $emcdevdiv_g/view22n_31
    #scp $login:$wcossdir/view22y.$dateflag.log $emcdevdiv_g/view22y
    scp $login:$wcossdir/view22y_2.$dateflag.log $emcdevdiv_g/view22y_2
    scp $login:$wcossdir/view22y_3.$dateflag.log $emcdevdiv_g/view22y_3
    scp $login:$wcossdir/view22y_4.$dateflag.log $emcdevdiv_g/view22y_4
    scp $login:$wcossdir/view22y_5.$dateflag.log $emcdevdiv_g/view22y_5
    scp $login:$wcossdir/viewfail.$dateflag.log $emcdevdiv_g/viewfail
    echo "gyre processing complete"
  else
    echo "dates do not agree; abort"
  fi 
else
  echo "done file missing; abort"
fi

