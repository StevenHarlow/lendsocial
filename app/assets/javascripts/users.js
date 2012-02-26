$(function(){
  $('.user_show .tabs a[data-toggle="tab"]').on('show', function(e) {
    var id = $('#new_message').attr('data-id');
    var action = $(e.target).attr('href').substr(1);
    $.get('/users/' + id + '/' + action, function(data) {
      $('#' + action + ' .content').html(data);
    });
  });
  
  $('.user_show .tabs a:first').tab('show');
  
  $(this)
    .on('ajax:success', '.user_show #new_message', function(event, xhr, status) {
      $('#message_text').val(null);
      $('#comments > .content').html(xhr);
    })
    .on('ajax:beforeSend', '#user_follow a.btn', function() {
      $(this).addClass('btn-disabled');
    })
    .on('ajax:complete', '#user_follow a.btn', function(event, xhr, status) {
      $(this).removeClass('btn-disabled');
      if (status != 'error' || xhr.responseText != '') {
        $(this).parent().html(xhr.responseText);
        var id = $(this).attr('data-id');
        $.get('/users/' + id + '/latest_followers', function(data) {
          $('#user_followers').html(data);
        });
      }
  });
});