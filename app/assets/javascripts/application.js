// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

$(function() {
  $('#back a').on('click',function(event){
    $('body, html'),animate({
      scrollTop:0
    }, 800);
    event.preventDefault();
    });
  });

  $(function(){
    $('img').okzoom({
      width: 200,
      height: 200,
      round: true,
      background: "#fff",
      backgroundRepeat: "repeat",
      shadow: "0 0 5px #000",
      border: "1px solid black"
    });
 });

 $(window).scroll(function (){
  $(".js-markerScrollAnimation").each(function(){
    var position = $(this).offset().top; //ページの一番上から要素までの距離を取得
    var scroll = $(window).scrollTop(); //スクロールの位置を取得
    var windowHeight = $(window).height(); //ウインドウの高さを取得
    if (scroll > position - windowHeight){ //スクロール位置が要素の位置を過ぎたとき
      $(this).addClass('is-active'); //クラス「active」を与える
    }
  });
});