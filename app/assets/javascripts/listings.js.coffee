# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(document).on 'change', '#categories_radio', (evt) ->
    $.ajax 'set_subcategories',
      type: 'GET'
      dataType: 'script'
      data: {
        category_id: $('input[name="listing[category_id]"]:checked').val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic subcategory select OK!")