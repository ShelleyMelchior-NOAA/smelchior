<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
           "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
<title>NOAA - NCEP - EMC Obs Tank Counts</title>
<style type="text/css" media="all" title="stylesheet">@import url(css/container.css);</style>
<style type="text/css" media="all" title="stylesheet">@import url(css/master.css);</style>
<link rel="icon" type="image/ico" href="icon/favicon.ico" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta name="description" content="NOAA - NCEP - EMC Data Processing">
</head>
<body>

<?php
# Get tanks

$b=shell_exec("ls -d b*");
$barr=explode("b",$b);
unset($barr[0]);
foreach ($barr as $tank)
{
  print("<a href=\"top.php?b=${tank}\">b${tank}</a><br />");
}

# List files for selected tank
# Retrieve valid dates
$bxxx=$_GET['b'];
print("<hr><strong>b${bxxx}</strong><br />");
$list=shell_exec("ls b${bxxx}");
$listarr=explode(".",$list);
foreach ($listarr as $file)
{
  if (!preg_match('/^[0-9]+$/',${file}))
  {
    $key=array_search($file,$listarr);
    unset($listarr[$key]);
  }
}
$listarr=array_unique($listarr);
rsort($listarr);
foreach ($listarr as $dtg)
{
  print("$dtg<br />");
}
?>
</body>
</html>
