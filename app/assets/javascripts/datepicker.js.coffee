$ ->
  $('input.datepicker').each (i) ->
    unless(Modernizr.touch && Modernizr.inputtypes.date)
      $origDate = $(this)
      $datepicker = $origDate.clone().attr({type: 'text'})
      $origDate.replaceWith($datepicker)

      $altField = $('<input type="hidden">').attr({name: $datepicker.attr('name')})
      $datepicker.after($altField)

      $datepicker.datepicker(
        altFormat: 'yy-mm-dd'
        dateFormat: 'mm/dd/yy'
        altField: $altField
        nextText: ''
        prevText: ''
        changeMonth: true
        changeYear: true
      )
      $datepicker.siblings('.add-on').click ->
        $datepicker.datepicker('show')
