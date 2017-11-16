
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
document.getElementById("searchSubmit").addEventListener('click', function(event){
	// Prevent the default form action (stops page refresh)
	event.preventDefault();
	
	// Reads form contents
	var addressVal = document.getElementById('userAddress').value;

	// Google maps api object instance.
	var geocoder = new google.maps.Geocoder();	
	geocoder.geocode({'address': addressVal}, function(results, status) {
		if (status === 'OK') {
			
			// Read latitude and long from results.
			var myResult = results[0].geometry.location;
			var stringRes = JSON.stringify(myResult);
			var objRes = JSON.parse(stringRes);

			// Create an asynch request sending lat and long to /locationSearch
			var req = new XMLHttpRequest();
			var payload ={lat:null, lng:null};

			payload.lat = objRes.lat;
			payload.lng = objRes.lng;

			req.open("POST", "/locationSearch", true);
			req.setRequestHeader("Content-Type", "application/json");

			req.addEventListener('load', function(){
				if(req.status >= 200 && req.status < 400){

					// Response contains event names and information
					var response = JSON.parse(req.responseText);
	
					// JQuery to manipulate home dom to replace elements with a
					// List of returned events.
					$("#homePageText").after('<header id="searchHeader"></header>');
					$('#navMain').clone().appendTo('#searchHeader');
					$("#homePageText").remove();
					$('#searchContainer').append('<h1>Event Search Results</h1>');
					$('#searchContainer').append('<ul class="list-group" id="eventList"></ul>');

					// Read events from response JSON object.
					var count = 0;
					for (var object in response) {
						var data = response[object];

						for (var key in data) {

							// Create new li element
							$('#eventList').append('<li class="list-group-item" id="list'+ count +'"></li>');
						
							// Add event to li element
							var stringVal = JSON.stringify(data[key]);
							var dataVal = JSON.parse(stringVal);
							$("#list" + count + ":last-child").append(dataVal.eventname + "<br />" + dataVal.eventdescription);
							count++;
						}
					}
				} else {
					console.log("Error in network request: " + req.statusText);
				}});

			req.send(JSON.stringify(payload));

		} else {
			alert("Error in geocode lookup" + status);
		}
	});	
});

// Check that API key has loaded successfully 
function initSearch() {
	console.log("searchReady");
}





