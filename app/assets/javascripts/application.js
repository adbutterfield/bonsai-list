//= require jquery
//= require jquery_ujs
//= require foundation
//= require sticky-kit
//= require jquery_cookie
//= require_tree .

$(function(){

  $(document).foundation();

  $("#marketplace-nav").stick_in_parent({offset_top: 40});

  $(window).on("load", function () {
    var footer = $("#footer");
    var pos = footer.position();
    var height = $(window).height();
    height = height - pos.top;
    height = height - footer.height();
    if (height > 0) {
      footer.css({
        'margin-top': height + 'px'
      });
    }
  });

  if ($.cookie('location')){
    console.log("Cookie set");
  } else {
    (function getLocation() {
      if (navigator.geolocation) {
        // $( "body" ).addClass( "opaque" );
        navigator.geolocation.getCurrentPosition(showPosition);
      }
    })();
  };

  function showPosition(position) {
    $.cookie('location', JSON.stringify({ latitude: position.coords.latitude, longitude: position.coords.longitude }) );
    // $( "body" ).removeClass( "opaque" );
    location.reload();
  }
});
