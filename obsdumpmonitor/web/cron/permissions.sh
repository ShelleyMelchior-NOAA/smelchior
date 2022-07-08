# cron job started on: 03/23/12 on emcdev 
# cron job turned off:
# normal operating time: 0830 (server is on ET)

# ensure that all scripts have read-only permissions

basedir="/var/www/html/smelchior/obsdumpmonitor"
scriptsdir="$basedir/scripts"
crondir="$basedir/cron"

for script in `ls $scriptsdir` ; do
  chmod 644 $scriptsdir/$script
done
