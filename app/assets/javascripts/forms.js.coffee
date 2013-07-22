$ ->
  $(document).on('keydown', 'form :input:not(:disabled)', (e)->
    if(e.keyCode == 13 && (e.metaKey || e.ctrlKey))
        $(this).parents('form').submit()
  )
