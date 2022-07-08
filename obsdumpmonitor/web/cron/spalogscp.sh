# cron job started on: 04/23/13 on emcdev 
# cron job turned off: 05/14/14 on emcdev -- scp now initiated on wcoss
# normal operating time: hourly:00 

# get current date
dateflag=$(date +%Y%m%d)

# scp files from wcoss (gyre and tide) to emcdev
# viewspalog, filestats, serverstats

wcossdir="/ptmpp1/Shelley.Melchior/obs_dump/log"
emcdevdir="/var/www/html/smelchior/obsdumpmonitor"

# tide
echo "begin tide processing"
srvr="tide"
login="Shelley.Melchior@tide.ncep.noaa.gov"
emcdevdir_t="$emcdevdir/$srvr"

# Test if spalogparse processing is complete
scp $login:$wcossdir/viewspalog.* $emcdevdir_t
if [ $? = 0 ]
then
  # spalogparse processing complete; test for most current date
  datetest=$(ls $emcdevdir_t/viewspalog.????????.log | cut -d'.' -f2)
  rm $emcdevdir_t/viewspalog.????????.log
  if [ $dateflag = $datetest ]
  then
    echo "dates agree; proceed"
    scp $login:$wcossdir/viewspalog.$dateflag.log $emcdevdir_t/viewspalog
    scp $login:$wcossdir/filestats.$dateflag.log $emcdevdir_t/filestats
    scp $login:$wcossdir/serverstats.$dateflag.log $emcdevdir_t/serverstats
    echo "tide processing complete"
  else
    echo "dates do not agree; abort"
  fi
else
  echo "spalogparse file missing; abort"
fi

# gyre 
echo "begin gyre processing"
srvr="gyre"
login="Shelley.Melchior@gyre.ncep.noaa.gov"
emcdevdir_g="$emcdevdir/$srvr"

# Test if spalogparse processing is complete
scp $login:$wcossdir/viewspalog.* $emcdevdir_g
if [ $? = 0 ]
then
  # spalogparse processing complete; test for most current date
  datetest=$(ls $emcdevdir_g/viewspalog.????????.log | cut -d'.' -f2)
  arr=($datetest)
  len=${#arr[@]}
  datetest=${arr[$len-1]}
  rm $emcdevdir_g/viewspalog.????????.log
  if [ $dateflag = $datetest ]
  then
    echo "dates agree; proceed"
    scp $login:$wcossdir/viewspalog.$dateflag.log $emcdevdir_g/viewspalog
    scp $login:$wcossdir/filestats.$dateflag.log $emcdevdir_g/filestats
    scp $login:$wcossdir/serverstats.$dateflag.log $emcdevdir_g/serverstats
    echo "gyre processing complete"
  else
    echo "dates do not agree; abort"
  fi
else
  echo "spalogparse file missing; abort"
fi

