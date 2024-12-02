# Counter to keep track of the passage of 30 days.
# Upon login, .bashrc will touch /u/shelley.melchior/login.
# This script ($0) will look at mtime for login file and count days elapsed
# between current time and mtime. If that difference eclipses 30 days, an
# email will be sent to me reminding me to log into WCOSS2 - cactus.

workdir=/u/shelley.melchior
loginfile=$workdir/login
server=$(hostname)
addy=shelley.melchior@noaa.gov

# get mtime from last touch of $loginfile (seconds since 1970)
mtime=$(date -r $loginfile +%s)
#mtime=$(date -d "May 12" +%s) # force bogus date for testing

# get current time (seconds since 1970)
now=$(date +%s)

# calculate date difference
diff=$(expr $now - $mtime)
diff=$(expr $diff / 86400) #convert from seconds since 1970 to days
echo "You logged in $diff days ago."

# compose and send email if $diff >= 30 days
if [ $diff -ge 30 ]
then
  sbj="ALERT: log into $server (cactus)"
  body="You logged in $diff days ago (>30). Time to log into $server (cactus) to reset the counter!"
  echo $body | mail -s "$sbj" $addy
  echo "email sent: login reminder"
fi
