$(function(){
  $('.business_show .tabs a[data-toggle="tab"]').on('show', function(e) {
    var id = $('#new_message').attr('data-id');
    var action = $(e.target).attr('href').substr(1);
    $.get('/businesses/' + id + '/' + action, function(data) {
      $('#' + action + ' .content').html(data);
    });
  });
  
  $('.business_show .tabs a:first').tab('show');
  
  $(this)
    .on('click', '#business_connect_button', function(event) {
      event.preventDefault();
      $('#request_modal').modal('show');
    })
    .on('ajax:complete', '#cancel_business_connection', function(event, xhr, status) {
      $('#business_connect').html(xhr.responseText);
    })
    .on('click', '#business_send_request', function(event) {
      event.preventDefault();
      var form = $(this).parents('.modal').find('form');
      $.post(form.attr('action'), form.serialize(), function(response) {
        $('#request_modal').modal('hide');
        $('#business_connect').html(response);
      });
    })
    .on('ajax:success', '.business_show #new_message', function(event, xhr, status) {
      $('#message_text').val(null);
      $('#comments > .content').html(xhr);
    })
    .on('ajax:beforeSend', '#business_follow a.btn', function() {
      $(this).addClass('btn-disabled');
    })
    .on('ajax:complete', '#business_follow a.btn', function(event, xhr, status) {
      $(this).removeClass('btn-disabled');
      if (status != 'error' || xhr.responseText != '') {
        $(this).parent().html(xhr.responseText);
        var id = $(this).attr('data-id');
        $.get('/businesses/' + id + '/latest_followers', function(data) {
          $('#business_followers').html(data);
        });
      }
  });
});