$ ->
  $('[data-toggle~="tooltip"]').tooltipster(position: 'bottom', delay: 150)

  $('.awning').on('click', '.search-indicator', (event)->
    event.preventDefault()
    $('.awning .search-indicator').hide()
    $('.awning .search-form-wrapper').show()
    $('.awning .search-form .query').focus()
  ).on('focusout', '.search-form .query', (event)->
    $('.awning .search-form-wrapper').hide()
    $('.awning .search-indicator').show()
  )
