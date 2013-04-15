$ ->
  $('input.datepicker').each (i) ->
    unless(Modernizr.touch && Modernizr.inputtypes.date)
      $origDate = $(this)

      isoDate = $origDate.val()
      realDate = $.datepicker.parseDate($.datepicker.ISO_8601, isoDate)
      americanDate = $.datepicker.formatDate('mm/dd/yy', realDate)

      $datepicker = $origDate.clone().attr({type: 'text', value: americanDate})
      $origDate.replaceWith($datepicker)

      $altField = $('<input type="hidden">').attr({name: $datepicker.attr('name'), value: isoDate})
      $datepicker.after($altField)

      $datepicker.datepicker(
        altFormat: $.datepicker.ISO_8601
        dateFormat: 'mm/dd/yy'
        altField: $altField
        nextText: ''
        prevText: ''
        changeMonth: true
        changeYear: true
      )
      $datepicker.siblings('.add-on').click ->
        $datepicker.datepicker('show')
