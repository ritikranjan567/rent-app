/* ----------------Asset maps display--------------------*/
var coordinates = $("#coordinates").text();
var lng = Number(coordinates.split(",")[1]);
var lat = Number(coordinates.split(",")[0]);

/* ------------creating a map-------- */
mapboxgl.accessToken = 'pk.eyJ1IjoicnJiNTY3IiwiYSI6ImNrOHpvZXh6NjFrNjIzam83eWlneHpnOWIifQ.mPbSQGbNz9jHBWL0O9-q1A';
var assetMap = new mapboxgl.Map({
  container: "asset_location_map",
  center: [lng, lat],
  style: 'mapbox://styles/mapbox/outdoors-v11',
  zoom: 16
});

/* -------------marker properties -----------------------*/
var geojson = {
  type: "FeatureCollection",
  features: [{
    type: "Feature",
    geometry: {
      type: "Point",
      coordinates: [lng, lat]
    },
    properties: {
      title: "Manoram Kutira",
      description: "Demo description"
    }
  }]
};

/* -----------------Putting marker on the map --------------------*/
geojson.features.forEach(function(marker) {
  var el = document.createElement('div');
  el.className = 'marker';
  new mapboxgl.Marker(el)
    .setLngLat(marker.geometry.coordinates)
    .setPopup(new mapboxgl.Popup({offset: 25})
      .setHTML('<h3>'+ marker.properties.title + '<h3>'))
    .addTo(assetMap);
});

/* ------------------------------------------------------------------- */
