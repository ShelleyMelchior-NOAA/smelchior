# Counter to keep track of the passage of 20 days.
# Upon login, .bashrc will touch /u/shelley.melchior/login.
# This script ($0) will look at mtime for login file and count days elapsed
# between current time and mtime. If that difference eclipses 20 days, an
# email will be sent to me reminding me to log into WCOSS2 - cactus.

workdir=/u/shelley.melchior
loginfile=$workdir/login
server=$(hostname)
addy=shelley.melchior@noaa.gov

# get mtime from last touch of $loginfile (seconds since 1970)
mtime=$(date -r $loginfile +%s)
mtimefull=$(date -r $loginfile)
#mtime=$(date -d "May 12 2024" +%s) # force bogus date for testing

# get current time (seconds since 1970)
now=$(date +%s)
nowfull=$(date)

# calculate date difference
diff=$(expr $now - $mtime)
diff=$(expr $diff / 86400) #convert from seconds since 1970 to days
echo "Today is $nowfull."
echo "You logged in $diff days ago on:"
echo "$(date -d "$diff days ago")"

# compose and send email if $diff >= 20 days
#if [ $diff -ge 20 ]
#then
  sbj="ALERT: log into $server (cactus)"
  body="Today is $nowfull. You logged in $diff days ago (>20), which was $(date -d "$diff days ago"). Time to log into $server (cactus) to reset the counter!"
  echo $body | mail -s "$sbj" $addy
  echo "email sent: login reminder"
#fi
