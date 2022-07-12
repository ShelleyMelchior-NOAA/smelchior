<?php
# determine which machine is prod and which macines is dev
# read serverstats log

$serverstatslog="gyre/serverstats/serverstats.$datefile.log";
if (!file_exists($serverstatslog))
 {$serverstatslog="tide/serverstats/serverstats.$datefile.log";}
if (file_exists($serverstatslog))
 {
  $c=1;
  $fh=fopen("$serverstatslog","r");
  while (!feof($fh))
   {
    $line=fgets($fh);
    if ($c==2)
     {
      $dev=explode(":",$line);
      $dev[0]=trim($dev[0]);
      $dev[1]=trim($dev[1]);
      # $dev[0]="dev"
      # $dev[1]=machine name (gyre or tide)
     }
    if ($c==3)
     {
      $prod=explode(":",$line);
      $prod[0]=trim($prod[0]);
      $prod[1]=trim($prod[1]);
      # $prod[0]="prod"
      # $prod[1]=machine name (gyre or tide)
     }
    $c++;
   }
 }
else
 { 
  # no current serverstats log
 }

if ($wcoss=="prod")
 {
  $wcossarr=array("$prod[0]","$prod[1]");
  $offarr=array("$dev[0]","$dev[1]");
 } 
else if ($wcoss=="dev")
 {
  $wcossarr=array("$dev[0]","$dev[1]");
  $offarr=array("$prod[0]","$prod[1]");
 }
?>
