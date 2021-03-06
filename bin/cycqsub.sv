lsf_file=${1:?}
jtyp=${jtyp:gdas}

shift
qsub_opts=$@

# if file to be submitted contains string(s) %HHMM%, modify to stamp with 
# current hour and minute
[ -n "$desc" ] && _desc="_$desc"
[ -n "$PDY" ] && _PDY="_$PDY"
if [ -n "$bsub_opts" ]; then
 qsub_command="qsub $qsub_opts"
else
 qsub_command=qsub
fi

#sed "s/%HHMM%/`date -u +\%H\%M`/;s/%CC%/$cyc/;s/%YYYYMMDD%/`date -u +\%Y\%m\%d`/;s/%DESC%/$desc/" $1 | qsub
#sed "s/%HHMM%/`date -u +\%H\%M`/;s/%CC%/$cyc/;s/%YYYYMMDD%/`date -u +\%Y\%m\%d`/;s/%PDY%/$PDY/;s/%_PDY%/$_PDY/;s/%DESC%/$desc/;s/%_DESC%/$_desc/" $1 | qsub

#sed "s/%HHMM%/`date -u +\%H\%M`/;s/%CC%/$cyc/;s/%JTYP%/$jtyp/;s/%YYYYMMDD%/`date -u +\%Y\%m\%d`/;s/%PDY%/$PDY/;s/%_PDY%/$_PDY/;s/%DESC%/$desc/;s/%_DESC%/$_desc/" $lsf_file | $qsub_command
#sed "s/%HHMM%/`date -u +\%H\%M`/;s/%CC%/$cyc/;s/%JTYP%/$jtyp/;s/%YYYYMMDD%/`date -u +\%Y\%m\%d`/;s/%PDY%/$PDY/;s/%_PDY%/$_PDY/;s/%TMMARK%/$tmmark/;s/%DESC%/$desc/;s/%_DESC%/$_desc/" $lsf_file | $qsub_command
sed "s/%HHMM%/`date -u +\%H\%M`/;s/%CC%/$cyc/;s/%CCM%/$cycM/;s/%JTYP%/$jtyp/;s/%YYYYMMDD%/`date -u +\%Y\%m\%d`/;s/%PDY%/$PDY/;s/%_PDY%/$_PDY/;s/%TMMARK%/$tmmark/;s/%DESC%/$desc/;s/%_DESC%/$_desc/" $lsf_file | $qsub_command
