<?php
$img="<img src=\"icon/rightarrow.jpg\" alt=\">>\" />";
$link="<a href=\"?log=$log&wcoss=$wcoss\">";\
$homelink="<a href=\"?log=home&wcoss=$wcoss";
print("<div id=\"bc\">");
# HOME
if ($log=="home" || $log=="")
 {print("$homelink\">HOME</a>");}
# NAM
$name=array("view22n_2"=>"Report Counts",
            "view22n_3"=>"Dump Start Times");
if ($log=="view22n_2" || $log=="view22n_3")
 {print("$homelink#nam\">NAM</a> $img ${link}$name[$log]</a>");} 
# RAP
$name=array ("view22y_2"=>"Missing Wind Profilers",
             "view22y_3"=>"All Other Missing Data",
             "view22y_4"=>"GETBUFR Data");
if ($log=="view22y_2" || $log=="view22y_3" || $log=="view22y_4")
 {print("$homelink#rap\">RAP</a> $img ${link}$name[$log]</a>");}
# RTMA, URMA
$name="All Messages";
if ($log=="view22y_5")
 {print("$homelink#srucrtma\">RTMA, URMA</a> $img ${link}$name</a>");}
# Non-fatal Abnormal RCs
$name=array("view22n_5"=>"Satellite Ingest",
            "view22n_6"=>"Level II Ingest");
if ($log=="view22n_5" || $log=="view22n_6")
 {print("$homelink#nonfatal\">Non-fatal Abnormal RCs</a> $img ${link}$name[$log]</a>");}
# RC=22
$name="All networks except RAP, RTMA, URMA";
if ($log=="view22n_7")
 {print("$homelink#rc22\">RC=22</a> $img ${link}$name[$log]</a>");}
# *.out
$name=array("view22n_21"=>"No. of Lines in tranjb*.out Files",
            "view22n_22"=>"Rejected/Bad Date Tosses",
            "view22n_23"=>"Rejected Due to Meaningless Date Tosses");
if ($log=="view22n_21" || $log=="view22n_22" || $log=="view22n_23")
 {print("$homelink#out\">*.out</a> $img ${link}$name[$log]</a>");}
# DUMP Output
$name=array("view22n_26"=>"Quips Problems",
            "view22n_29"=>"BUFRLIB Warnings & Syntax Errors");
if ($log=="view22n_26" || $log=="view22n_29")
 {print("$homelink#dumpoutput\">DUMP Output</a> $img ${link}$name[$log]</a>");}
# Ingest Output
$name=array("view22n_19"=>"Age of Ingest Output Files",
            "view22n_28"=>"Lapsed Data Hourwait Calculation Problem",
            "view22n_27"=>"BUFRLIB Warnings, Syntax Errors, Segmentation Faults, Connection Problems");
if ($log=="view22n_19" || $log=="view22n_28" || $log=="view22n_27")
 {print("$homelink#ingestoutput\">Ingest Output</a> $img ${link}$name[$log]</a>");}
# SPA Log
if ($log=="viewspalog")
 {print("$homelink#spalog\">SPA Log</a>");}
# RC=11 
if ($log=="view11")
 {print("$homelink#rc11\">RC=11</a>");}
# FAILURES 
$name=array("viewfail"=>"FAILURES",
            "view99"=>"RC=99");
if ($log=="viewfail" || $log=="view99")
 {print("$homelink#failures\">FAILURES</a> $img ${link}$name[$log]</a>");}
# Datacount
$name=array("view22n_4"=>"Avg Tables & Status Files Available for Datacount Avgs",
            "view22n_8"=>"Alerts");
if ($log=="view22n_4" || $log=="view22n_8")
 {print("$homelink#datacount\">Datacount</a> $img ${link}$name[$log]</a>");}
# File Ages
$name=array("view22n_15"=>"Error Files in /dcom",
            "view22n_17"=>"\"Repeat\" Files in /dcom/ingest_hist");
if ($log=="view22n_15" || $log=="view22n_17")
 {print("$homelink#fileages\">File Ages</a> $img ${link}$name[$log]</a>");}
# Tropcyc Bulletins 
$name=array("view22n_24"=>"wtxtbul/tropcyc",
            "view22n_25"=>"wbfrbul/tropcyc");
if ($log=="view22n_24" || $log=="view22n_25")
 {print("$homelink#tropcyc\">Tropcyc Bulletins</a> $img ${link}$name[$log]</a>");}
# Miscellaneous
$name=array("view22n_9"=>"All Other Messages For All Netowrks Except RAP, RTMA, URMA",
            "view22n_10"=>"Tropical Bogus Summary",
            "view22n_11"=>"NDAS Did Not Run Listing",
            "view22n_12"=>"Dump Script Tank Suddenly Off-Line Listing",
            "view22n_13"=>"LL* Jobs Listing",
            "view22n_14"=>"Tank Diff-ing",
            "view22n_16"=>"ACF Entries in SDMedit",
            "view22n_18"=>"SDMedit and Quips Files in /dcom",
            "view22n_20"=>"No. of AIRNOW Reports Dumped in Past Few Days",
            "view22n_30"=>"BUFRLIB Warnings, Segmentation Faults, & Abnormal Termination Errors in Prep Output",
            "view22n_31"=>"Too Many Levels in ADPUPA Listing",
            "view22y_6"=>"Unexpected end of file in satingest stdout");
if ($log=="view22n_9" || $log=="view22n_10" || $log=="view22n_11" || $log=="view22n_12" || $log=="view22n_13" || $log=="view22n_14" || $log=="view22n_16" || $log=="view22n_18" || $log=="view22n_20" || $log=="view22n_31" || $log=="view22n_30" || $log=="view22y_6")
{print("$homelink#misc\">Miscellaneous</a> $img ${link}$name[$log]</a>");}
print("</div>");
?>
