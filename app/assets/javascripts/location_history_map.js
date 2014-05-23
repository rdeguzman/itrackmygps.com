var map, marker_bounds, markers = [];

function initMap(){
  var myLatlng = new google.maps.LatLng(0,0);

  var mapOptions = {
    center: myLatlng,
    zoom: 10
  };

  map = new google.maps.Map(document.getElementById('mapdiv'), mapOptions);
  marker_bounds = new google.maps.LatLngBounds();
}

function fitAllMarkersOnMap(){
  for(var i = 0; i < markers.length; i++){
    var pos = markers[i].getPosition();
    markers_bounds.extend(pos);
    map.fitBounds(markers_bounds);
  }
}