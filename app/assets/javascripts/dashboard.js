// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function(){
  $('.tabs a[data-toggle="tab"]').on('show', function(e) {
    var id = $(e.target).attr('href').substr(1);
    $.get('/dashboard/' + id, function(data) {
      $('#' + id + ' .content').html(data);
    });
  });
  
  $('#new_message').validate({
    debug: true,
    rules: {
      "message[text]": {required: true, minlength: 8, maxlength: 255}
    },
    messages: {
      "message[text]": {
        "required": "Message text can't be blank",
        "minlength": "Message text is too short (minimum is {0} characters)",
        "maxlength": "Message text is too long (maxumum is {0} characters)"
      }
    },
    errorElement: "span",
    errorPlacement: function(error, element) {
      showError(error, element);
    },
    onkeyup: false
  });
  
  $('.tabs a:first').tab('show');
  
  $('.alert a.close').click(function(e) {
    e.preventDefault();
    closeErrors($(this).parents('form'));
  });

  $(this)
    .on('ajax:complete', '.pagination a[data-remote]', function(event, xhr, status) {
      $(this).parents('.content').html(xhr.responseText);
    })
    .on('ajax:beforeSend', '#new_message', function() {
      $(this).find('button, textarea').attr('disabled', 'disabled');
    })
    .on('ajax:complete', '#new_message', function() {
      $(this).find('button, textarea').attr('disabled', null).end();
      closeErrors($(this));
    })
    .on('ajax:success', '#new_message', function(event, xhr, status) {
      $('#message_text').val(null);
      $('#update_status > .content').html(xhr);
    })
    .on('ajax:error', '#new_message', function(event, xhr, status) {
      console.log(xhr.responseText);
  });
});

showError = function(error, element) {
  element.parent().addClass('error').end()
    .parents('form')
      .find('.alert').addClass('alert-error')
        .find('.message').html(error).end()
      .show();
};

closeErrors = function(form) {
  form
    .find('.control-group').removeClass('error').end()
    .find('.alert')
      .find('.message').html(null).end()
      .removeClass('alert-error').hide().end().end();
};