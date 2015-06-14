$(document).ready(function(){
	function copy_protect(){
		$('body').contextmenu(function(){
			return false;
		})
		$('body').mousedown(function(e){
			var localname=e.target.localName.toLowerCase();
			if(localname!="input" && localname!="textarea" )
			{
				return false;
			}
		})
	}
	copy_protect();
	
	//Get Filename
	function filename()
	{
	    var url = window.location.pathname;
		var filename = url.substring(url.lastIndexOf('/')+1);
		return filename.substr(0, filename.lastIndexOf('.'));
    }
	//Get Absolute Path
	function getAbsolutePath() {
    var loc = window.location;
    var pathName = loc.pathname.substring(0, loc.pathname.lastIndexOf('/') + 1);
    return loc.href.substring(0, loc.href.length - ((loc.pathname + loc.search + loc.hash).length - pathName.length));
    }
  	/* Red Selection */
	$('.int_pain_area_wrp .int_pain_area_bottom img').click(function(e){
		var parent_offset=$(this).parent().offset();
		curs_x=e.pageX-10-parent_offset.left,
		curs_y=e.pageY+30-parent_offset.top;
		var img = $('<img />').attr({ 'src':getAbsolutePath()+'/img/red_X.png', 'title': '', 'alt':'' }).offset({'top':curs_y,'left':curs_x}).css({'position':'absolute','width':20});
		$(this).parent().append(img);
	})  
	
	/*Tooltip Drag & Drop*/ 
	$("table.tooltip span").draggable({helper:'clone',revert: 'invalid',zIndex: 2700});
	$("#droppable img").each(function()
	{
		$(this).droppable({
		tolerance: 'fit',
		drop: function(event,ui) { 
		var helper_y=ui.offset.top, helper_x=ui.offset.left;
		$helper=ui.helper.clone();
		$("#droppable").append($helper);
		$helper.offset({'top':helper_y,'left':helper_x});
		}
		});
	});
	
	/* Slider */
	$( "#int_slider-vertical" ).slider({
	orientation: "vertical",
	range: "min",
	min: 0,
	max: 100,
	value: 0, slide: function( event, ui ) {
		$( "#amount" ).text( ui.value );
	}
	});	
	$( "#amount" ).text( $( "#int_slider-vertical" ).slider( "value" ) );
	
	/*Display Input if yes*/
    function display_input_if_yes(selector){
		var val=$(selector).val();
		if(val == 'yes'){
			$(selector).parents('td').next().next().find('input').show();
		}else if(val == 'no'){
			$(selector).parents('td').next().find('input').hide().val('');
		}
	
	}
	
	$('input.int_past_health_his').click(function(){
		display_input_if_yes(this);
	})
	$('input.int_past_health_his:checked').each(function(i,elem){
		display_input_if_yes('input.int_past_health_his:checked:eq('+i+')');
	})
	
	/*Marinal*/
	$('.int_marial_st td').click(function(){
		$(this).parents('.int_marial_st').find('.selected').removeClass('selected');
		$(this).addClass("selected");
	})
		
   /*Change HTML to adapt PDF Converter*/
   function adapt_to_pdf()
   {
	   $('input[type="checkbox"],input[type="radio"]').each(
			function(){
				var is_checked = $(this).is(':checked');
				if(is_checked){
					$(this).attr('checked','checked');
				}else{
					$(this).removeAttr('checked');
				}			
		})		
		$('input[type="text"],textarea').each(function(){
			var val=$(this).val();
			$(this).attr('value',val);
			$(this).html(val);
		})
	}
	
    /* Generate PDF */

    $(".submit").click(function(e){	
			e.preventDefault();
			//$('#headerFullWrap').hide();
			adapt_to_pdf();
			data=
			   {
			    html:$("body").html(),
			    filename:filename(),
			   }
				$('#loading').show();
				$(".int_submit_block a").remove();
				$.ajax({
					url: "pdf_generator.php",
					dataType: "json",
					type: "POST",
					data: data,
                    success: function(msg)
					 {  
						$('#loading').hide();
                       var url=msg.response;
					   //var a_selec=$('<a>').attr('href',getAbsolutePath()+'download.php?file='+url).text('Download PDF');
					   var a_selec=$('<a>').attr('href',getAbsolutePath()+url).text('Download PDF');
					   $('.int_submit_block').append(a_selec);
					  //$('#headerFullWrap').fadeIn(300);
					 },	
					error:function (xhr, ajaxOptions, thrownError){
						$('#loading').hide();
						alert('An error has occured  !');
						//$('#headerFullWrap').fadeIn(300);
					} 					 
			   });
	})
	
});