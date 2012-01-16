$(document).ready(function() {
    $( "#datepicker" ).datepicker({dateFormat: 'mm/dd/yy'});
    	
    $("#publish").live( "click", function() {
       
       $.post( '/loans/publish', $("#loan_form").serialize(), function( data ){ 
          $("#publish_container").html( data );
        });
        
    });
    
    $("#unpublish").live( "click", function() {
        
        $.ajax({
            url: '/loans/unpublish',
            data:  $("#loan_form").serialize(),
            type: 'DELETE',
            success: function(data) {
               $("#publish_container").html( data );
            }
        });
    });
    
    $("#publish").live( "mouseover", function() {
        
        $(this).html( "Publish" );
        $(this).removeClass( "success" );
        $(this).addClass( "danger" );
    
    });
    
    $("#publish").live( "mouseout", function() {

          $(this).html( "Unpublished" );
          $(this).removeClass( "danger" );
          $(this).addClass( "success" );

    });
    
    $("#unpublish").live( "mouseover", function() {
        
        $(this).html( "Unpublish" );
        $(this).removeClass( "success" );
        $(this).addClass( "danger" );
    
    });
    
    $("#unpublish").live( "mouseout", function() {

          $(this).html( "Published" );
          $(this).removeClass( "danger" );
          $(this).addClass( "success" );

    });
});