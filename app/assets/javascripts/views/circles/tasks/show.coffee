ready = ->
  initComments();
  initSourcingOptionsModal();

initComments = ->
  $('.show_all_comments').on('click', showComments)

initSourcingOptionsModal = -> 
  # FIXME adapt
  # $(document).on('change', '#new_volunteer_id', assignVolunteer)

  # The modal is initialized via JS instead of the .remodal class since the latter
  # didn't work when loading the page with turbolinks
  modalSelector = "[data-remodal-id=sourcing-options-modal]"
  $(modalSelector).remodal();
  
  # FIXME it'd be better to load this on the 'opening' event (or even on page load)
  # 1) on page load didnt init correctly, ") opening didn't init correctly when displaying the modal 
  # with "hashTracking" (http://.../tasks/169#sourcing-options-modal)
  $(document).on('opened', modalSelector, -> 
    # select2 didn't init correctly in the dom ready callback; probably a issue with being in the modal.
    selector = $('#new_volunteer_id')
    options = {
      placeholder: "by name", 
      maximumSelectionLength: selector.data('max-selection-length'),
      language: I18n.locale
    }
    selector.select2(options)
  )


showComments = ->
  elem = $('.task-comments')
  return if elem.hasClass('loading')
  elem.addClass 'loading'
  $.ajax(
    url: elem.data('url')
    success: (result) =>
      elem.removeClass 'loading'
      elem.html(result)
    error: (error, response) =>
      elem.removeClass('loading')
  )

# assignVolunteer = ->
#   form = $(this).closest('form')
#   $.ajax({
#     url:  form.attr('action'),
#     method: form.attr('method'),
#     data: form.serialize(),
#     success: (result) => 
#       widget = $(this).closest('.volunteers');
#       widget.html(result)
#   })


$(document).on 'ready', ready
$(document).on 'page:load', ready
