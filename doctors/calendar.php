<?php

// Make sure the file isn't accessed directly
defined('APPHP_EXEC') or die('Restricted Access');


if (!$objLogin->IsLoggedInAsDoctor() || !Modules::IsModuleInstalled('appointments')) {
	draw_title_bar(_DOCTOR);
	draw_message(str_replace('_ACCOUNT_', 'doctor', _MUST_BE_LOGGED));
	exit;
}
echo "<div id='showmessage'>" ;
// flash messages
if(!empty($msg)) {
	
	echo $msg;
	
}

echo "</div>";
// Start main content
/*draw_title_bar(
	prepare_breadcrumbs(array(_MY_ACCOUNT=>'',_MY_CALENDAR=>'',ucfirst($action)=>''))
);*/

?>

<div style="clear:both"></div>
<!--<link href="<?php echo APPHP_BASE; ?>js/jquery/cupertino/theme.css" rel="stylesheet" />
<!--<link rel="stylesheet" media="screen" type="text/css" href="http://code.jquery.com/ui/1.10.3/themes/cupertino/jquery-ui.css" />
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/themes/cupertino/jquery-ui.css" rel="stylesheet" type="text/css" media="screen" />-->

<link href="<?php echo APPHP_BASE; ?>js/fullcalendar/fullcalendar.css" rel="stylesheet" />
<link href="<?php echo APPHP_BASE; ?>js/fullcalendar/fullcalendar.print.css" rel="stylesheet" media="print" />
<link href="<?php echo APPHP_BASE; ?>js/fullcalendar/fullcalendar.print.css" rel="stylesheet" media="print" />
<link href="<?php echo APPHP_BASE; ?>templates/default/css/jquery.modal.css" rel="stylesheet" media="print" />
 <script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="<?php echo APPHP_BASE; ?>healthvault/validation/jquery.validate.js"></script>


<style type="text/css">
	
	.linkBoxes .s_wrapper {
		width: 969px;
		margin-left: 0;
		right:72px!important;
	}
	.linkBoxes{
		margin-left: 250px!important;
	    width: 1008px!important;

	}
	
	
	.timeoff { background-color: #CF805E; border-color: #BB4919; }
	.addAppoint {
		display: block; width: 120px; position: relative; top: -20px;
		text-decoration: none; text-align: center; font-size: 14px;background-color:#F97B2C;
		/*background-color: #9ccc6d;*/ border: 1px solid #E2600F; color: #fff;
	}
	.ui-accordion-content-active{
		height:auto!important;
	}
	#fancybox-wrap{
		position:absolute!important;		
	}
	#calendar2 .ui-widget-content:hover{
		cursor:pointer;
		border:1px solid #0066CC;
		
	}
	.footer{
		width:100%;
		padding-right:8px;
	}
	.footerMenu{
		padding-right:8px;
	}
	.reveal-modal{
		margin-left:-394px!important;
	}
	.fc-event-time, .fc-event-title{
		float:left;
	}
	.ui-dialog { z-index: 999999 !important ;}
	
</style>
<?php
$sql = "SELECT * FROM " . APPOINTMENT_TYPE. " where active='y' AND (docid like '$doctor_id,%' or docid like '%,$doctor_id' or docid = '$doctor_id' or docid like '%,$doctor_id,%' ) order by id asc";
$appointmenttypes = database_query($sql);
foreach($appointmenttypes  as $appointmenttype){
	?>
    <style type="text/css">
	.ap<?php echo $appointmenttype['id']?>{
		background-color:#<?php echo $appointmenttype['color']?>!important;
		border-color:#<?php echo $appointmenttype['color']?>!important;
	}
	</style>
	<?php
}
?>
<div class="">

	
	<div style="clear:both"></div>
    <?php 
	if(strtolower($_GET['doctorid'])!='all'){
	
	?>
    
<style type="text/css">
	.doctorLogin #content-right {
		margin-left: 0px;
		width: 1000px;
	}
	#content-right{ margin-top:-40px; }
	
	#wrap{
		width:1280px!important;
		margin-top:-20px;
		background:none;
		
	}
	.patientLogin #content-wrap, .doctorLogin #content-wrap{
		width:100%!important;
		margin-left:-8px;
	}
    </style>
	<div id="calendar"></div>
    <?php }else{
		$widthwrap = 0;

		foreach($doctors as $doctor){
			$widthwrap = $widthwrap + 500 ;
			?>
            <div style="width:500px;float:left">
            <h1><?php echo $doctor['first_name'].' '.$doctor['last_name'];?></h1><div style="clear:both"></div>
            <div id="fcalendar<?php echo $doctor['id'];?>" ></div>
            <div style="clear:both"></div>
            </div>
			<?php
			
		}
		?>
		<style  type="text/css">
		.doctorLogin #content-right {
		margin-left: 10px;
		width: <?php echo $widthwrap?>px!important;
		}
	
		#wrap{
			width:<?php echo  ($widthwrap+300)?>px!important;
			
		}
		.patientLogin #content-wrap, .doctorLogin #content-wrap{
		width:<?php echo  ($widthwrap+300)?>px!important;
		margin-left:-8px;
		}
		</style>
		<?php
	}
	?>
    
   		
		<?php
		$pageview = mysql_real_escape_string($_GET['pageview']);
        if($pageview == 'appointments'){
            $objAppointments = new Appointments();
            echo '<div class="pages_contents" >';
            $objAppointments->DrawViewMode();	
            echo '</div>';
		}	
        ?>

	<?php
		if($pageview == 'schedule'){	
		$objSchedules = new Schedules($doctor_id, 'me');
		if($mode == 'view'){		
		$objSchedules->DrawViewMode();	
		}else if($mode == 'add'){		
			$objSchedules->DrawAddMode();		
		}else if($mode == 'edit'){		
			$objSchedules->DrawEditMode($rid);		
		}else if($mode == 'details'){		
			$objSchedules->DrawDetailsMode($rid);		
		}
		}
		if($pageview == 'timeoff'){	
		$objTimeoffs = new Timeoffs($doctor_id, 'me');		
		if($mode == 'view'){		
			$objTimeoffs->DrawViewMode();	
		}else if($mode == 'add'){		
			$objTimeoffs->DrawAddMode();		
		}else if($mode == 'edit'){		
			$objTimeoffs->DrawEditMode($rid);		
		}else if($mode == 'details'){		
			$objTimeoffs->DrawDetailsMode($rid);		
		}
		}
	?>
    
    <?php
		if($pageview == 'reports'){	
	    $objAppointments = new Appointments();	
		echo '<div class="pages_contents2"  >';
		echo "Comming soon";
		echo '</div>';
		}
	?>
    <div style="display:none" >
	<div  id="s_editAppointModal" >
		<?php 
		$objAppointments = new Appointments();
		$objAppointments->DrawEditMode($rid);	?>	
    </div>
    </div>
   
	
</div>


<div style="display:none">
<div id="createEventModal" class="modal"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true">
    <div class="modal-header">       
        <h3 id="myModalLabel1">Create Appointment</h3>
    </div>
    <div class="modal-body">
    <form id="createAppointmentForm" class="form-horizontal">
        <div class="control-group">
            <label class="control-label" for="inputPatient">Patient:</label>
            <div class="controls">
            <select name="cpatient_id"  id="cpatient_id" required>
								<option value="">-- Select Patient --</option>
								<?php foreach ($patients AS $patient) : ?>
								<option value="<?php echo $patient['id']; ?>"><?php echo $patient['first_name'], ' ' , $patient['last_name']; ?></option>
								<?php endforeach; ?>
							</select>
              <!--  <input type="text" name="patientName" id="patientName" tyle="margin: 0 auto;" data-provide="typeahead" data-items="4" data-source="[&quot;Value 1&quot;,&quot;Value 2&quot;,&quot;Value 3&quot;]">-->
                  <input type="hidden" id="apptStartTime"/>
                  <input type="hidden" id="apptEndTime"/>
                  <input type="hidden" id="apptAllDay" />
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="when">When:</label>
            <div class="controls controls-row" id="when" style="margin-top:5px;">
            </div>
        </div>
</form>
</div>        
 <div class="modal-footer">
        <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
        <button type="submit" class="btn btn-primary" id="submitButton">Save</button>
    </div>
</div>
</div>

<!--<script type="text/javascript" src="http://code.jquery.com/ui/1.10.3/jquery-ui.min.js"></script>-->
 <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.js"></script>
<script src="<?php echo APPHP_BASE; ?>js/fullcalendar/fullcalendar.min.js"></script>

<script type="text/javascript">
	var doctorWeekends = <?php echo json_encode($doctorWeekends); ?>;


		
	$(document).ready(function() {
	alert('sdsdsd');
		var iframe = $('<iframe frameborder="0" height="100%" width="100%" marginwidth="0" marginheight="0" id="dialogframe" allowfullscreen></iframe>');
		var dialog = $("<div id='dialog' title='Find a Patient' style='width:600px;height:500px'></div>").append(iframe).appendTo("body").dialog({
			autoOpen: false,
			modal: true,
			resizable: false,
			width: 850,
			height: 500,
			close: function () {
				iframe.attr("src", "");
			}
		});
		$(".fancybox").fancybox({  'height' : 500, 'autoSize'         :   true , beforeShow: function(){
            $("html").css({'overflow-y':'visible'});
            },    });
		$("#appointDate").datepicker({
			dateFormat: "yy-mm-dd",
			constrainInput: true,
			minDate: 0,
			beforeShowDay: function(date) {
				showDay = true;
				showClass = 'available';
				weekDay = $.datepicker.formatDate('D', date);
				date = $.datepicker.formatDate('yy-mm-dd', date);
				$.each(doctorWeekends, function(idx, val) {
					console.log(val + ' ' + weekDay);
					if (val == weekDay) {
						showDay = false;
						showClass = 'unavailable';
					}
				});
				return [showDay, showClass];
			}
		});
		$("#startdate").datepicker({
			dateFormat: "yy-mm-dd",
			constrainInput: true,
			minDate: 0,
			beforeShowDay: function(date) {
				showDay = true;
				showClass = 'available';
				weekDay = $.datepicker.formatDate('D', date);
				date = $.datepicker.formatDate('yy-mm-dd', date);
				$.each(doctorWeekends, function(idx, val) {
					console.log(val + ' ' + weekDay);
					if (val == weekDay) {
						showDay = false;
						showClass = 'unavailable';
					}
				});
				return [showDay, showClass];
			}
		});
		$("#enddate").datepicker({
			dateFormat: "yy-mm-dd",
			constrainInput: true,
			minDate: 0,
			beforeShowDay: function(date) {
				showDay = true;
				showClass = 'available';
				weekDay = $.datepicker.formatDate('D', date);
				date = $.datepicker.formatDate('yy-mm-dd', date);
				$.each(doctorWeekends, function(idx, val) {
					console.log(val + ' ' + weekDay);
					if (val == weekDay) {
						showDay = false;
						showClass = 'unavailable';
					}
				});
				return [showDay, showClass];
			}
		});

		$("#appointDate").change(function() {
			$('#appointTimes').attr('disabled', 'disabled');
			$.ajax({
				url: '<?php echo  APPHP_BASE; ?>?doctor=calendar&ajax=true&date=' + $(this).val(),
				dataType: 'json',
				success: function(data) {

					$('#appointTimes').html(data.appointTimes);
					$('#appointTimes').removeAttr('disabled');
					$('#appointDuration').val(data.timeSlots);
				}
			});
		});

	<?php 
	if(strtolower($_GET['doctorid'])!='all'){
	?>

		var calElement = $('#calendar');
		var viewDisplayCount = 0;
		var calOptions = {
			
			defaultView: 'agendaDay',
			theme: true,			
			editable: true,
			selectable:true,
			selectHelper: true,
			firstDay:7,
			dayNamesShort:['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay'
			},
			slotMinutes: <?php echo $curTimeBlock['time_slots']; ?>,
			minTime: '<?php echo $curTimeBlock['time_from']; ?>',
			maxTime: '<?php echo $curTimeBlock['time_to']; ?>',
			events: '<?php echo APPHP_BASE; ?>?doctor=calendar&aptype=<?php echo $_GET['type'];?>&apaddress=<?php echo $_GET['address'];?>&apdoctorid=<?php echo $_GET['doctorid'];?>',
			eventClick: function(event, element) {
				var eventid = event.id.split('app-');

//				__mgDoPostBack('mdo_appointments1', 'edit',eventid[1]);
				jQuery.fancybox({
					href:"<?php echo APPHP_BASE?>doctor/addapppopup.php?mode=edit&id="+eventid[1],
					  'height' : 500, 'autoSize'         :   true , beforeShow: function(){
						$("html").css({'overflow-y':'visible'});
						}
				});
				//if (event.url) window.open(event.url);
				return false;
			},
			eventRender: function (event, element, view) {
				element.qtip({
					content: event.description,
					style: { name: 'cream','font-size': 11 }
				});
				if (view.name != "month") {
					if (!event.allDay) {
						//element.find(".fc-event-time")[0].css('display', 'none');
					}
				}
				
				element.addClass(event.class);
				
			},
			viewDisplay: function(view) {
				viewDisplayCount += 1;
			
				if (2 == viewDisplayCount) {
					calDate = calElement.fullCalendar('getDate');
					calDateStr = calDate.getFullYear() + '-' + (1+calDate.getMonth()) + '-' + calDate.getDate();
					window.location = '<?php echo APPHP_BASE; ?>?doctor=calendar&view=' + view.name + '&date=' + calDateStr;
					return;
				}
				//window.location('<?php echo APPHP_BASE; ?>?doctor=calendar&date=' + calElement.fullCalendar('formatDate', 'yyyy-MM-dd'));
			},
			//header and other values
			select: function(start, end, allDay) {
				
				  endtime = $.fullCalendar.formatDate(end,'h:mm tt');
				  starttime = $.fullCalendar.formatDate(start,'ddd, MMM d, h:mm tt');
				  var mywhen = starttime + ' - ' + endtime;
				  $('#createEventModal #apptStartTime').val(starttime);
				  $('#createEventModal #apptEndTime').val(end);
				  $('#createEventModal #apptAllDay').val(allDay);
				  $('#createEventModal #when').text(mywhen);				
				  $.fancybox({
		            type: 'inline',
	    		    content: '#createEventModal'
			    });
		}};
		
		<?php			
			if (!empty($_GET['view']) && empty($_GET['pageview'])) {
				echo "calOptions.defaultView = '" . htmlspecialchars($_GET['view']) . "';\n";
			}
			
			/*
			$sql = "SELECT * FROM " . TABLE_DOCTORS_ADDRESSES . " WHERE doctor_id = $doctor_id";
			$addresses = database_query($sql);
			$docAddresses = array();
			foreach ($addresses AS $address) {
				$docAddresses[] = $address['id'];
			}
			*/
		?>

		calOptions.year = <?php echo $year; ?>;
		calOptions.month = <?php echo $month-1; ?>;
		calOptions.date = <?php echo $day; ?>;				
		calElement.fullCalendar(calOptions);
		<?php 
		}else{
			foreach($doctors  as $doctor){
				?>
		var calElement = $('#fcalendar<?php echo $doctor['id'];?>');
		var viewDisplayCount = 0;
		var calOptions = {
			
			defaultView: 'agendaDay',
			theme: true,
			allDayDefault:false,
			editable: true,
			selectable:true,
			selectHelper: true,
			ignoreTimezone:true,
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay'
			},
			slotMinutes: <?php echo $curTimeBlock['time_slots']; ?>,
			minTime: '<?php echo $curTimeBlock['time_from']; ?>',
			maxTime: '<?php echo $curTimeBlock['time_to']; ?>',
			events: '<?php echo APPHP_BASE; ?>?doctor=calendar&aptype=<?php echo $_GET['type'];?>&apaddress=<?php echo $_GET['address'];?>&apdoctorid=<?php echo $doctor['id'];?>',
			eventClick: function(event, element) {
				var eventid = event.id.split('app-');

				//__mgDoPostBack('mdo_appointments1', 'edit',eventid[1]);
				jQuery.fancybox({
					href:"<?php echo APPHP_BASE?>doctor/addapppopup.php?mode=edit&id="+eventid[1],
					  'height' : 500, 'autoSize'         :   true , beforeShow: function(){
						$("html").css({'overflow-y':'visible'});
						}
				});

				//if (event.url) window.open(event.url);
				return false;
			},
			eventRender: function (event, element, view) {
				element.qtip({
					content: event.description,
					style: { name: 'cream','font-size': 11 }
				});
				if (view.name != "month") {
					if (!event.allDay) {
						//element.find(".fc-event-time")[0].css('display', 'none');
					}
				}
				
				element.addClass(event.class);
				
			},
			viewDisplay: function(view) {
				/*viewDisplayCount += 1;
				if (2 == viewDisplayCount) {
					calDate = calElement.fullCalendar('getDate');
					calDateStr = calDate.getFullYear() + '-' + (1+calDate.getMonth()) + '-' + calDate.getDate();
					window.location = '<?php echo APPHP_BASE; ?>?doctor=calendar&view=' + view.name + '&date=' + calDateStr;
					return;
				}*/
				//window.location('<?php echo APPHP_BASE; ?>?doctor=calendar&date=' + calElement.fullCalendar('formatDate', 'yyyy-MM-dd'));
			}
		
		};
	
		
		<?php			
			if (!empty($_GET['view']) && empty($_GET['pageview'])) {
				echo "calOptions.defaultView = '" . htmlspecialchars($_GET['view']) . "';\n";
			}
			
			/*
			$sql = "SELECT * FROM " . TABLE_DOCTORS_ADDRESSES . " WHERE doctor_id = $doctor_id";
			$addresses = database_query($sql);
			$docAddresses = array();
			foreach ($addresses AS $address) {
				$docAddresses[] = $address['id'];
			}
			*/
		?>

		calOptions.year = <?php echo $year; ?>;
		calOptions.month = <?php echo $month-1; ?>;
		calOptions.date = <?php echo $day; ?>;				
		calElement.fullCalendar(calOptions);
				<?php
			}
		}
	?>
	  $('#submitButton').bind('click', function(e){
		// We don't want this to act as a link so cancel the link action
		e.preventDefault();
	
		doSubmit();
	  });
	
	  function doSubmit(){
		$.fancybox.close();
		console.log($('#apptStartTime').val());
		console.log($('#apptEndTime').val());
		console.log($('#apptAllDay').val());
		$.ajax({
		type:"post",
		url:"index.php?provider=calendar&action=addapp&ajax=1",
		dataType:"html",
		data:{ cpatient_id: $('#cpatient_id').val(),apptStartTime: $('#apptStartTime').val(),apptEndTime: $('#apptEndTime').val() },
		success:function(data){		
			var data1 = data.split('&&&##&&&');
			$('#showmessage').html(data1[1]);
			$("#calendar").fullCalendar('renderEvent',
			{
				title: data1[0],
				start: new Date($('#apptStartTime').val()),
				end: new Date($('#apptEndTime').val())

			},
			true);	
		}
		});
			
			
	   }
	   <?PHP if(strtolower($_GET['doctorid'])!='all'){?>
		$('<span class="fc-button fc-button-appointmnts ui-state-default ui-corner-top" style="-moz-user-select: none; margin-bottom:0px;">Appointments</span>').insertBefore('.fc-button-month');
		$('<span class="fc-button fc-button-mysechdules ui-state-default ui-corner-top" style="-moz-user-select: none;">Office Schedules</span>').insertAfter('.fc-button-agendaDay');
		$('<span class="fc-button fc-button-timeoff ui-state-default ui-corner-top" style="-moz-user-select: none;">Timeoff</span>').insertAfter('.fc-button-mysechdules');
		$('<span class="fc-button fc-button-reports ui-state-default ui-corner-top" style="-moz-user-select: none;">Reports</span>').insertAfter('.fc-button-timeoff');
		$('.fc-button-month').addClass('ui-corner-top');
		$('.fc-button-agendaWeek').addClass('ui-corner-top');
		$('.fc-button-agendaDay').addClass('ui-corner-top');
		$('.fc-button-month').removeClass('ui-corner-left');
		$('.fc-button-agendaDay').removeClass('ui-corner-right');
		$('.fc-button-mysechdules').removeClass('ui-corner-right');
		$(".fc-button").click(function() {
			$(".fc-button").removeClass('ui-state-active');
		});

		$(".fc-button-appointmnts").click(function() {
			window.location='index.php?provider=calendar&pageview=appointments';
		});

		$(".fc-button-mysechdules").click(function() {
			window.location='index.php?provider=calendar&pageview=schedule';

		});
		$(".fc-button-timeoff").click(function() {
			window.location='index.php?provider=calendar&pageview=timeoff';

		});
		$(".fc-button-reports").click(function() {
			window.location='index.php?provider=calendar&pageview=reports';
		});
		
	//	$( "#aptabs" ).tabs();
		$( "#patienttabs" ).tabs();

		<?php
		if($pageview=='appointments'){
		?>
			$("#calendar .fc-content").css('display','none'); 		
			$(".fc-button-appointmnts").addClass('ui-state-active');
			$(".fc-button-agendaDay").removeClass('ui-state-active');
		<?php
		}else if($pageview=='schedule'){
		?>
			$("#calendar .fc-content").css('display','none'); 		
			$(".fc-button-mysechdules").addClass('ui-state-active');
			$(".fc-button-agendaDay").removeClass('ui-state-active');

		<?php
		}else if($pageview=='reports'){
		?>
			$("#calendar .fc-content").css('display','none'); 		
			$(".fc-button-reports").addClass('ui-state-active');
			$(".fc-button-agendaDay").removeClass('ui-state-active');
		<?php
		}else if($pageview=='timeoff'){
		?>
			$("#calendar .fc-content").css('display','none'); 		
			$(".fc-button-timeoff").addClass('ui-state-active');
			$(".fc-button-agendaDay").removeClass('ui-state-active');
		<?php
		}
		}
		?>
		
		<?php if($action=='edit' && $pageview!='timeoff' && $pageview!='schedule' && $pageview!='reports'){
			?>
			
			jQuery.fancybox({
            type: 'inline',
	        content: '#s_editAppointModal'
		    });
			$('#frmMicroGrid_mdo_appointments_update').attr('action','index.php?provider=calendar&pageview=appointments');
			$("input[name=btnCancel]")[0].onclick = null;
			$("input[name=btnCancel]").click(function() { window.location='index.php?provider=calendar&pageview=appointments';});
			$("input[name=subUpdateRecord]")[0].onclick = null;
			$("input[name=subUpdateRecord]").click(function() { 
				var suffix         = 'mdo_appointments';
				var action         = 'update';
			    var frmObj         = document.getElementById('frmMicroGrid_mdo_appointments_update');
				
				var rid            = (rid != null) ? rid : frmObj.mg_rid.value;
	
				var sorting_fields = (sorting_fields != null && sorting_fields != "") ? sorting_fields : frmObj.mg_sorting_fields.value;
				var sorting_types  = (sorting_types != null && sorting_types != "") ? sorting_types : frmObj.mg_sorting_types.value;
				var page           = (page != null && page != "") ? page : frmObj.mg_page.value;
			
				// for additional operations
				var operation      = (operation != null) ? operation : frmObj.mg_operation.value;
				var operation_type = (operation_type != null) ? operation_type : frmObj.mg_operation_type.value;
				var operation_field = (operation_field != null) ? operation_field : frmObj.mg_operation_field.value;   
			   
				if(action == "delete" && !confirm(Vocabulary._MSG["alert_delete_record"])){
					return false;
				}else{
					// handle custom alerts
					if(action == "update" && window['__mgDoModeAlert']){
						if(!window['__mgDoModeAlert']()){ return false; }
					}

						if(operation == "filtering"){
							frmObj.mg_search_status.value = 'active';
						}else if(operation == "reset_filtering"){
							frmObj.mg_search_status.value = '';
						}
						
						frmObj.mg_action.value = action;
						frmObj.mg_rid.value = rid;
						
						frmObj.mg_sorting_fields.value = sorting_fields;
						frmObj.mg_sorting_types.value = sorting_types;
						frmObj.mg_page.value = page;
						
						frmObj.mg_operation.value = operation;
						frmObj.mg_operation_field.value = operation_field;
						frmObj.mg_operation_type.value = operation_type;
//						frmObj.action="index.php?provider=calendar&pageview=<?php echo $pageview;?>";
						frmObj.action="index.php?<?php echo $_SERVER['QUERY_STRING']?>";
						frmObj.submit();
					}
					return false;
		 });
			<?php
		}?>
		
		
	});
	
	function addpatient(){
	$('#dialogframe').attr('src','<?php echo APPHP_BASE?>doctor/addnewpatient.php');
	$('#dialog').dialog("option", "title", "Find a patient").dialog("open");
	
	}
	


function openeditapp(suffix,action,rid){
	 
		jQuery.fancybox({
			href:"<?php echo APPHP_BASE?>doctor/addapppopup.php?mode=edit&id="+rid,
			 'height' : 800   
		});
		return false;
	 
	
}
</script>
<form id="frmMicroGrid_mdo_appointments1" method="post" action="index.php?provider=appointments" name="frmMicroGrid_mdo_appointments1"><input type="hidden" value="" name="mg_prefix"></input><input type="hidden" value="view" name="mg_action"></input><input type="hidden" value="" name="mg_rid"></input><input type="hidden" value="" name="mg_sorting_fields"></input><input type="hidden" value="" name="mg_sorting_types"></input><input type="hidden" value="1" name="mg_page"></input><input type="hidden" value="" name="mg_operation"></input><input type="hidden" value="" name="mg_operation_type"></input><input type="hidden" value="" name="mg_operation_field"></input><input type="hidden" value="" name="mg_search_status"></input><input type="hidden" value="" name="mg_language_id"></input><input type="hidden" value="k4nq485ez4jvyqhwal3p" name="mg_operation_code"></input><input type="hidden" value="c05cfd5f0687f2decb5092081bac233e" name="token"></input></form>
