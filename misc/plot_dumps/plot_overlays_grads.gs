* Draws tank (or dump) contents

function main(args)

tacctlfil=subwrd(args,1)
bufrctlfil=subwrd(args,2)
tactank=subwrd(args,3)
bufrtank=subwrd(args,4)
pdy=subwrd(args,5)

bufrtankname=''
tactankname=''
if(tactank='NC000000') ; tactankname='SYNOPR' ; endif
if(tactank='NC000001') ; tactankname='SYNOP' ; endif
if(tactank='NC000002') ; tactankname='SYNOPM' ; endif
if(tactank='NC001002') ; tactankname='DBUOY' ; endif
if(tactank='NC001003') ; tactankname='MBUOY' ; endif
if(tactank='NC004001') ; tactankname='AIREP' ; endif
if(tactank='NC004003') ; tactankname='AMDAR' ; endif
* Eventhough EAMDAR is technically a bufr tank, for ease of scripting, adopting 'tactank*' variable name.
if(bufrtank='NC000100') ; bufrtankname='SYNPBR' ; endif
if(bufrtank='NC000101') ; bufrtankname='SYNOPB' ; endif
if(bufrtank='NC000102') ; bufrtankname='SYNPMB' ; endif
if(bufrtank='NC001102') ; bufrtankname='DBUOYB' ; endif
if(bufrtank='NC001103') ; bufrtankname='MBUOYB' ; endif
if(tactank='NC004006') ; tactankname='E-AMDAR' ; endif
if(bufrtank='NC004103') ; bufrtankname='AMDAR' ; endif

'open 'tacctlfil''
'open 'bufrctlfil''
'q files'
say result
'set dfile 2'
'set background 1'
'set ccolor 6'
'set gxout stnmark'

* Display stations
'd u;v'

'set dfile 1'
'set ccolor 3'

'd u;v'

* Draw titles
'set string 6 l 5 0'
'set strsiz 0.15 0.15'
'draw string 0.5 8.25 'bufrtank' ('bufrtankname') for 'pdy' - BUFR'
'set string 3 l 5 0'
'draw string 0.5 7.75 'tactank' ('tactankname') for 'pdy' - TAC'

* Make hard copy png
'printim /ptmpp1/Shelley.Melchior/plot_dumps/'bufrtank'.'tactank'.'pdy'.OVERLAY.png png x800 x600 white'

'c'
'close 2'
'close 1'
'quit'

