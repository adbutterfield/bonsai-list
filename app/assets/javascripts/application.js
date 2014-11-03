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
        navigator.geolocation.getCurrentPosition(showPosition);
      }
    })();
  };

  function showPosition(position) {
    if (position.coords) {
      $.ajax({
        url: 'set_location',
        type: 'GET',
        dataType: 'script',
        data: { coordinates: { latitude: position.coords.latitude, longitude: position.coords.longitude } },
        error: function(){
          console.log("AJAX Error:");
        },
        success: function(){
          console.log("Dynamic geolocation set OK!");
          $.cookie('location', 'set');
          $.ajax({
            url: 'marketplace/marketplace_ajax_sort',
            type: 'GET',
            dataType: 'script',
            data: { },
            error: function(){
              console.log("AJAX Error:");
            },
            success: function(){
              console.log("Listings set OK!");
            }
          });
        }
      });
    } else {
      showPosition(position)
    }
  }
});
