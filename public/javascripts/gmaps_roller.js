var k = new Array();	// location array
var t = new Array();	// text array
var z = new Array();	// zoom array
var i = 0;		// traverse id
var p;			// previous marker
var map;		// the map
var dtZoom = 9;		// default traverse zoom
var d = new Date();


function render() {
	map = new GMap2(document.getElementById("map"));
	// initialize the map, and set zoom = 8
	map.setCenter(new GLatLng(23.63446, 120.970459), 8);

	// set the controller
	var mapControl = new GMapTypeControl();
	map.addControl(mapControl);
	map.addControl(new GSmallMapControl());

	update();

	// update list every 90 secs
	$('#count').everyTime(90000, function() { update(); });

	// each point shows for 5 secs
	$('#map').everyTime(5000, function() { traverse(); });
}

function update() {
	$.ajax({
		type: "GET",
		url: "gmaps?" + d.getTime(),
		dataType: "json",
		success: function(data) {
			$.each(data.items, function(num, item) {
				var g = new GClientGeocoder();
				// query the position
				g.getLatLng(item.location, function(latlng) {
					if(latlng) {
						k[num] = latlng;
						// text in bubble could be modified here
						t[num] = "<h3>" + item.subject + "</h3><p>"+"<strong>" + item.location_name + "</strong><br /><br />" + item.content + "</p>";
						if(item.zoom) z[num] = item.zoom;
						else z[num] = dtZoom;
					}
				});
			});
			if(k.length > 0) document.getElementById('count').innerHTML = "Count: " + k.length;
		}
	});
}

function traverse() {
	if(i >= 0) i %= k.length;
	if(p) map.removeOverlay(p);
	if(map.getZoom() != z[i]) map.setCenter(k[i], z[i]); // if not zooming, comment out this line
	map.panTo(k[i]);
	var marker = new GMarker(k[i]);
	map.addOverlay(marker);
	marker.openInfoWindowHtml(t[i]);

	p = marker;
	i++;

	document.getElementById('count').innerHTML = "Count: " + k.length + ", current: " + i;
}
