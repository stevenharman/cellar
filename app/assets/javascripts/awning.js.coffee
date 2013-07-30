$ ->
  $('[data-toggle~="tooltip"]').tooltipster(position: 'bottom', delay: 150)

  $('.awning').on('click', '.awning-search-indicator', (event)->
    event.preventDefault()
    $awning = $(event.delegateTarget)
    $awning.addClass('is-search-active')
    $awning.find('.search-form .query').focus()
  ).on('focusout', '.search-form .query', (event)->
    $awning = $(event.delegateTarget)
    $awning.removeClass('is-search-active')
  )
