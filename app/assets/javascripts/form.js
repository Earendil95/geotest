function recountRadius() {
  $( "#radius" )[0].value =
    $( "#measure" )[0].value === "m" || $( "#measure" )[0].value === "м" ?
      $( "#radius" )[0].value * 1000 : $( "#radius" )[0].value / 1000;
}

function getRadius() {
  return $( "#measure" )[0].value === "m" || $( "#measure" )[0].value === "м" ?
    parseFloat($( "#radius" )[0].value) : parseFloat($( "#radius" )[0].value) * 1000;
}

$( document ).ready(function () {
  $( "#measure" )[0].addEventListener("change", recountRadius);
})
