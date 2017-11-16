

document.getElementById("searchSubmit").addEventListener('click', function(event){
	event.preventDefault();
	
	var addressVal = document.getElementById('userAddress').value;

	
	var geocoder = new google.maps.Geocoder();

	
	geocoder.geocode({'address': addressVal}, function(results, status) {
		if (status === 'OK') {
			
			var myResult = results[0].geometry.location;
			var stringRes = JSON.stringify(myResult);
			var objRes = JSON.parse(stringRes);

			var req = new XMLHttpRequest();
			var payload ={lat:null, lng:null};

			payload.lat = objRes.lat;
			payload.lng = objRes.lng;

			req.open("POST", "/locationSearch", true);
			req.setRequestHeader("Content-Type", "application/json");

			req.addEventListener('load', function(){
				if(req.status >= 200 && req.status < 400){
					var response = JSON.parse(req.responseText);
	

					$("#homePageText").after('<header id="searchHeader"></header>');
					$('#navMain').clone().appendTo('#searchHeader');
					$("#homePageText").remove();
					$('#searchContainer').append('<h1>Event Search Results</h1>');
					$('#searchContainer').append('<ul class="list-group" id="eventList"></ul>');

					var count = 0;
					for (var object in response) {
						var data = response[object];

						for (var key in data) {
							
							$('#eventList').append('<li class="list-group-item" id="list'+ count +'"></li>');
						
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


function initSearch() {
	console.log("searchReady");
}





