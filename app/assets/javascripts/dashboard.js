$(function(){
  $('.dashboard_index .tabs a[data-toggle="tab"]').on('show', function(e) {
    var action = $(e.target).attr('href').substr(1);
    $.get('/dashboard/' + action, function(data) {
      $('#' + action + ' .content').html(data);
      if (action == 'notifications') {
        $.get('/dashboard/notifications_update', function(event, xhr, status) {
          updateNotificationsCounter();
        });
      }
    });
  });
  
  $('#new_message').validate({
    debug: true,
    rules: {
      "message[text]": {required: true, maxlength: 2000}
    },
    messages: {
      "message[text]": {
        "required": "Message text can't be blank",
        "maxlength": "Message text is too long (maxumum is {0} characters)"
      }
    },
    errorElement: "span",
    errorPlacement: function(error, element) {
      showError(error, element);
    },
    onkeyup: false
  });
  
  $('.dashboard_index .tabs a:first').tab('show');
  
  $('.alert a.close').click(function(e) {
    e.preventDefault();
    closeErrors($(this).parents('form'));
  });

  $(this)
    .on('ajax:success', '.notifications_list a[data-remote]', function(event, xhr, status) {
      $('#notifications .content').html(xhr);
      updateNotificationsCounter();
    })
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
    .on('ajax:success', '.dashboard_index #new_message', function(event, xhr, status) {
      $('#message_text').val(null);
      $('#update_status > .content').html(xhr);
    })
    .on('ajax:error', '.dashboard_index #new_message', function(event, xhr, status) {
      console.log(xhr.responseText);
  });
});

updateNotificationsCounter = function() {
  $.get('/dashboard/notifications_counter', function(data) {
    $('#notifications_link').html(data);
  });
};

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