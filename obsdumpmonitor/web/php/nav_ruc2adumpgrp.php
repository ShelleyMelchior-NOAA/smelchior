<? $homelink="?log=home&ccs=$ccs"; ?>
<? $plotlink="stnplts.php"; ?>

 <div id="menuh-container">
  <div id="menuh">
   <? ### 1bamua ### ?>
   <ul>
     <? if ($grp=="1bamua") { ?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=<?=$grp?>&tnk=NC021023" class="active">1bamua</a></li>
     <? } else { ?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?$ccs?>&grp=1bamua&tnk=NC021023" class="bold">1bamua</a></li>
     <? } ?>
   </ul>
   <? ### 1bamub ### ?>
   <ul>
     <? if ($grp=="1bamub") { ?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=<?=$grp?>tnk=NC021024" class="active">1bamub</a></li>
     <? } else { ?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?$ccs?>&grp=1bamub&tnk=NC021024" class="bold">1bamub</a></li>
     <? } ?>
   </ul>
   <? ### 1bhrs3 ### ?>
   <ul>
     <? if ($grp=="1bhrs3") { ?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=<?=$grp?>&tnk=NC021025" class="active">1bhrs3</a></li>
     <? } else { ?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?$ccs?>&grp=1bhrs3&tnk=NC021025" class="bold">1bhrs3</a></li>
     <? } ?>
   </ul>
   <? ### 1bhrs4 ### ?>
   <ul>
     <? if ($grp=="1bhrs4") { ?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=<?=$grp?>&tnk=NC021028" class="active">1bhrs4</a></li>
     <? } else { ?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?$ccs?>&grp=1bhrs4&tnk=NC021028" class="bold">1bhrs4</a></li>
     <? } ?>
   </ul>
   <? ### 1bmhs ### ?>
   <ul>
     <? if ($grp=="1bmhs") { ?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=<?=$grp?>&tnk=NC021027" class="active">1bmhs</a></li>
     <? } else { ?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?$ccs?>&grp=1bmhs&tnk=NC021027" class="bold">1bmhs</a></li>
     <? } ?>
   </ul>
   <? ### adpsfc ### ?>
   <ul>
     <? if ($grp=="adpsfc") {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent-active">adpsfc</a>
     <? } else {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent">adpsfc</a>
     <? } ?>
     <ul>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=adpsfc&tnk=NC000000" class="sublist">synopr</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=adpsfc&tnk=NC000001" class="sublist">synop</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=adpsfc&tnk=NC000002" class="sublist">synopm</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=adpsfc&tnk=NC000007" class="sublist">metar</a></li>
     </ul>
     </li>
   </ul>
   <? ### adpupa ### ?>
   <ul>
     <? if ($grp=="adpupa") {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent-active">adpupa</a>
     <? } else {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent">adpupa</a>
     <? } ?>
     <ul>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=adpupa&tnk=NC002001" class="sublist">raobf</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=adpupa&tnk=NC002002" class="sublist">raobm</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=adpupa&tnk=NC002003" class="sublist">raobs</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=adpupa&tnk=NC002004" class="sublist">dropw</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=adpupa&tnk=NC002005" class="sublist">pibal</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=adpupa&tnk=NC004005" class="sublist">recco</a></li>
     </ul>
     </li>
   </ul>
   <? ### aircar ### ?>
   <ul>
     <? if ($grp=="aircar") {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent-active">aircar</a>
     <? } else {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent">aircar</a>
     <? } ?>
     <ul>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=aircar&tnk=NC004004" class="sublist">acars</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=aircar&tnk=NC004007" class="sublist">acarsa</a></li>
     </ul>
     </li>
   </ul>
   <? ### aircft ### ?>
   <ul>
     <? if ($grp=="aircft") {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent-active">aircft</a>
     <? } else {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent">aircft</a>
     <? } ?>
     <ul>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=aircft&tnk=NC004001" class="sublist">airep</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=aircft&tnk=NC004002" class="sublist">pirep</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=aircft&tnk=NC004003" class="sublist">amdar</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=aircft&tnk=NC004006" class="sublist">eadas</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=aircft&tnk=NC004008" class="sublist">tamdar</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=aircft&tnk=NC004012" class="sublist">tmdarp</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=aircft&tnk=NC004013" class="sublist">tmdarc</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=aircft&tnk=NC004009" class="sublist">camdar</a></li>
     </ul>
     </li>
   </ul>
   <? ### airsev ### ?>
   <ul>
     <? if ($grp=="airsev") { ?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=<?=$grp?>&tnk=NC021249" class="active">airsev</a></li>
     <? } else { ?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?$ccs?>&grp=airsev&tnk=NC021249" class="bold">airsev</a></li>
     <? } ?>
   </ul>
   <? ### goesnd ### ?>
   <ul>
     <? if ($grp=="goesnd") {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent-active">goesnd</a>
     <? } else {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent">goesnd</a>
     <? } ?>
     <ul>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=goesnd&tnk=NC003002" class="sublist">goesth</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=goesnd&tnk=NC003003" class="sublist">goest1</a></li>
     </ul>
     </li>
   </ul>
   <? ### gpsipw ### ?>
   <ul>
     <? if ($grp=="gpsipw") {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent-active">gpsipw</a>
     <? } else {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent">gpsipw</a>
     <? } ?>
     <ul>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=gpsipw&tnk=NC012003" class="sublist">gpspw</a></li>
     </ul>
     </li>
   </ul>
   <? ### msonet ### ?>
   <ul>
     <? if ($grp=="msonet") {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent-active">msonet</a>
     <? } else {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent">msonet</a>
     <? } ?>
     <ul>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255001" class="sublist">msoden</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255002" class="sublist">msoraw</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255003" class="sublist">msowst</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255004" class="sublist">msoapr</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255005" class="sublist">msokan</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255006" class="sublist">msofla</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255007" class="sublist">msoiow</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255008" class="sublist">msomin</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255009" class="sublist">msoawx</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255010" class="sublist">msonos</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255011" class="sublist">msoapg</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255012" class="sublist">msowfy</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255014" class="sublist">msohad</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255015" class="sublist">msoaws</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255016" class="sublist">msoien</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255017" class="sublist">msokla</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255018" class="sublist">msocol</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255019" class="sublist">msowtx</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255020" class="sublist">msowis</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255021" class="sublist">msolju</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255022" class="sublist">mso470</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255023" class="sublist">msodcn</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255024" class="sublist">msoind</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255025" class="sublist">msoflt</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255026" class="sublist">msoalk</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255027" class="sublist">msogeo</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255028" class="sublist">msovir</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255029" class="sublist">msomca</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=msonet&tnk=NC255030" class="sublist">msothr</a></li>
     </ul>
     </li>
   </ul>
   <? ### proflr ### ?>
   <ul>
     <? if ($grp=="proflr") {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent-active">proflr</a>
     <? } else {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent">proflr</a>
     <? } ?>
     <ul>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=proflr&tnk=NC002007" class="sublist">prflr</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=proflr&tnk=NC002011" class="sublist">prflrb</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=proflr&tnk=NC002013" class="sublist">prflrj</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=proflr&tnk=NC002009" class="sublist">prflrp</a></li>
     </ul>
     </li>
   </ul>
   <? ### radwnd ### ?>
   <ul>
     <? if ($grp=="radwnd") {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent-active">radwnd</a>
     <? } else {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent">radwnd</a>
     <? } ?>
     <ul>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=radwnd&tnk=NC006001" class="sublist">radw30</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=radwnd&tnk=NC006002" class="sublist">radw25</a></li>
     </ul>
     </li>
   </ul>
   <? ### rassda ### ?>
   <ul>
     <? if ($grp=="rassda") {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent-active">rassda</a>
     <? } else {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent">rassda</a>
     <? } ?>
     <ul>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=rassda&tnk=NC002012" class="sublist">rass</a></li>
     </ul>
     </li>
   </ul>
   <? ### satwnd ### ?>
   <ul>
     <? if ($grp=="satwnd") {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent-active">satwnd</a>
     <? } else {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent">satwnd</a>
     <? } ?>
     <ul>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=satwnd&tnk=NC005010" class="sublist">infus</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=satwnd&tnk=NC005011" class="sublist">h2ius</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=satwnd&tnk=NC005012" class="sublist">visus</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=satwnd&tnk=NC005021" class="sublist">infin</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=satwnd&tnk=NC005022" class="sublist">visin</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=satwnd&tnk=NC005023" class="sublist">h20in</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=satwnd&tnk=NC005044" class="sublist">infja</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=satwnd&tnk=NC005045" class="sublist">visja</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=satwnd&tnk=NC005046" class="sublist">h20ja</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=satwnd&tnk=NC005064" class="sublist">infeu</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=satwnd&tnk=NC005065" class="sublist">viseu</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=satwnd&tnk=NC005070" class="sublist">infmo</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=satwnd&tnk=NC005071" class="sublist">h20mo</a></li>
     </ul>
     </li>
   </ul>
   <? ### sfcshp ### ?>
   <ul>
     <? if ($grp=="sfcshp") {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent-active">sfcshp</a>
     <? } else {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent">sfcshp</a>
     <? } ?>
     <ul>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=sfcshp&tnk=NC001001" class="sublist">ships</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=sfcshp&tnk=NC001002" class="sublist">dbuoy</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=sfcshp&tnk=NC001003" class="sublist">mbuoy</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=sfcshp&tnk=NC001004" class="sublist">lcman</a></li>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=sfcshp&tnk=NC001005" class="sublist">tideg</a></li>
     </ul>
     </li>
   </ul>
   <? ### vadwnd ### ?>
   <ul>
     <? if ($grp=="vadwnd") {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent-active">vadwnd</a>
     <? } else {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent">vadwnd</a>
     <? } ?>
     <ul>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=vadwnd&tnk=NC002008" class="sublist">nxrdw</a></li>
     </ul>
     </li>
   </ul>
  </div> <? # end div id="menuh" ?>
 </div>  <? # end div id="menuh-container" ?>
