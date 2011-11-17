// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
    
    $("#follow").live( "click", function() {
       
       $.post( '/profiles/follow', $("#follow_form").serialize(), function( data ){ 
          $("#follow_container").html( data );
        });
        
    });
    
    $("#following").live( "click", function() {
        
        $.ajax({
            url: '/profiles/unfollow',
            data:  $("#follow_form").serialize(),
            type: 'DELETE',
            success: function(data) {
               $("#follow_container").html( data );
            }
        });
    });
    
    $("#following").live( "mouseover", function() {
        
        $(this).html( "Unfollow" );
        $(this).removeClass( "success" );
        $(this).addClass( "danger" );
    
    });
    
    $("#following").live( "mouseout", function() {

          $(this).html( "Following" );
          $(this).removeClass( "danger" );
          $(this).addClass( "success" );

    });
});