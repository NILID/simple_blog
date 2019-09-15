$ ->
  $(".slide-slider").lightSlider
    item: 1
    pager: false

  $('#containers').sortable
    handle: '.handle'
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))

  $().button('toggle')

  bLazy = new Blazy(selector: '.b-lazy')