apxdx:
	sh -c  "module purge > /dev/null 2>&1; \
		module load EnvVars/1.0.2  \
			    ips/18.0.1.163 \
			    bufr/11.2.0; \
		ifort -O2 -g -traceback -o apxdx apxdx.f  /gpfs/dell2/emc/obsproc/noscrub/Jeff.Ator/NCEPLIBS-bufr/libbufr_v11.3.0_4_64.a"
#		ifort -O2 -g -traceback -o apxdx apxdx.f ${BUFR_LIB4}"

install:
	mv apxdx ../../exec

clean:
	rm -f apxdx
