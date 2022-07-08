<div id="col-container">
<div id="title">
<h1><a href="">Obs Dump Monitor</a></h1>
</div>

<?php
print("<div id=\"devprod\">");
print("<strong>");
if ($wcoss=="prod")
 {
  print("<a class=\"active\" href=\"?wcoss=$wcossarr[0]\">$wcossarr[0] [$wcossarr[1]]</a>");
  print(" / ");
  print("<a href=\"?wcoss=$offarr[0]\">$offarr[0] [$offarr[1]]</a>");
 }
else if ($wcoss="dev")
 {
  print("<a href=\"?wcoss=$offarr[0]\">$offarr[0] [$offarr[1]]</a>");
  print(" / ");
  print("<a class=\"active\" href=\"?wcoss=$wcossarr[0]\">$wcossarr[0] [$wcossarr[1]]</a>");
 }
print("</strong>");
print("</div>");
?> 

</div>
