<?php
# set date from filestats log (latest run)
$datenow=date("Ymd");

$serverarr=array("gyre","tide");
foreach ($serverarr as $key => $server)
 {
  $filestatsdir=opendir("$server/filestats");
  while ($entryName = readdir($filestatsdir))
   {
    if ($entryName==".") {continue;}
    if ($endtryName=="..") {continue;}
    $dirarr[]=$entryName;
   }
  rsort($dirarr);
  $latest=explode(".",$dirarr[0]);
  $datefile=$latest[1];
  $datefilearr[]=$datefile;
 }
# $datefilearr[0] = latest date for gyre 
# $datefilearr[1] = latest date for tide
if ($datefilearr[0]==$datefilearr[1]) {$datefile=$datefilearr[0];}
if ($datefilearr[0]>$datefilearr[1]) {$datefile=$datefilearr[0];}
if ($datefilearr[0]<$datefilearr[1]) {$datefile=$datefilearr[1];}

# if archive dtg is selected from pulldown menu, set $datefile to $archivedtg
if (isset($_POST['fsdtg']))
 {
  $pattern="^[0-9]{8}$";
  if (ereg($pattern, $_POST['fsdtg']))
   {
    $archivedtg=$_POST['fsdtg'];
    $datefile=$archivedtg;
    #if ($archivedtg!="select")
    # {$datefile=$archivedtg;}
   }
 }

?>
