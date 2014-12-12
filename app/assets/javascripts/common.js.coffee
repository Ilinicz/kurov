$ ->

  $("nav.navbarsa").autoHidingNavbar
    animationDuration: 500
    hideOffset: 10;

  $.srSmoothscroll
    step: 55
    speed: 300
    ease: "linear"

  $("a[href=\"" + @location.pathname + "\"]").parent().addClass "active"
  


  window.setTimeout (->
    $(".alert").fadeTo(3000, 0).slideDown 500, ->
      $(this).remove()
      return

    return
  ), 1000




