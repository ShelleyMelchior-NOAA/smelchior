<?php # provide list of other date options ?>
<form name="archive" id="archive" enctype="application/x-www-form-urlencoded" method="post" action="?log=<?=$log?>&wcoss=<?=$wcossarr[0]?>">
<div id="p" class="l">
<select name="fsdtg" id="fsdtg">
<option value="select">Select different date:</option>
<?php
$filestatsdir="$wcossarr[1]/filestats";
$opendir=opendir("$filestatsdir");
while ($entryName=readdir($opendir))
 {$filearr[]=$entryName;}
closedir($opendir);
foreach ($filearr as $index => $fsfile)
 {
  if ($fsfile==".") {continue;}
  if ($fsfile=="..") {continue;}
  $fselem=explode(".",$fsfile);
  $fsdate[]=$fselem[1];
 }
rsort($fsdate);
foreach ($fsdate as $index => $fsdtg)
 {print("<option value=\"$fsdtg\">$fsdtg</option>\n");}
?>
</select>
<input type="submit" value=">>" />
</div>
</form>

<?php
  $dir=$log;
  $file="$wcossarr[1]/$dir/$log.$datefile.log";
  if (!file_exists($file))
   {
    print("<div id=\"p\">File does not exist.</div>");
    ?><div id="footer"><?
    require("footer.php");
    ?></div><?
    exit;
   }
  $filearr=array($file);
  # loop through files to display stat info and the file contents
  foreach ($filearr as $key => $file)
   {
    # parse file stat information
    $stat="$wcossarr[1]/filestats/filestats.$datefile.log";
    if (file_exists($stat))
     {
      $fh=fopen("$stat","r");
      while (!feof($fh))
       {
        $line=fgets($fh);
        if ($line=="") {continue;}
        # scan for $log string in line; if there, parse out information, else continue
        $arr=explode("/",$file);
        $substr=strpos($line,$arr[2]);
        if ($substr!=0)
         {
          $linearr=explode(" ", $line);
          foreach ($linearr as $key => $value)
           {
            if ($value=="" || $value==" " || is_null($value)) {unset($linearr[$key]);}
           }
          $linearr=array_values($linearr);
          $filesize=$linearr[0];
          $filedate="$linearr[3] UTC $linearr[1] $linearr[2]";
          print("<div id=\"p\" class=\"ul\">");
          print("File: <strong>$arr[2]</strong><br />");
          print("Date: $filedate<br />");
          print("Size: $filesize bytes<br />");
          print("</div>");
         }
       }
      fclose($fh);
     } # end if (file_exists($stat))
    if (file_exists($file))
     {
      if ($filesize!="0")
       {
        $fh=fopen("$file","r");
        while (!feof($fh))
         {
          $line=fgets($fh);
          if ($log=="view22n_13")
           {
            if (strpos($line, "non-fatal") || strpos($line, "ABNORMALLY")) {
              print("<div id=\"p\"><font class=\"courier\"><span class=\"highlighty\">$line</span></font></div>");
             } else {
              print("<div id=\"p\"><font class=\"courier\">$line</font></div>");
             }
           }
          else if ($log=="view22n_9")
           {
            if (strpos($line, "kill")) {
              print("<div id=\"p\"><font class=\"courier\"><span class=\"highlightr\">$line</span></font></div>");
             } else if (strpos($line, "***WARNING")) {
              print("<div id=\"p\"><font class=\"courier\"><span class=\"highlighty\">$line</span></font></div>");
             } else {
              print("<div id=\"p\"><font class=\"courier\">$line</font></div>");
             }
           }
          else if ($log=="view22n_8")
           {
            if (strpos($line, "yellow")) {
              print("<div id=\"p\"><font class=\"courier\"><span class=\"highlighty\">$line</span></font></div>");
             } else if (strpos($line, "green")) {
              print("<div id=\"p\"><font class=\"courier\"><span class=\"highlightg\">$line</span></font></div>");
             } else {
              print("<div id=\"p\"><font class=\"courier\">$line</font></div>");
             }
           }
          else 
           {
            print("<div id=\"p\"><font class=\"courier\">$line</font></div>");
           }
         }
        fclose($fh);
       }
      else if ($filesize=="0")
       {
        print("<div id=\"p\">File is empty ($filesize bytes).</div>");
       }
     } # end if (file_exists($stat))
    else
     {
      print("<div id=\"p\">File does not exist.</div>");
     } # end else of if (file_exists($stat))
   } # end foreach ($filearr as $key => $file)
?>
