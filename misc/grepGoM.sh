# NOTE: Run this utility in tmp space because $uefile can be large!
# grep for the Gulf of Mexico oil rig platform METAR stations
# $uefile generated w/ Jeff Whiting's "ue" utility:
# ue /dcomdev/us007003/20150225/b000/xx007 "RPID | HOUR" quiet

cd /ptmpp1/$USER

which ue

ue /dcomdev/us007003/20150226/b000/xx007 "RPID | HOUR" quiet

uefile=/ptmpp1/$USER/ufbtab_example.out
stnfile=/meso/save/$USER/svnwkspc/melchior/misc/GoM.stns

#grep -e KVAF -e KGUL -e KIPN -e KEIR -e KGVX -e KVBS -e KATP -e KIKT -e KCRH -e KVOA -e KGBK -e KMZG -e KDLP -e KVQT -e KXPY -e KHHV -e KBBF -e KEMK -e KEHC -e KXIH -e KHQI -e KMIS -e KVKY -e KMDJ -e KSPR -e KSQE -e KSCF -e KGRY -e KOPM -e KGHB -e KBQX $uefile
# OR
#egrep 'KVAF | KGUL | KIPN | KEIR | KGVX | KVBS | KATP | KIKT | KCRH | KVOA | KGBK | KMZG | KDLP | KVQT | KXPY | KHHV | KBBF | KEMK | KEHC | KXIH | KHQI | KMIS | KVKY | KMDJ | KSPR | KSQE | KSCF | KGRY | KOPM | KGHB | KBQX' $uefile
# OR
#grep -f $stnfile $uefile
# OR
cat <<EOL > GoM.stns
KVAF
KGUL
KIPN
KEIR
KGVX
KVBS
KATP
KIKT
KCRH
KVOA
KGBK
KMZG
KDLP
KVQT
KXPY
KHHV
KBBF
KEMK
KEHC
KXIH
KHQI
KMIS
KVKY
KMDJ
KSPR
KSQE
KSCF
KGRY
KOPM
KGHB
KBQX
EOL
grep -f GoM.stns $uefile
