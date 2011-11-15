// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
    
    $("#follow").bind( "click", function() {
       
       $.post( 'follow', $("#follow_form").serialize(), function( data ){ 
          $("#follow_container").html( data );
        });
        
    });
});