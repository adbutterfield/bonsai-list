// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require listings
//= require marketplace
//= require jquery_cookie
//= require_tree .

$(function(){

  $(document).foundation();

  if ($.cookie('location')){
    console.log("Cookie set");
  } else {
    (function getLocation() {
      if (navigator.geolocation) {
        $( "body" ).addClass( "opaque" )
        navigator.geolocation.getCurrentPosition(showPosition);
      }
    })();
  };

  function showPosition(position) {
    $.cookie('location', [position.coords.latitude, position.coords.longitude] );
    $( "body" ).removeClass( "opaque" )
    location.reload();
  }

});
