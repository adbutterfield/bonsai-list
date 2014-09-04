$(function(){
  $(document).on('change', '#categories_radio', function(event){
    $.ajax({
      url: 'set_subcategories',
      type: 'GET',
      dataType: 'script',
      data: {
        category_id: $('input[name="listing[category_id]"]:checked').val()
      }
    });
  });
});