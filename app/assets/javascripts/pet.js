var map = null,
    latLng = { lat: null, lng: null };

function initMap() {
  var mapDiv = document.getElementById('map');
  map = new google.maps.Map(mapDiv, {
    center: latLng,
    zoom: 13
  });
}


jQuery(document).ready(function($) {
  $('<script>', { src: 'https://maps.googleapis.com/maps/api/js?key=' + window.mapData.googleApiKey + '&callback=initMap' }).appendTo(document.body);
  $.getJSON(
    'https://maps.googleapis.com/maps/api/geocode/json',
    {
      key: window.mapData.googleApiKey,
      address: window.mapData.shelterAddress
    },
    function(data) {
      if (data.results && data.results.length > 0) {
        latLng = data.results[0].geometry.location;
        if (map != null) {
          map.panTo(latLng);
        }
      } else {
        $('#map').remove();
      }
    }
  );
});
