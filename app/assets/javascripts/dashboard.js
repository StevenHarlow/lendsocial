// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
  $('.tabs a[data-toggle="tab"]').on('show', function(e) {
    var id = $(e.target).attr('href').substr(1);
    $.get('/dashboard/' + id, function(data) {
      $('#' + id + ' .content').html(data);
    });
  });
  
  $('.tabs a:first').tab('show');

  $(this)
    .on('ajax:complete', '.pagination a[data-remote]', function(event, xhr, status) {
      $(this).parents('.content').html(xhr.responseText);
    })
    .on('ajax:beforeSend', '#new_message', function(data) {
      $(this).find('button, textarea').attr('disabled', 'disabled');
    })
    .on('ajax:complete', '#new_message', function(data) {
      $(this).find('button, textarea').attr('disabled', null);
    })
    .on('ajax:success', '#new_message', function(event, xhr, status) {
      $('#update_status > .content').html(xhr);
    })
    .on('ajax:error', '#new_message', function(data) {
      console.log(data);
  });
});