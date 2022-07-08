 <div id="col-container">
 <div id="col-left">
<?# NAM ?>
 <div id="p" class="gray">
  <strong><a name="nam">NAM:</a></strong><br />
  <strong><a href="?log=view22n_2&wcoss=<?=$wcoss?>">Report Counts</a></strong><br />
  Looks through <font class="courier">/com/arch/prod/obcount_30day/nam/*/*</font> for the NAM during the past 30 days.
 <div id="script">
 <a href="scripts/view22n_2" target="_blank">view script</a>
 </div>
  <strong><a href="?log=view22n_3&wcoss=<?=$wcoss?>">NAM Dump Start Times</a></strong><br />
  Looks through <font class="courier">/com/logs/jlogfile</font> and <font class="courier">/com/logs/jlogfile.old.[16,15,14,13,12]</font> (to cover 24 hours) for the start times of the NAM dump.
 <div id="script">
 <a href="scripts/view22n_3" target="_blank">view script</a>
 </div>
 </div>
<? # RAP ?>
 <div id="p" class="gray">
  <strong><a name="rap">RAP:</a></strong><br />
  <strong><a href="?log=view22y_2&wcoss=<?=$wcoss?>">Missing Wind Profilers</a></strong><br />
  Looks through <font class="courier">/com/logs/jlogfile</font> and <font class="courier">/com/logs/jlogfile.old.[16,15,14,13,12]</font> (to cover 24 hours) for missing wind profiler information in the RAP dump.
 <div id="script">
 <a href="scripts/view22y_2" target="_blank">view script</a>
 </div>
  <strong><a href="?log=view22y_3&wcoss=<?=$wcoss?>">All Other Missing Data</a></strong><br />
  Looks through <font class="courier">/com/logs/jlogfile</font> and <font class="courier">/com/logs/jlogfile.old.[16,15,14,13,12]</font> (to cover 24 hours) for any missing information in RAP dump.
 <div id="script">
 <a href="scripts/view22y_3" target="_blank">view script</a>
 </div>
  <strong><a href="?log=view22y_4&wcoss=<?=$wcoss?>">Check for too much data in GETBUFR</a></strong><br />
  Looks through <font class="courier">/com/output/<?=$wcoss?>/today</font> for "while processing" in *rap*prep* files. 
 <div id="script">
 <a href="scripts/view22y_4" target="_blank">view script</a>
 </div>
 </div>
<? # SRUC, RTMA ?>
 <div id="p" class="gray">
  <strong><a name="srucrtma">SRAP, RTMA</a></strong><br />
  <strong><a href="?log=view22y_5&wcoss=<?=$wcoss?>">All Messages</a></strong><br />
  Looks through <font class="courier">/com/logs/jlogfile</font> and <font class="courier">/com/logs/jlogfile.old.[16,15,14,13,12]</font> (to cover 24 hours) for missing components of dumps.
 <div id="script">
 <a href="scripts/view22y_5" target="_blank">view script</a>
 </div>
 </div>
<? # Non-fata/Abnormal RCs ?>
 <div id="p" class="gray">
  <strong><a name="nonfatal">Non-fatal Abnormal RCs</a></strong><br />
  <strong><a href="?log=view22n_5&wcoss=<?=$wcoss?>">Satellite Ingest</a></strong><br />
  Looks through <font class="courier">/com/logs/jlogfile</font> and <font class="courier">/com/logs/jlogfile.old.[16,15,14,13,12]</font> (to cover 24 hours) for non-fatal / abnormal RCs in all networks except RAP, SRUC, RTMA.
 <div id="script">
 <a href="scripts/view22n_5" target="_blank">view script</a>
 </div>
  <strong><a href="?log=view22n_6&wcoss=<?=$wcoss?>">Level II Ingest</a></strong><br />
  Looks through <font class="courier">/com/logs/jlogfile</font> and <font class="courier">/com/logs/jlogfile.old.[16,15,14,13,12]</font> (to cover 24 hours) for non-fatal / abnormal RCs in all networks except RAP, SRUC, RTMA.
 <div id="script">
 <a href="scripts/view22n_6" target="_blank">view script</a>
 </div>
 </div>
<? # RC=22 ?>
 <div id="p" class="gray">
  <strong><a name="rc22">RC=22</a></strong><br />
  <strong><a href="?log=view22n_7a&wcoss=<?=$wcoss?>">All networks except rap, sruc, rtma and 1b data dumps</a></strong><br />
  Looks through <font class="courier">/com/logs/jlogfile</font> and <font class="courier">/com/logs/jlogfile.old.[16,15,14,13,12]</font> (to cover 24 hours) for RC=22 in all networks except RAP, SRUC, RTMA and 1b data dumps.
 <div id="script">
 <a href="scripts/view22n_7a" target="_blank">view script</a>
 </div>
  <strong><a href="?log=view22n_7b&wcoss=<?=$wcoss?>">1b data dumps</a></strong><br />
  Looks through <font class="courier">/com/logs/jlogfile</font> and <font class="courier">/com/logs/jlogfile.old.[16,15,14,13,12]</font> (to cover 24 hours) for RC=22 in 1b data dumps.
 <div id="script">
 <a href="scripts/view22n_7b" target="_blank">view script</a>
 </div>
 </div>
<? # *.out ?>
 <div id="p" class="gray">
  <strong><a name="out">*.out</a></strong><br />
  <strong><a href="?log=view22n_21&wcoss=<?=$wcoss?>">No. of lines in tranjb*.out files</a></strong><br />
  Counts the number of lines in files <font class="courier">/dcom/us*/tranjb*.out</font>. 
 <div id="script">
 <a href="scripts/view22n_21" target="_blank">view script</a>
 </div>
  <strong><a href="?log=view22n_22&wcoss=<?=$wcoss?>">*.out rejected/bad date tosses</a></strong><br />
  Greps for "REJ DATE", "REJECTED DATE:", "BAD DATE", "(ONLY FIRST 100 PRINTED)" in <font class="courier">/dcom/us*/*.out</font>. 
 <div id="script">
 <a href="scripts/view22n_22" target="_blank">view script</a>
 </div>
  <strong><a href="?log=view22n_23&wcoss=<?=$wcoss?>">*.out rejected due to meaningless date tosses</a></strong><br />
  Greps for "REJECTED DUE TO MEANINGLESS" in <font class="courier">/dcom/us*/*.out</font>. 
 <div id="script">
 <a href="scripts/view22n_23" target="_blank">view script</a>
 </div>
 </div>
<? # DUMP Output ?>
 <div id="p" class="gray">
  <strong><a name="dumpoutput">DUMP output</a></strong><br />
  <strong><a href="?log=view22n_26&wcoss=<?=$wcoss?>">Check for quips problem in dump output</a></strong><br />
  Presently disabled.  Greps for "a read stat" in <font class="courier">/com/output/prod/$date/*dump*</font>. 
 <div id="script">
 <a href="scripts/view22n_26" target="_blank">view script</a>
 </div>
  <strong><a href="?log=view22n_29&wcoss=<?=$wcoss?>">BUFRLIB warnings and syntax errors</a></strong><br />
 Scans through the following dump output: dump, mods, tofs_atl_assim_sst for "syntax error", "BUFRLIB:", "Segmentation fault" 
 <div id="script">
 <a href="scripts/view22n_29" target="_blank">view script</a>
 </div>
 </div>
<? # Ingest Output ?>
 <div id="p" class="gray">
  <strong><a name="ingestoutput">Ingest output</a></strong><br />
  <strong><a href="?log=view22n_19&wcoss=<?=$wcoss?>">How recent are the ingest output files?</a></strong><br />
  Lists on <font class="courier">/dcom/us/*out*</font> and greps for "errlog". 
 <div id="script">
 <a href="scripts/view22n_19" target="_blank">view script</a>
 </div>
  <strong><a href="?log=view22n_28&wcoss=<?=$wcoss?>">Lapsed data hourwait caclulation problem</a></strong><br />
 Scans through the following ingest output for "nwprod/ush/ingest_check_lapsed_data[": radwnd, airs, euscatter, qscatter, radsnd, satwnd, ssmi, tmi, tovs.
 <div id="script">
 <a href="scripts/view22n_28" target="_blank">view script</a>
 </div>
  <strong><a href="?log=view22n_27&wcoss=<?=$wcoss?>">BUFRLIB warnings, syntax errors, segmentation faults, connection problems</a></strong><br />
  Scans through the following ingest output for a number of key words/phrases: radwnd, airs, euscatter, qscatter, radsnd, satwnd, ssmi, tmi, tovs, oes_sst, sstfld, ozone, shf, aerosol, shef, snow, poes_sst. 
 <div id="script">
 <a href="scripts/view22n_27" target="_blank">view script</a>
 </div>
 </div>
 </div> <!-- end div id="col-left" -->
 <div id="col-right">
<? # SPA Log ?>
 <div id="p" class="gray">
  <strong><a href="?log=viewspalog&wcoss=<?=$wcoss?>" name="spalog">SPA Log</a></strong><br />
  <font class="courier">view /com/logs/spalog</font><br />
  View the log kept by the SPAs, truncated to only show the current date's entries.
 </div>
<? # RC=11 ?>
 <div id="p" class="gray">
  <strong><a href="?log=view11&wcoss=<?=$wcoss?>" name="rc11">RC=11</a></strong><br />
  <font class="courier">$ut/dkgrep11</font><br />
  Greps through all data types in <font class="courier">/com/logs/jlogfile[.old.[16][15][14]]</font> for RC=11, meaning 1 or more components of a dump are missing.
 <div id="script">
 <a href="scripts/dkgrep11" target="_blank">view script</a>
 </div>
 </div>
<? # FAILURES ?>
 <div id="p" class="gray">
  <strong><a href="?log=viewfail&wcoss=<?=$wcoss?>" name="failures">FAILURES</a></strong><br />
  <font class="courier">$UT/dkgrepFAIL</font><br />
  Greps through <font class="courier">/com/logs/jlogfile</font> and <font class="courier">/com/logs/jlogfile.old.[16,15,14,13,12]</font> (to cover 24 hours) for the following failure patterns:<br />
  ABNORMAL EXIT, ERROR converting, **FATAL ERROR, HAS COMPLETED WITH RETURN CODE
 <div id="script">
 <a href="scripts/dkgrepFAIL" target="_blank">view script</a>
 </div>
 </div>
<? # Datacount ?>
 <div id="p" class="gray">
  <strong><a name="datacount">Datacount</a></strong><br />
  <strong><a href="?log=view22n_4&wcoss=<?=$wcoss?>">Average Tables and Status Files Available for Datacount Averages</a></strong><br />
  Looks through <font class="courier">/com/arch/prod/avgdata/*</font> and <font class="courier">/com/arch/prod/obcount_30day/*/*</font> directories to list available files/tables.
 <div id="script">
 <a href="scripts/view22n_4" target="_blank">view script</a>
 </div>
  <strong><a href="?log=view22n_8&wcoss=<?=$wcoss?>">Alerts</a></strong><br />
  Looks through <font class="courier">/com/logs/jlogfile</font> and <font class="courier">/com/logs/jlogfile.old.[16,15,14,13,12]</font> (to cover 24 hours) for datacount deficiencies or abundances.
 <div id="script">
 <a href="scripts/view22n_8" target="_blank">view script</a>
 </div>
 </div>
<?# File ages ?>
 <div id="p" class="gray">
  <strong><a name="fileages">File ages</a></strong><br />
  <strong><a href="?log=view22n_15&wcoss=<?=$wcoss?>">Age of error files in /dcom</a></strong><br />
  Lists through <font class="courier">/dcom/us*</font> for errlog files.  Also checks for presence of bufrtab.011 and bufrtab.***. 
 <div id="script">
 <a href="scripts/view22n_15" target="_blank">view script</a>
 </div>
  <strong><a href="?log=view22n_17&wcoss=<?=$wcoss?>">Age of "repeat" files in /dcom/ingest_hist</a></strong><br />
  Lists through <font class="courier">/dcom/us*/ingest_hist/*repeat*</font>. 
 <div id="script">
 <a href="scripts/view22n_17" target="_blank">view script</a>
 </div>
 </div>
<?# Tropcyc Bulletins ?>
 <div id="p" class="gray">
  <strong><a name="tropcyc">Tropcyc Bulletins</a></strong><br />
  <strong><a href="?log=view22n_24&wcoss=<?=$wcoss?>">wtxtbul/tropcyc</a></strong><br />
  Lists through <font class="courier">/dcom/us*/*/wtxtbul/tropcyc</font> for the latest tropcyc text bulletins. 
 <div id="script">
 <a href="scripts/view22n_24" target="_blank">view script</a>
 </div>
  <strong><a href="?log=view22n_25&wcoss=<?=$wcoss?>">wbfrbul/tropcyc</a></strong><br />
  Lists through <font class="courier">/dcom/us*/*/wbfrbul/tropcyc</font> for latest tropcyc BUFR bulletins. 
 <div id="script">
 <a href="scripts/view22n_25" target="_blank">view script</a>
 </div>
 </div>
<? # Miscellaneous ?>
 <div id="p" class="gray">
  <strong><a name="misc">Miscellaneous</a></strong><br />
  <strong><a href="?log=view22n_9&wcoss=<?=$wcoss?>">All other messages for all networks except rap, sruc, rtma</a></strong><br />
  Looks through <font class="courier">/com/logs/jlogfile</font> and <font class="courier">/com/logs/jlogfile.old.[16,15,14,13,12]</font> (to cover 24 hours) for any other informational messages for all networks except for rap, sruc, rtma.
 <div id="script">
 <a href="scripts/view22n_9" target="_blank">view script</a>
 </div>
  <strong><a href="?log=view22n_10&wcoss=<?=$wcoss?>">Tropical Cyclone Bogus Summary</a></strong><br />
  Looks through <font class="courier">/com/logs/jlogfile</font> and <font class="courier">/com/logs/jlogfile.old.[16,15,14,13,12]</font> (to cover 24 hours) for summary information from tropical cyclone bogus runs.
 <div id="script">
 <a href="scripts/view22n_10" target="_blank">view script</a>
 </div>
  <strong><a href="?log=view22n_11&wcoss=<?=$wcoss?>">NDAS did not run listing</a></strong><br />
  Looks through <font class="courier">/com/logs/jlogfile</font> and <font class="courier">/com/logs/jlogfile.old.[16,15,14,13,12]</font> (to cover 24 hours) for "NDAS RESTART FILE NOT FOUND: DO A STATIC ANALYSIS".
 <div id="script">
 <a href="scripts/view22n_11" target="_blank">view script</a>
 </div>
  <strong><a href="?log=view22n_12&wcoss=<?=$wcoss?>">Dump script tank suddenly off-line listing</a></strong><br />
  Looks through <font class="courier">/com/logs/jlogfile</font> and <font class="courier">/com/logs/jlogfile.old.[16,15,14,13,12]</font> (to cover 24 hours) for "(suddenly offline?)," "30 seconds," "no longer empty!," "still empty."
 <div id="script">
 <a href="scripts/view22n_12" target="_blank">view script</a>
 </div>
  <strong><a href="?log=view22n_13&wcoss=<?=$wcoss?>">LL* jobs listing</a></strong><br />
  Looks through LLtovs, LLssmi, LLqscatter, LLeuscatter, LLairs jobs for "HAS BEGUN," "HAS COMPLETED NORMALLY," "ABNORMAL EXIT," "HAS COMPLETED ABNORMALLY." 
 <div id="script">
 <a href="scripts/view22n_13" target="_blank">view script</a>
 </div>
  <strong><a href="?log=view22n_14&wcoss=<?=$wcoss?>">Tank diff-ing</a></strong><br />
  Diff tanks in oldest YYYYMMDD directory vs. those in yesterday's YYYYMMDD directory." 
 <div id="script">
 <a href="scripts/view22n_14" target="_blank">view script</a>
 </div>
  <strong><a href="?log=view22n_16&wcoss=<?=$wcoss?>">Check ACF entries in sdmedit</a></strong><br />
  Greps through <font class="courier">/dcom/us*/sdmedit</font> for "ACF." 
 <div id="script">
 <a href="scripts/view22n_16" target="_blank">view script</a>
 </div>
  <strong><a href="?log=view22n_18&wcoss=<?=$wcoss?>">sdmedit and quips files in /dcom</a></strong><br />
  Displays the last 10 lines of the most recent sdmedit and quips files in <font class="courier">/dcom/us*</font>. 
 <div id="script">
 <a href="scripts/view22n_18" target="_blank">view script</a>
 </div>
  <strong><a href="?log=view22n_20&wcoss=<?=$wcoss?>">No. of AIRNOW reports dumped the past few days</a></strong><br />
  Greps through <br /><font class="courier">/com/hourly/prod/hourly.*/aqm.t12z.status.tm00.bufr_d</font> for "HAS" to key on report counts. 
 <div id="script">
 <a href="scripts/view22n_20" target="_blank">view script</a>
 </div>
  <strong><a href="?log=view22n_30&wcoss=<?=$wcoss?>">BUFRLIB warnings, segmentation faults, and abnormal termination errors in prep output</a></strong><br />
 Scans through <font class="courier">/com/output/<?=$wcoss?>/*_prep_*</font> for "Command terminated abnormally", "BUFRLIB", "Segmentation fault". 
 <div id="script">
 <a href="scripts/view22n_30" target="_blank">view script</a>
 </div>
  <strong><a href="?log=view22n_31&wcoss=<?=$wcoss?>">Check for too many levels in ADPUPA listing</a></strong><br />
 Runs on production machine only.<br />
 Searches through <font class="courier">/com/[nam][gfs]/<?=$wcoss?>/[nam][gfs][gdas].*</font> for "limit has already been reached". 
 <div id="script">
 <a href="scripts/view22n_31" target="_blank">view script</a>
 </div>
 </div>
 </div> <!-- end div id="col-right" -->
 </div> <!-- end div id="col-container" -->
 <div id="p" class="ut">
  ** <font class="courier">$UT</font> is the directory path where the obs data monitoring scripts are housed.
 </div>
 <div id="p" class="ut">
  ** prod and dev status are as of 12:05 UTC on the current calendar day.
 </div>
 <div id="p" class="ut">
  ** viewspalog is run hourly.
 </div>
