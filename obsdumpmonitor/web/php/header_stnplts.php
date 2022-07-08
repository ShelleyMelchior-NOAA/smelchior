<div id="col-container">
<div id="title">
<h1><a href="stnplts.php?net=<?=$net?>&ccs=<?=$ccs?>">Dump Station Plots</a></h1>
</div>

<?php
print("<div id=\"devprod\">");
print("<strong>");
if ($net=="nam")
 {
  print("<a class=\"active\" href=\"$plotlink?net=$net&ccs=$ccs\">NAM</a>");
  print(" | ");
  print("<a href=\"$plotlink?net=ndas&ccs=$css\">NDAS</a>");
  print(" | ");
  print("<a href=\"$plotlink?net=rtma&ccs=$css\">RTMA</a>");
  print(" | ");
  print("<a href=\"$plotlink?net=ruc2a&ccs=$css\">RUC</a>");
 }
else if ($net=="ndas")
 {
  print("<a href=\"$plotlink?net=nam&ccs=$css\">NAM</a>");
  print(" | ");
  print("<a class=\"active\" href=\"$plotlink?net=$net&ccs=$ccs\">NDAS</a>");
  print(" | ");
  print("<a href=\"$plotlink?net=rtma&ccs=$css\">RTMA</a>");
  print(" | ");
  print("<a href=\"$plotlink?net=ruc2a&ccs=$css\">RUC</a>");
 }
else if ($net=="rtma")
 {
  print("<a href=\"$plotlink?net=nam&ccs=$css\">NAM</a>");
  print(" | ");
  print("<a href=\"$plotlink?net=ndas&ccs=$css\">NDAS</a>");
  print(" | ");
  print("<a class=\"active\" href=\"$plotlink?net=$net&ccs=$ccs\">RTMA</a>");
  print(" | ");
  print("<a href=\"$plotlink?net=ruc2a&ccs=$css\">RUC</a>");
 }
else if ($net=="ruc2a")
 {
  print("<a href=\"$plotlink?net=nam&ccs=$css\">NAM</a>");
  print(" | ");
  print("<a href=\"$plotlink?net=ndas&ccs=$css\">NDAS</a>");
  print(" | ");
  print("<a href=\"$plotlink?net=rtma&ccs=$css\">RTMA</a>");
  print(" | ");
  print("<a class=\"active\" href=\"$plotlink?net=$net&ccs=$ccs\">RUC</a>");
 }
print("</strong>");
print("</div>");
?> 

</div>
