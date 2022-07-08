* Draws tank (or dump) contents

function main(args)

ctlfil=subwrd(args,1)
tank=subwrd(args,2)
pdy=subwrd(args,3)
ctlfilxtr=subwrd(args,4)
outdir='/ptmpp1/Shelley.Melchior/plot_dumps'

tankname=''
if(tank='NC000000') ; tankname='SYNOPR' ; endif
if(tank='NC000001') ; tankname='SYNOP' ; endif
if(tank='NC000002') ; tankname='SYNOPM' ; endif
if(tank='NC000100') ; tankname='SYNPBR' ; endif
if(tank='NC000101') ; tankname='SYNOPB' ; endif
if(tank='NC000102') ; tankname='SYNPMB' ; endif
if(tank='NC001002') ; tankname='DBUOY' ; endif
if(tank='NC001003') ; tankname='MBUOY' ; endif
if(tank='NC001102') ; tankname='DBUOYB' ; endif
if(tank='NC001103') ; tankname='MBUOYB' ; endif
if(tank='NC004001') ; tankname='AIREP' ; endif
if(tank='NC004002') ; tankname='PIREP' ; endif
if(tank='NC004006') ; tankname='EAMDAR' ; endif
if(tank='NC004003' | tank='NC004103') ; tankname='AMDAR' ; endif
if(tank='NC004004') ; tankname='MDCRS' ; endif
if(tank='NC004010') ; tankname='TAMDAR' ; endif
if(tank='NC007001') ; tankname='LTNGSR' ; endif
if(tank='NC007002') ; tankname='LTNGLR' ; endif
if(tank='NC021037') ; tankname='ESCRIS' ; endif
if(tank='NC021038') ; tankname='ESATMS' ; endif
if(tank='NC021039') ; tankname='ESIASI' ; endif
if(tank='NC021212') ; tankname='CRISDB' ; endif
if(tank='NC021213') ; tankname='ATMSDB' ; endif
if(tank='NC021239') ; tankname='IASIDB' ; endif
if(tank='NC021241') ; tankname='MTIASI' ; endif
if(tank='NC021033') ; tankname='ESAMUA' ; endif
if(tank='NC021035') ; tankname='ESHRS3' ; endif
if(tank='NC021036') ; tankname='ESMHS' ; endif
if(tank='NC021206') ; tankname='CRISF4' ; endif

'open 'ctlfil''
'set background 1'
'set ccolor 6'
'set gxout stnmark'

* Display stations
'd u;v'

* Open extra ctl file for certain radiance tanks: 021038, 021039, 021213, 
* 021241, 021036
if(tank='NC021038' | tank='NC021039' | tank='NC021213' | tank='NC021241' | tank='NC021036')
  'open 'ctlfilxtr''
  'set dfile 2'
  'set ccolor 6'
  'd u;v'
  'close file 2'
endif

* Draw titles
'set string 6 l 5 0'
'set strsiz 0.15 0.15'
'draw string 0.5 8.25 'tank' ('tankname') for 'pdy''

* Make hard copy png
'printim 'outdir'/'tank'.'pdy'.png png x800 x600 white'

* zoom in on Europe for some synop tanks
* NC000000 or NC000100
if (tank = 'NC000000' | tank = 'NC000100')
  'set background 0'
  'c'
  'set ccolor 6'
  'set gxout stnmark'
  'set lat 25 75'
  'set lon -40 45'
* Display stations
  'd u;v'
* Draw titles
  'set string 6 l 5 0'
  'set strsiz 0.15 0.15'
  'draw string 0.5 8.25 'tank' for 'pdy' - EUROPE'
* Make hard copy png
  'printim 'outdir'/'tank'.'pdy'.EUROPE.png png x800 x600 white'
endif

* plot Europe overlay for NC000*00 synop tanks
if (tank = 'NC000100')
  say 'hereherehere'
  'open 'outdir'/NC000000.'pdy'.ctl'
  'set dfile 1'
  'set background 0'
  'c'
  'set ccolor 6'
  'set gxout stnmark'
  'set lat 25 75'
  'set lon -40 45'
* display BUFR stations
  'd u;v'
  'set dfile 2'
  'set ccolor 3'
* display TAC stations
  'd u;v'
* draw titles
  'set string 6 l 5 0'
  'set strsiz 0.15 0.15'
  'draw string 0.5 8.25 'tank' for 'pdy' - BUFR'
  'set string 3 l 5 0'
  'draw string 0.5 8.00 NC000000 for 'pdy' - TAC'
* Make hard copy png
  'printim 'outdir'/'tank'.NC000000.'pdy'.EUROPE.OVERLAY.png png x800 x600 white'
  'close 2'
endif

* plot South Pacific overlay for NC004*0* aircft tanks
if (tank = 'NC004103')
  'open 'outdir'/NC004001.'pdy'.ctl'
  'set dfile 1'
  'set background 0'
  'c'
  'set ccolor 6'
  'set gxout stnmark'
  'set lat -60 5'
  'set lon 140 240'
* display BUFR stations
  'd u;v'
  'set dfile 2'
  'set ccolor 3'
* display TAC stations
  'd u;v'
* draw titles
  'set string 6 l 5 0'
  'set strsiz 0.15 0.15'
  'draw string 0.5 8.25 'tank' ('tankname') for 'pdy' - BUFR'
  'set string 3 l 5 0'
  'draw string 0.5 8.00 NC004001 (AIREP) for 'pdy' - TAC'
* Make hard copy png
  'printim 'outdir'/'tank'.NC004001.'pdy'.SPac.OVERLAY.png png x800 x600 white'
  'close 2'
endif

* Zoom in on Alaska region for tamdar tank (NC004010)
if (tank = 'NC004010')
  'set background 0'
  'c'
  'set ccolor 6'
  'set gxout stnmark'
  'set lat 50 74'
  'set lon -175 -140'
* Display stations
  'd u;v'
* Draw titles
  'set string 6 l 5 0'
  'set strsiz 0.15 0.15'
  'draw string 0.5 8.25 'tank' ('tankname') for 'pdy' - ALASKA'
* Make hard copy png
  'printim 'outdir'/'tank'.'pdy'.ALASKA.png png x800 x600 white'
endif

* Zoom in on Eastern USA for tamdar tank (NC004010)
if (tank = 'NC004010')
  'set background 0'
  'c'
  'set ccolor 6'
  'set gxout stnmark'
  'set lat 20 50'
  'set lon -90 -70'
* Display stations
  'd u;v'
* Draw titles
  'set string 6 l 5 0'
  'set strsiz 0.15 0.15'
  'draw string 0.5 8.25 'tank' ('tankname') for 'pdy' - Eastern USA'
* Make hard copy png
  'printim 'outdir'/'tank'.'pdy'.EUSA.png png x800 x600 white'
endif

* Zoom in on Mexico for tamdar tank (NC004010)
if (tank = 'NC004010')
  'set background 0'
  'c'
  'set ccolor 6'
  'set gxout stnmark'
  'set lat 15 35'
  'set lon -120 -90'
* Display stations
  'd u;v'
* Draw titles
  'set string 6 l 5 0'
  'set strsiz 0.15 0.15'
  'draw string 0.5 8.25 'tank' ('tankname') for 'pdy' - Mexico'
* Make hard copy png
  'printim 'outdir'/'tank'.'pdy'.MEXICO.png png x800 x600 white'
endif

* Zoom in on Western USA for tamdar tank (NC004010)
if (tank = 'NC004010')
  'set background 0'
  'c'
  'set ccolor 6'
  'set gxout stnmark'
  'set lat 30 50'
  'set lon -135 -100'
* Display stations
  'd u;v'
* Draw titles
  'set string 6 l 5 0'
  'set strsiz 0.15 0.15'
  'draw string 0.5 8.25 'tank' ('tankname') for 'pdy' - Western USA'
* Make hard copy png
  'printim 'outdir'/'tank'.'pdy'.WUSA.png png x800 x600 white'
endif

'c'
'close 1'
'quit'

