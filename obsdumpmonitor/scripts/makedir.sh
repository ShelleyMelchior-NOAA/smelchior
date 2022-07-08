# Make sure outdir exists prior to running any crontab jobs.

dir="/ptmpp1/$USER/obs_dump/log"
[ ! -d "$dir" ] && mkdir -p "$dir"

