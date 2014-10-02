//= require jquery
//= require jquery_ujs
//= require foundation
//= require marketplace
//= require_tree .

$(function(){

  $(document).foundation();

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
