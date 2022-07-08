<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
<title>Google Maps JavaScript API Example</title>
<script src="http://maps.googleapis.com/maps/api/js?key=ABQIAAAAPI4wou--an7ZjU7fKLQYuxS0RxRP&sensor=true"
type="text/javascript"></script>
<!--<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAPI4wou--an7ZjU7fKLQYuxS0RxRP"
type="text/javascript"></script>-->
<script type="text/javascript">
//<![CDATA[

function load() {
if (GBrowserIsCompatible()) {

    var map = new GMap2(document.getElementById("map"));
    map.addControl(new GLargeMapControl());
    map.addControl(new GMapTypeControl());

    // The following defines the mid-point for the map and the initial scale. The "11" can be replaced
    // with numbers between 1-16
    map.setCenter(new GLatLng(41.258531,-96.012599), 11);

    // Download the data in data.xml and load it on the map. The format we
    // expect is:
    // <markers>
    // <marker lat="37.441" lng="-122.141"/>
    // <marker lat="37.322" lng="-121.213"/>
    // </markers>
    GDownloadUrl("data.xml", function(data) {

        var xml = GXml.parse(data);
        var markers = xml.documentElement.getElementsByTagName("marker");
        for (var i = 0; i < markers.length; i++) {

            var point = new GLatLng(parseFloat(markers[i].getAttribute("lat")),
            parseFloat(markers[i].getAttribute("lng")));
            map.addOverlay(new GMarker(point));

}
});
}
}

//]]>
</script>

</head>

    <body onload="load()" onunload="GUnload()">
    <div id="map" style="width: 750px; height: 900px"></div>
    </body>

</html>
