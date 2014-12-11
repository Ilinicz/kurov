ready = ->

  $("nav.navbar-fixed-top").autoHidingNavbar
    animationDuration: 500

  window.setTimeout (->
    $(".alert").fadeTo(3000, 0).slideDown 500, ->
      $(this).remove()
      return

    return
  ), 1000

$(document).ready(ready)
$(document).on('page:change', ready)