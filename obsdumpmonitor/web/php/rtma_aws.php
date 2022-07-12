<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
<title>NOAA - NCEP - EMC - RTMA AWS Moisture</title>
<style type="text/css" media="all" title="stylesheet">@import url(css/container.css);</style>
<style type="text/css" media="all" title="stylesheet">@import url(css/master.css);</style>
<link rel="icon" type="image/ico" href="icon/favicon.ico" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta name="description" content="NOAA - NCEP - EMC Data Processing"> 
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAZfIm7vj2L5-Jd1mHplA6LRR8P6Sxm61KIrkZZ6cHFMbVOak7JhRT_GIr5a15AVm9HPAhX_oVC3vATg"
type="text/javascript"></script>
<!--<script src="http://acme.com/javascript/Clusterer2.jsm" type="text/javascript"></script>-->
</head>
<body onunload="GUnload()">


<div id="wrap">
<div id="header">
</div> <!-- header -->
<div id="nav">
 <div id="menuh-container">
  <div id="menuh">
  </div> <!-- menuh -->
 </div> <!-- menuh-container -->
</div> <!-- nav -->

<div id="main"> 

<div id="bc">
</div>

<div id="map" style="width: 796px; height: 700px"></div>
<!-- <div id="side_bar"></div> -->

<script type="text/javascript">
//<![CDATA[

if (GBrowserIsCompatible())
 { 
  // this variable will collect the html which will eventually be placed in 
  // the side_bar
  //var side_bar_html = "";
    
  // arrays to hold copies of the markers used by the side_bar
  // because the function closure trick doesnt work there
  var gmarkers = [];

  // A function to create the marker and set up the event window
  function createMarker(point,name,html)
   { 
    var marker = new GMarker(point);
    GEvent.addListener(marker, "click", function()
     { 
      marker.openInfoWindowHtml(html);
     });
    // save the info we need to use later for the side_bar
    gmarkers.push(marker);
    // add a line to the side_bar html
    //side_bar_html += '<a href="javascript:myclick(' + (gmarkers.length-1) + ')">' + name + '<\/a><br>';
    return marker;
   }

  // This function picks up the click and opens the corresponding info window
  function myclick(i)
   { 
    GEvent.trigger(gmarkers[i], "click");
   }

  // create the map
  var map = new GMap2(document.getElementById("map"));
  map.addControl(new GLargeMapControl());
  map.addControl(new GMapTypeControl());
  map.setCenter(new GLatLng( 36.0, -97.0), 4);

 }
else
 { 
 }

var gx = new GGeoXml("http://www.emc.ncep.noaa.gov/mmb/obsdumpmonitor/xml/rtma_aws_final_moist.kml");
map.addOverlay(gx);

//]]>
</script>

</div> <!-- main -->

 <div id="footer">
 </div> <!-- footer -->

</div> <!-- wrap -->

</body>
</html>
