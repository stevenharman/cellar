$ ->
  $('.no-touch [data-toggle~="tooltip"]').tooltip(placement: 'bottom')

  $('.awning').on('click', '.search-indicator', (event)->
    event.preventDefault()
    $(this).toggle()
    $('.awning .search-form-wrapper').toggle()
    $('.awning .search .query').focus()
  )
