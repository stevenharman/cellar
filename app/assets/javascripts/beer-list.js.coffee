$ ->
  $('.beer-list').on('click', '.beer-list-beer', (event)->
    $target = $(event.target)
    return true if $target.is('a,:input')

    $beer = $(this)
    $beer.find('.beer-drawer').slideToggle()
    $beer.toggleClass('beer-drawer-open')
  )
