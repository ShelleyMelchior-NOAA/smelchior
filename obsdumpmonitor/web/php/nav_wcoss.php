<? $homelink="?log=home&wcoss=$wcoss"; ?>
 <div id="menuh-container">
  <div id="menuh">
   <? ### Home ### ?>
   <ul>
     <? if ($log=="home" || $log=="") { ?>
     <li><a href="?log=home" class="active">Home</a></li>
     <? } else { ?>
     <li><a href="?log=home" class="bold">Home</a></li>
     <? } ?>
   </ul>
   <? ### NAM ### ?>
   <ul>
     <? if ($log=="view22n_2" || $log=="view22n_3") {?>
     <li><a href="<?=$homelink?>#nam" class="top_parent-active">NAM</a>
     <? } else {?>
     <li><a href="<?=$homelink?>#nam" class="top_parent">NAM</a>
     <? } ?>
     <ul>
       <li><a href="?log=view22n_2&wcoss=<?=$wcoss?>" class="sublist">Report Counts</a></li>
       <li><a href="?log=view22n_3&wcoss=<?=$wcoss?>" class="sublist">Dump Start Times</a></li>
<!--   <li><a href="stnplts.php?net=nam&wcoss=<?=$wcoss?>" class="sublist" target="_blank">Dump Station Plots</a></li> -->
 
     </ul>
     </li>
   </ul>
   <? ### RAP ### ?>
   <ul>
     <? if ($log=="view22y_2" || $log=="view22y_3" || $log=="view22y_4") {?>
     <li><a href="<?=$homelink?>#ruc2a" class="top_parent-active">RAP</a>
     <? } else { ?>
     <li><a href="<?=$homelink?>#ruc2a" class="top_parent">RAP</a>
     <? } ?>
     <ul>
       <li><a href="?log=view22y_2&wcoss=<?=$wcoss?>" class="sublist">Missing Wind Profilers</a></li>
       <li><a href="?log=view22y_3&wcoss=<?=$wcoss?>" class="sublist">All Other Missing Data</a></li>
       <li><a href="?log=view22y_4&wcoss=<?=$wcoss?>" class="sublist">GETBUFR Data</a></li>
<!--   <li><a href="stnplts.php?net=ruc2a&wcoss=<?=$wcoss?>" class="sublist" target="_blank">Dump Station Plots</a></li> -->
     </ul>
     </li>
   </ul>
   <? ### SRUC, RTMA ### ?>
   <ul>
     <? if ($log=="view22y_5") {?>
     <li><a href="<?=$homelink?>#srucrtma" class="top_parent-active">SRUC, RTMA</a>
     <? } else { ?>
     <li><a href="<?=$homelink?>#srucrtma" class="top_parent">SRUC, RTMA</a>
     <? } ?>
     <ul>
       <li><a href="?log=view22y_5&wcoss=<?=$wcoss?>" class="sublist">All Messages</a></li>
<!--   <li><a href="stnplts.php?net=rtma&wcoss=<?=$wcoss?>" class="sublist" target="_blank">Dump Station Plots</a></li> -->
     </ul>
     </li>
   </ul>
   <? ### Non-fatal Abnormal RCs ### ?>
   <ul>
     <? if ($log=="view22n_5" || $log=="view22n_6") { ?>
     <li><a href="<?=$homelink?>#nonfatal" class="top_parent-active">Non-fatal Abnormal RCs</a>
     <? } else { ?>
     <li><a href="<?=$homelink?>#nonfatal" class="top_parent">Non-fatal Abnormal RCs</a>
     <? } ?>
     <ul>
       <li><a href="?log=view22n_5&wcoss=<?=$wcoss?>" class="sublist">Satellite Ingest</a></li>
       <li><a href="?log=view22n_6&wcoss=<?=$wcoss?>" class="sublist">Level II Ingest</a></li>
     </ul>
     </li>
   </ul>
   <? ### RC=22 ### ?>
   <ul>
     <? if ($log=="view22n_7a" || $log=="view22n_7b") {?>
     <li><a href="<?=$homelink?>#rc22" class="top_parent-active">RC=22</a>
     <? } else { ?>
     <li><a href="<?=$homelink?>#rc22" class="top_parent">RC=22</a>
     <? } ?>
     <ul>
       <li><a href="?log=view22n_7a&wcoss=<?=$wcoss?>" class="wrap">All networks except RAP, SRUC, RTMA</a></li>
       <li><a href="?log=view22n_7b&wcoss=<?=$wcoss?>" class="sublist">1b Data Dumps</a></li>
     </ul>
     </li>
   </ul>
   <? ### *.out ### ?>
   <ul>
     <? if ($log=="view22n_21" || $log=="view22n_22" || $log=="view22n_23") {?>
     <li><a href="<?=$homelink?>#out" class="top_parent-active">*.out</a>
     <? } else { ?>
     <li><a href="<?=$homelink?>#out" class="top_parent">*.out</a>
     <? } ?>
     <ul>
       <li><a href="?log=view22n_21&wcoss=<?=$wcoss?>" class="sublist">No. of Lines in tranjb*.out Files</a></li>
       <li><a href="?log=view22n_22&wcoss=<?=$wcoss?>" class="sublist">Rejected/Bad Date Tosses</a></li>
       <li><a href="?log=view22n_23&wcoss=<?=$wcoss?>" class="wrap">Rejected Due to Meaningless Date Tosses</a></li>
     </ul>
     </li>
   </ul>
   <? ### DUMP Output ### ?>
   <ul>
     <? if ($log=="view22n_26" || $log=="view22n_29") {?>
     <li><a href="<?=$homelink?>#dumpoutput" class="top_parent-active">DUMP Output</a>
     <? } else { ?>
     <li><a href="<?=$homelink?>#dumpoutput" class="top_parent">DUMP Output</a>
     <? } ?>
     <ul>
       <li><a href="?log=view22n_26&wcoss=<?=$wcoss?>" class="sublist">Quips Problems</a></li>
       <li><a href="?log=view22n_29&wcoss=<?=$wcoss?>" class="wrap">BUFRLIB Warnings & Syntax Errors</a></li>
<!--   <li><a href="stnplts.php?net=nam&wcoss=<?=$wcoss?>" target="_blank" class="wrap" target="_blank">Station Plots</a></li> -->
     </ul>
     </li>
   </ul>
   <? ### Ingest Output ### ?>
   <ul>
     <? if ($log=="view22n_19" || $log=="view22n_28" || $log=="view22n_27") { ?>
     <li><a href="<?=$homelink?>#ingestoutput" class="top_parent-active">Ingest Output</a>
     <? } else { ?>
     <li><a href="<?=$homelink?>#ingestoutput" class="top_parent">Ingest Output</a>
     <? } ?>
     <ul>
       <li><a href="?log=view22n_19&wcoss=<?=$wcoss?>" class="sublist">Age of Ingest Output Files</a></li>
       <li><a href="?log=view22n_28&wcoss=<?=$wcoss?>" class="wrap">Lapsed Data Hourwait Calculation Problem</a></li>
       <li><a href="?log=view22n_27&wcoss=<?=$wcoss?>" class="wrap">BUFRLIB Warnings, Syntax Errors, Segmentation Faults, Connection Problems</a></li>
     </ul>
     </li>
   </ul>
   <? ### SPA Log ### ?>
   <ul>
     <? if ($log=="viewspalog") { ?>
     <li><a href="?log=viewspalog&wcoss=<?=$wcoss?>" class="active">SPA Log</a></li>
     <? } else { ?>
     <li><a href="?log=viewspalog&wcoss=<?=$wcoss?>" class="bold">SPA Log</a></li>
     <? } ?>
   </ul>
   <? ### RC=11 ### ?>
   <ul>
     <? if ($log=="view11") {?>
     <li><a href="?log=view11&wcoss=<?=$wcoss?>" class="active">RC=11</a></li>
     <? } else { ?>
     <li><a href="?log=view11&wcoss=<?=$wcoss?>" class="bold">RC=11</a></li>
     <? } ?>
   </ul>
   <? ### FAILURES ### ?>
   <ul>
     <? if ($log=="viewfail") {?>
     <li><a href="?log=viewfail&wcoss=<?=$wcoss?>" class="active">FAILURES</a></li>
     <? } else { ?>
     <li><a href="?log=viewfail&wcoss=<?=$wcoss?>" class="bold">FAILURES</a></li>
     <? } ?>
   </ul>
   <? ### Datacount ### ?>
   <ul>
     <? if ($log=="view22n_4" || $log=="view22n_8") { ?>
     <li><a href="<?=$homelink?>#datacount" class="top_parent-active">Datacount</a>
     <? } else { ?>
     <li><a href="<?=$homelink?>#datacount" class="top_parent">Datacount</a>
     <? } ?>
     <ul>
       <li><a href="?log=view22n_4&wcoss=<?=$wcoss?>" class="wrap">Avg Tables & Status Files Available for Datacount Avgs</a></li>
       <li><a href="?log=view22n_8&wcoss=<?=$wcoss?>" class="sublist">Alerts</a></li>
     </ul>
     </li>
   </ul>
   <? ### File Ages ### ?>
   <ul>
     <?  if ($log=="view22n_15" || $log=="view22n_17" ) {?>
     <li><a href="<?=$homelink?>#fileages" class="top_parent-active">File Ages</a>
     <? } else { ?>
     <li><a href="<?=$homelink?>#fileages" class="top_parent">File Ages</a>
     <? } ?>
     <ul>
       <li><a href="?log=view22n_15&wcoss=<?=$wcoss?>" class="sublist">Error Files in /dcom</a></li>
       <li><a href="?log=view22n_17&wcoss=<?=$wcoss?>" class="wrap">"Repeat" Files in /dcom/ingest_hist</a></li>
     </ul>
     </li>
   </ul>
   <? ### Tropcyc Bulletins ### ?>
   <ul>
     <?  if ($log=="view22n_24" || $log=="view22n_25" ) {?>
     <li><a href="<?=$homelink?>#tropcyc" class="top_parent-active">Tropcyc Bulletins</a>
     <? } else { ?>
     <li><a href="<?=$homelink?>#tropcyc" class="top_parent">Tropcyc Bulletins</a>
     <? } ?>
     <ul>
       <li><a href="?log=view22n_24&wcoss=<?=$wcoss?>" class="sublist">wtxtbul/tropcyc</a></li>
       <li><a href="?log=view22n_25&wcoss=<?=$wcoss?>" class="wrap">wbfrbul/tropcyc</a></li>
     </ul>
     </li>
   </ul>
   <? ### Miscellaneous ### ?>
   <ul>
     <? if ($log=="view22n_9" || $log=="view22n_10" || $log=="view22n11" || $log=="view22n_12" || $log=="view22n_13" || $log=="view22n_14"|| $log=="view22n_16" || $log=="view22n_18" || $log=="view22n_20" || $log=="view22n_30" || $log=="view22n_31") {?>
     <li><a href="<?=$homelink?>#misc" class="top_parent-active">Miscellaneous</a>
     <? } else { ?>
     <li><a href="<?=$homelink?>#misc" class="top_parent">Miscellaneous</a>
     <? } ?>
     <ul>
       <li><a href="?log=view22n_9&wcoss=<?=$wcoss?>" class="wrap">All Other Messages For All Networks Except RAP, SRUC, RTMA</a></li>
       <li><a href="?log=view22n_10&wcoss=<?=$wcoss?>" class="sublist">Tropical Bogus Summary</a></li>
       <li><a href="?log=view22n_11&wcoss=<?=$wcoss?>" class="sublist">NDAS Did Not Run Listing</a></li>
       <li><a href="?log=view22n_12&wcoss=<?=$wcoss?>" class="wrap">Dump Script Tank Suddenly Off-Line Listing</a></li>
       <li><a href="?log=view22n_13&wcoss=<?=$wcoss?>" class="sublist">LL* Jobs Listing</a></li>
       <li><a href="?log=view22n_14&wcoss=<?=$wcoss?>" class="sublist">Tank Diff-ing</a></li>
       <li><a href="?log=view22n_16&wcoss=<?=$wcoss?>" class="sublist">ACF Entries in SDMedit</a></li>
       <li><a href="?log=view22n_18&wcoss=<?=$wcoss?>" class="wrap">SDMedit and Quips Files in /dcom</a></li>
       <li><a href="?log=view22n_20&wcoss=<?=$wcoss?>" class="wrap">No. of AIRNOW Reports Dumped in Past Few Days</a></li>
       <li><a href="?log=view22n_30&wcoss=<?=$wcoss?>" class="wrap">BUFRLIB Warnings, Segmentation Faults, & Abnormal Termination Errors in Prep Output</a></li>
       <li><a href="?log=view22n_31&wcoss=<?=$wcoss?>" class="wrap">Too Many Levels in ADPUPA Listing</a></li>
     </ul>
     </li>
   </ul>
  </div> <? # end div id="menuh" ?>
 </div>  <? # end div id="menuh-container" ?>
