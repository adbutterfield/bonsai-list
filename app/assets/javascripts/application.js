//= require jquery
//= require jquery_ujs
//= require foundation
//= require marketplace
//= require sticky_scroll
//= require_tree .

$(function(){

  $(document).foundation();
  // var barHeight = ($( window ).height() - 85);
  // var breakPoint =  $( document ).height() - $( window ).height() - 85
  // $("#mobile-icon-bar").sticky({ topSpacing: barHeight });

  // $( document ).scroll(function (){
  //   if ( $( document ).scrollTop() >= breakPoint ){
  //     barHeight = $( window ).height() - 132 - ($( document ).scrollTop() - breakPoint)
  //     $("#mobile-icon-bar").sticky({ topSpacing: barHeight });
  //   }
  //   // if
  // });

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

});
