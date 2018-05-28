ymaps.ready(init)
var geotestMap;

function performRequest(e) {
  var coords = e.get('coords');
  var data = { lat: coords[0].toPrecision(6), lon: coords[1].toPrecision(6), radius: getRadius() };
  $.ajax({
    type: "get",
    url: "/search",
    data: data,
    dataType: "html",
    timeout: 10000
  }).done( function(result) {
    geotestMap.geoObjects.removeAll();
    $( "#results" ).html(result);
    addCircleAndPlacemarks(data);
  }).error( function (error) {
    $( "#results" ).html(
      "<div class='alert alert-danger'>Something went wrong! Check internet connection."
    );
  });
}

function addCircle(center) {
  var circle = new ymaps.Circle([
    center, getRadius()
  ], { openBalloonOnClick: false }, {
    draggable: false,
    fillColor: "#DB709377",
    strokeColor: "#990066",
    strokeOpacity: 0.8,
    strokeWidth: 1
  });
  circle.events.add('click', performRequest)
  geotestMap.geoObjects.add(circle);
}

function addPlacemarks(center) {
  geotestMap.geoObjects.add(new ymaps.Placemark(
    center,
    { balloonContent: "Click!" },
    { iconColor: "#FF0000" })
  );
  $( ".invisible" ).each(function (_, element) {
    var coords = element.innerHTML.split(",").map(value => parseFloat(value))
    var baloonText = element.parentElement.innerText
    geotestMap.geoObjects.add(new ymaps.Placemark(coords, { balloonContent: baloonText }))
  });
}

function addCircleAndPlacemarks(point) {
  var center = [point.lat, point.lon]
  addCircle(center);
  addPlacemarks(center);
}

function init() {
  geotestMap = new ymaps.Map("map", {
    center: [55.753994, 37.622093],
    zoom: 13
  });
  geotestMap.events.add('click', performRequest);
}
