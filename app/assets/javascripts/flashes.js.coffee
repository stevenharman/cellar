$ ->
  $('.flashes').on('click', '[data-dismiss="flash"]', (event)->
    $button = $(this)
    $flash = $button.closest('.flash')

    event.preventDefault()
    $flash.remove()
  )
