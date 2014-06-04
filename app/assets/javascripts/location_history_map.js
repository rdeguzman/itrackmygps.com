var map, markers_bounds, markers = [];

function initMap(){
  var myLatlng = new google.maps.LatLng(0,0);

  var mapOptions = {
    center: myLatlng,
    zoom: 10
  };

  map = new google.maps.Map(document.getElementById('mapdiv'), mapOptions);
  markers_bounds = new google.maps.LatLngBounds();
}

function fitAllMarkersOnMap(){
  for(var i = 0; i < markers.length; i++){
    var pos = markers[i].getPosition();
    markers_bounds.extend(pos);
    map.fitBounds(markers_bounds);
  }
}

function createMarkers(data){

  for(var i = 0; i < data.length; i++){
    var location = data[i];

    var latitude = location["gps_latitude"];
    var longitude = location["gps_longitude"];

    var latlng = new google.maps.LatLng(latitude,longitude);
    var heading = location["gps_heading"];
    var azimuth = heading + 180;

    var speed = location["gps_speed"];
    var provider = location["provider"];

    var unix_timestamp = location["gps_timestamp"];
    var date = new Date(unix_timestamp*1);
    var formattedTime = date.toLocaleString();

    var title = formattedTime + " " +  speed + " kph";

    if(provider == "gps"){
      var icon = {
        strokeColor: 'yellow',
        strokeWeight: 1,
        fillColor: 'green',
        fillOpacity: 1
      };

      if(speed > 0) {
        icon.path = google.maps.SymbolPath.BACKWARD_CLOSED_ARROW;
        icon.scale = 4;
        icon.rotation = azimuth;
      }
      else {
        icon.path = google.maps.SymbolPath.CIRCLE;
        icon.scale = 6;
      }
    }
    else {
      var icon = {
        path: google.maps.SymbolPath.CIRCLE,
        strokeColor: 'white',
        strokeWeight: 1,
        fillColor: 'red',
        fillOpacity: 1,
        scale: 6
      };
    }

    var marker = new google.maps.Marker({
      position: latlng,
      title: title,
      icon: icon,
      map: map
    });

    markers_bounds.extend(latlng);
    map.fitBounds(markers_bounds);
  }

}