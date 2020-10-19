$(document).on('turbolinks:load', function(){
    $('.main-vs-zoom').okzoom({
      width: 200,
      height: 200,
      round: true,
      background: "#fff",
      backgroundRepeat: "repeat",
      shadow: "0 0 5px #000",
      border: "1px solid black"
    });
 });