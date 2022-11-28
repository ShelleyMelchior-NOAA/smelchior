<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
   <meta name="Generator" content="WordPerfect 9">
   <meta name="GENERATOR" content="Mozilla/4.7 [en] (Win98; U) [Netscape]">
   <meta name="Author" content="Dennis A. Keyser">
   <title>VIRTUAL TEMPERATURE PROCESSING</title>
</head>
<body text="#000000" bgcolor="#FFFFFF" link="#0000FF" vlink="#551A8B" alink="#FF0000">

<center>Summary of Virtual Temperature Processing in PREPBUFR
<p>(Last Revised 7/10/2001)</center>

<p><br>
<br>
<br>
<p>For surface land and marine reports, this is performed in w3lib routine
GBLEVENTS.
<p>The following tests are made:
<p>1. Reported POB (pressure), TOB (sensible temperature), and dewpoint
temperature (TDO) are all non-missing.
<p>2. If QQM (moisture q.m.) is "rejected" (> 3) then a "sanity" check
is done: the TDO must be > 170 and &lt; 320 K, and POB must be > 0 and
&lt; 1100 mb.
<p>If 1 is true and either QQM &lt; 4 or the sanity check in 2 is passed,
then QOB (specific humidity) is calculated from TOB and POB, and TOB becomes
the virtual temperature calculated from TOB and QOB. Otherwise, TOB remains
the sensible temperature.
<p>If TOB is the virtual temperature then:
<p>a. If QQM is not rejected (&lt; 4), then the virtual temperature q.m.
(TQM) is set to the sensible temperature (TQM ). The event has program
code (TPC) "VIRTMP" and reason code (TRC) "0".
<p>b. If QQM is rejected (> 3) (meaning sanity check passed in 2 above),
then the virtual temperature q.m. (TQM) is set to 8 (rejected). The event
has program code (TPC) "VIRTMP" and reason code (TRC) "2". This allows
the METAR reports in the Global system to have TOB as a virtual temperature
even though all surface land mass data, except for pressure, are flagged
for non-use by the SSI. Since the QQM is always the same as TQM for surface
data, there is never the chance than a non-rejected sensible temperature
would be replaced by a rejected virtual temperature.
<br>&nbsp;
<p>For upper-air (radiosonde, dropwinsonde) reports, this is performed
in program PREPOBS_CQCBUFR.
<p>The following tests are made:
<p>1. Reported POB (pressure), TOB (sensible temperature), and dewpoint
temperature (TDO) are all non-missing.
<p>2. QQM (moisture q.m.) is not rejected (&lt; 4).
<p>3. Report passes a "sanity" check: TDO must be > 170 and &lt; 320 K,
and POB must be > 0 and &lt; 1100 mb.
<p>If 1, 2 and 3 are all true, then QOB (specific humidity) is calculated
from TOB and POB, and TOB becomes the virtual temperature calculated from
TOB and QOB . Otherwise, TOB remains the sensible temperature.
<p>TOB can only be virtual temperature if QQM is not rejected (&lt; 4).
In this case, the virtual temperature q.m. (TQM) is set to the sensible
temperature (TQM ). The event has program code (TPC) "VIRTMP" and reason
code (TRC) "1". Unlike surface data, virtual temperature is never calculated
when QQM is rejected. This is necessary because the QQM is set to rejected
for moisture above 300 mb in GBLEVENTS. The temperature q.m. on these levels
remains sensible, but not-rejected.
<br>&nbsp;
</body>
</html>
