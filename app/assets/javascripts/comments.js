$(function(){
  $(this)
    .on('ajax:beforeSend', '.status_comments form', function() {
      $(this).find('button, textarea').attr('disabled', 'disabled');
    })
    .on('ajax:complete', '.status_comments form', function() {
      $(this).find('button, textarea').attr('disabled', null).end();
      closeErrors($(this));
    })
    .on('ajax:success', '.status_comments form', function(event, xhr, status) {
      $(this).find('textarea').val(null);
      $(this).parents('.status_comments').find('.comments_list').html(xhr);
    })
    .on('ajax:error', '.status_comments form', function(event, xhr, status) {
      console.log(xhr.responseText);
  });
});

toggleComments = function(id) {
  $('#comments_' + id).toggle();
};