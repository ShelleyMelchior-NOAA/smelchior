# cron job started on: 04/23/13 on emcdev 
# cron job turned off:
# normal operating time: 0830 (server is on ET)

basedir="/var/www/html/smelchior/obsdumpmonitor"
gyredir="$basedir/gyre"
tidedir="$basedir/tide"
crondir="$basedir/cron"
gradsdir="$basedir/plots/grads"

# cycle through all log file directories to see how old the files are
# files older than 14 days are deleted (-mtime +12)

echo ---GYRE---
for script in `ls $gyredir` ; do
  echo -----$script-----
  find $gyredir/$script -mtime +12 -type f -exec ls -ltr {} \;
  find $gyredir/$script -mtime +12 -type f -exec rm -rf {} \;
done
echo
echo ---TIDE---
for script in `ls $tidedir` ; do
  echo -----$script-----
  find $tidedir/$script -mtime +12 -type f -exec ls -ltr {} \;
  find $tidedir/$script -mtime +12 -type f -exec rm -rf {} \;
done
echo
echo ---PLOTS---
for bdir in $gradsdir/b* ; do
  echo ----$bdir----
  find $bdir -mtime +12 -type f -exec ls -ltr {} \;
  find $bdir -mtime +12 -type f -exec rm -rf {} \;
done
