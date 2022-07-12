<? $homelink="?log=home&ccs=$ccs"; ?>
<? $plotlink="stnplts.php"; ?>

 <div id="menuh-container">
  <div id="menuh">
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
   <? ### ascatt ### ?>
   <ul>
     <? if ($grp=="ascatt") {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent-active">ascatt</a>
     <? } else {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent">ascatt</a>
     <? } ?>
     <ul>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=ascatt&tnk=NC012122" class="sublist">ascat</a></li>
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
   <? ### wndsat ### ?>
   <ul>
     <? if ($grp=="wndsat") {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent-active">wndsat</a>
     <? } else {?>
     <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>" class="top_parent">wndsat</a>
     <? } ?>
     <ul>
       <li><a href="<?=$plotlink?>?net=<?=$net?>&ccs=<?=$ccs?>&grp=wndsat&tnk=NC012138" class="sublist">wdsat</a></li>
     </ul>
     </li>
   </ul>
  </div> <? # end div id="menuh" ?>
 </div>  <? # end div id="menuh-container" ?>
