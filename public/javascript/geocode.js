
/*********************************************************************
** Description: Locational Search
What it does: Uses the google maps js api to read an entered address
and convert it into latitude and longitude coordinates.  Then makes an
asynchronous xmlhttp request to /location search to find events within
a certain distance of those coords.
Describe arguments/restrictions: Forms data will be an address or a
zip code.
what it returns: Server returns event name and event information.
*********************************************************************/
if(top.location.pathname === '/') {
document.getElementById("searchSubmit").addEventListener('click', function(event){
	// Prevent the default form action (stops page refresh)
	event.preventDefault();
	
	// Reads form contents
	var addressVal = document.getElementById('userAddress').value;
	var distance = document.getElementById('distance').value;

	// Google maps api object instance.
	var geocoder = new google.maps.Geocoder();	
	geocoder.geocode({'address': addressVal}, function(results, status) {
		if (status === 'OK') {
			
			// Read latitude and long from results.
			var myResult = results[0].geometry.location;
			var stringRes = JSON.stringify(myResult);
			var objRes = JSON.parse(stringRes);
			
			console.log(objRes.lat);
			console.log(objRes.lng);

			var payload = latLngRangeCalc(objRes.lat, objRes.lng, distance);
			console.log(payload.latMin);
			console.log(payload.latMax);
			console.log(payload.lngMin);
			console.log(payload.lngMax);

			// Create an asynch request sending lat and long to /locationSearch
			var req = new XMLHttpRequest();
			var queryString = "/locationSearch?latMin=" + payload.latMin + 
				"&latMax="+ payload.latMax + "&lngMin=" + payload.lngMin + 
				"&lngMax=" + payload.lngMax;

			req.open("GET", queryString, true);
			//req.setRequestHeader("Content-Type", "application/json");

			req.addEventListener('load', function(){
				if(req.status >= 200 && req.status < 400){

					// Response contains event names and information
					var response = JSON.parse(req.responseText);
	
					// JQuery to manipulate home dom to replace elements with a
					// List of returned events.
					$("#homePageText").after('<div id="eventSearchResText"></div>');
					$('#navMain').clone().appendTo('#eventSearchResText');
					$("body").css("background-color", "#E3E3E3");

					$("#homePageText").remove();
					$('#eventSearchResText').append('<div class="jumbotron jumbotron-fluid" id="searchResPageJumbo">' +
						'<div class="container" id="jumboText"></div></div>' +
						'<div class="container" id="eventSearchResPage"></div>');    
					$('#eventSearchResPage').append('<div class="container" id="eventSearchResults">');				
					
					var data = response.table;

					if (jQuery.isEmptyObject(data)) {
						$('#eventSearchResults').append('<h2>No events near you. Try broadening your search.</h2>');
					} else {
						$('#eventSearchResults').append('<h3>Map of local events</h3><hr><br />');
						$('#eventSearchResults').append('<div id="map"></div><br />');

						initMap(objRes.lat, objRes.lng, distance);

						$('#eventSearchResults').append('<h3>Search Results. Click on events for more info!</h3><hr><br />');
						$('#eventSearchResults').append('<div class="list-group" id="eventList"></div>');
						
					}

					var count = 0;
					for (var key in data) {
						console.log(data[key].eventlatitude);
						addMapMarker(data[key].eventlatitude, data[key].eventlongitude, data[key].eventname);
						$('#eventList').append('<form action="/eventInformation" method="get" id="list'+ count + '"></form>');

						// Create new li element
						$("#list" + count + ":last-child").append('<input type="hidden" name="eid"' + 
							' value="' + data[key].eid + '"></>');
						$("#list" + count + ":last-child").append('<button type="submit" form="list'+ count + '" class="list-group-item list-group-item-action"' + 
							'value="'+ data[key].eid + '" id="listButton">' + data[key].eventname + '<br />'+ data[key].eventdescription + '</button>');

						count++;	
					}

					
					
					$('#eventSearchResText').after('<div class="container" id="footer"></div>');

				} else {
					console.log("Error in network request: " + req.statusText);
				}});

			req.send();

		} else {
			alert("Error in geocode lookup" + status);
		}
	});	
});
}

var map;

// Check that API key has loaded successfully 
function initSearch() {
	console.log("searchReady");
}

function initMap(latVal, lngVal, distance) {
	if (distance > 25) {
		zoomVal = 10;
	} else {
		zoomVal = 11;
	}

	var searchLocation = {lat: latVal, lng: lngVal};
	map = new google.maps.Map(document.getElementById('map'), {
		zoom: zoomVal,
		center: searchLocation
	});  
}

function addMapMarker(latVal, lngVal, eventName) {
	var eventLocation = {lat: latVal, lng: lngVal};
	var marker = new google.maps.Marker({
        position: eventLocation,
        title: eventName,
        map: map
    });
}

/*********************************************************************
** Description: Lat Lng min max calculator
What it does: Calculates the minimum and maximum latitude and longitude
coordinates given a distance from a latitude and longitude point.
what it returns: Object with latMin, latMax, lngMin, lngMax
*********************************************************************/
function latLngRangeCalc(lat, lng, d) {
	// Use to convert from degrees to rad
	var p = Math.PI / 180;

	// Radius of the Earth
	var R = 6371;
	var ans = {latMin:null, latMax:null, lngMin:null, lngMax:null};

	// First iteration calculates longitude, second latitude
	for (i = 1; i < 3; i++) {
		// Bearing, convert to rad
		var brng = 90 * i * p;

		// convert to rad
		var latRad = lat * p;
		var lngRad = lng * p;

		var lat2Rad = Math.asin(Math.sin(latRad) * Math.cos(d/R) + Math.cos(latRad) * Math.sin(d/R) * Math.cos(brng));
		var lng2Rad = lngRad + Math.atan2(Math.sin(brng)*Math.sin(d/R) *Math.cos(latRad), Math.cos(d/R) - Math.sin(latRad)*Math.sin(lat2Rad));

		// Convert back to degrees
		lat2 = lat2Rad * (180 / Math.PI);
		lng2 = lng2Rad * (180 / Math.PI);

		// Calculate range by taking the difference in degrees that the distance
		// results in and subtracting/adding it to the original lat/long
		if (i == 1) {
			if (lng2 < lng) {
				ans.lngMin = lng - (lng - lng2);
				ans.lngMax = lng + (lng - lng2);
			} else {
				ans.lngMin = lng - (lng2 - lng);
				ans.lngMax = lng + (lng2 - lng);
			}
		} else {
			if (lat2 < lat) {
				ans.latMin = lat - (lat - lat2);
				ans.latMax = lat + (lat - lat2);
			} else {
				ans.latMin = lat - (lat2 - lat);
				ans.latMax = lat + (lat2 - lat);
			}
		}
	}

	return ans;
}

/*********************************************************************
** Description: Register submit
What it does: Submits post request to add new volunteer to the volunteer table.
Also adds an entry to the volunteer_event table.
*********************************************************************/
if(top.location.pathname === '/eventInformation') {
	$(document).ready(function () {
		document.getElementById("registerSubmit").addEventListener('click', function(event){
			// Prevent the default form action (stops page refresh)
			event.preventDefault();

			var emailVal = document.getElementById('userEmail').value;
			var eidVal = document.getElementById('eventEIDHolder').value;
			console.log(eidVal);
			console.log(emailVal);
			var payload = {email: emailVal, eid: eidVal};

			var req = new XMLHttpRequest();
			req.open("POST", "/register", true);
			req.setRequestHeader("Content-Type", "application/json");

			req.addEventListener('load', function(){
				if(req.status >= 200 && req.status < 400){
					// Response contains event names and information
					var response = JSON.parse(req.responseText);
				} else {
					console.log("Error in network request: " + req.statusText);
				}
			});

			req.send(JSON.stringify(payload));
		});
	});
}


