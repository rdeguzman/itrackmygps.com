var map, devices_bounds;
var devices = [];
var socket_url = '';

function initSocketURL(url){
  socket_url = url;
}

function initMap(){
  var myLatlng = new google.maps.LatLng(0,0);

  var mapOptions = {
    center: myLatlng,
    zoom: 10
  };

  map = new google.maps.Map(document.getElementById('mapdiv'), mapOptions);
  devices_bounds = new google.maps.LatLngBounds();
}

function getDevice(device_id, markers){
  var device = null;

  for(var i = 0; i < markers.length; i++){
    if(markers[i].device_id === device_id){
      device = markers[i];
      break;
    }
  }

  return device;
}

function processGPS(gps){
  var device = getDevice(gps.device_id, devices);
  if(device == null){
    device = createDevice(gps);
    devices.push(device);
  }
  else{
    moveDevice(device, gps);
  }
}

function createDevice(gps){
  var pos = getLatLngFromString(gps);
  var image = 'marker.png';
  var marker = new google.maps.Marker({
    position: pos,
    map: map,
    icon:image
  });

  marker.set("device_id", gps.device_id);
  adjustMapBounds(pos);

  return marker;
}

function moveDevice(device, gps){
  var pos = getLatLngFromString(gps);
  device.setPosition(pos);
  adjustMapBounds(pos);
}

function adjustMapBounds(pos){
  // need to wait for the tiles to load before we can get the map bounds
  var currentBounds = map.getBounds();

  if(typeof(currentBounds) != 'undefined' &&  currentBounds.contains(pos) == false){
    devices_bounds.extend(pos);
    map.fitBounds(devices_bounds);
  }
}

function fitAllDevicesOnMap(){
  for(var i = 0; i < devices.length; i++){
    var pos = devices[i].getPosition();
    devices_bounds.extend(pos);
    map.fitBounds(devices_bounds);
  }
}

function getLatLngFromString(obj){
  var lat = parseFloat(obj.gps_latitude), lon = parseFloat(obj.gps_longitude);
  return new google.maps.LatLng(lat, lon);
}

function formatGPSHTMLOutput(gps){
  var unix_timestamp = gps.gps_timestamp;
  var date = new Date(unix_timestamp*1);
  var formattedTime = date.toLocaleString();

  var s =  formattedTime + ' ';
  s += '(' + gps.gps_latitude + ',' + gps.gps_longitude + ')';
  return s;
}

function fetchLastKnownDeviceLocation(data){
  for(var i=0;i < data.length;i++){
    var gps = data[i];

    // check for gps_latitude and gps_longitude or we get a call stack size error
    if( typeof gps.latitude !== 'undefined'  && typeof gps.longitude !== 'undefined'){

      if(gps.gps_latitude != 0 && gps.gps_longitude != 0){
        device = createDevice(data[i]);
        devices.push(device);

        $('#messages').html(formatGPSHTMLOutput(gps));
      }

    }

  }

  fitAllDevicesOnMap();
}

function initSocket(user_id, data){
  var socket = io.connect(socket_url);

  socket.on('connect', function () {
      // Identify this socket with the user_id
    socket.emit('setUserId', user_id);

    for(var i=0;i < data.length;i++){
      socket.emit('addDevice', data[i].uuid);
    }

  });

  socket.on('message', function(d){
    var parsedObj = JSON.parse(d);
    if(parsedObj.type === 'gps'){
      var gps = parsedObj.data;
      $('#messages').html(formatGPSHTMLOutput(gps));
      processGPS(gps);
    }
  });
}

function fetchDevices(user_id, access_token){
  var url = '/api/devices.json?user_id=' + user_id + '&access_token=' + access_token;
  var allowed_devices = [];
  $.get(url, function( data ) {

    if(data.valid){
      allowed_devices = data.devices;
      fetchLastKnownDeviceLocation(allowed_devices);
      initSocket(user_id, allowed_devices);
    }
  });
}