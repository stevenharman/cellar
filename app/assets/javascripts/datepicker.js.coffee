$ ->
  $('input.datepicker').each (i) ->
    $datepicker = $(this)
    $datepicker.datepicker(
      altFormat: 'yy-mm-dd'
      dateFormat: 'mm/dd/yy'
      altField: $datepicker.siblings('input:hidden')
      nextText: ''
      prevText: ''
    )
    $datepicker.siblings('.add-on').click ->
      $datepicker.datepicker('show')
