<?php
// *** Make sure the file isn't accessed directly
defined('APPHP_EXEC') or die('Restricted Access');

if($objLogin->IsLoggedInAsDoctor()){
?>
<link rel="stylesheet" href="custom_libraries/Dropdown_MultipleSelect/dropdown.css" />

<div class="row">
	<div class="container">
		<div class="clearfix"></div>
		<div class="box">
		<div class="header"><h4>Calendar</h4></div>
		<div class="content"> 
			<div id="doctor_calendar"></div>
		</div> 
		</div>
	</div>
	
    <!-- Modal View Event -->
    <div id="cal_viewModal" class="modal fade">
    	<div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
        	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        </div>
        <div class="modal-body"></div>
        <div class="modal-footer">
            <a href="#" class="btn btn-danger" data-option="remove">Delete</a>
            <a href="#" class="btn btn-info" data-option="edit">Edit</a>
        	<a href="#" class="btn btn-default" data-dismiss="modal">Close</a>
        </div>
        </div>
        </div>
    </div>
	
    <!-- Modal Edit Event -->
    <div id="cal_editModal" class="modal fade">
    	<div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
        	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        </div>
        <div class="modal-body"></div>
        <div class="modal-footer">
            <a href="#" class="btn btn-primary" data-option="save">Save Changes</a>
        	<a href="#" class="btn btn-default" data-dismiss="modal">Close</a>
        </div>
        </div>
        </div>
    </div>
	
	<!-- Modal Delete Prompt -->
    <div id="cal_prompt" class="modal fade">
    	<div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
        	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        </div>
        <div class="modal-body"></div>
        <div class="modal-footer">
        	<a href="#" class="btn btn-danger" data-option="remove-this">Delete this</a>
            <a href="#" class="btn btn-danger" data-option="remove-repetitives">Delete all</a>
        	<a href="#" class="btn btn-default" data-dismiss="modal">Close</a>
        </div>
        </div>
        </div>
    </div>
	
    <!-- Import Modal -->
    <div id="cal_import" class="modal fade">
    	<div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-body-import" style="white-space: normal;">
        	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4>Import Event</h4>
            
        	<p class="help-block">Copy & Paste the event code from your .ics file, open it using an text editor</p>
            <textarea class="form-control" rows="10" id="import_content" style="margin-bottom: 10px;"></textarea>
            <input type="button" class="pull-right btn btn-info" onClick="calendar.calendarImport()" value="Import" />
        </div>
        </div>
        </div>
    </div>
	
	<!-- Add Event Modal -->
	<div id="cal_add_event" class="modal fade">
		<div class="modal-dialog">
		<div class="modal-content">
		<div class="modal-body-import" style="white-space: normal;">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4>Add Event</h4>
			<div class="content pad"> 
				<form id="addEvent" class="ui-front">
					<label>Customer name</label>
					<input type="text" class="form-control" name="c_name" />
					<input type="hidden" name="c_id" value="" />
					<div class="clearfix"></div>
					<div data-class="customer_error" style="color: red;"></div><br />
					<a href="#cal_add_customer" data-toggle="modal" style="color: blue">Add a new customer</a>
					<div class="clearfix"></div><br />
					
					<select name="speciality_selector[]" multiple="multiple">
<?php
	$result = Specialities::GetAllActive();
	foreach ($result[0] as $speciality) {
		echo '<option value="' . $speciality["id"] . '">' . $speciality["name"] . '</option>';
	}
?>
					</select>
					<div class="clearfix"></div><br />
					
					<div class="pull-left mr-10">
						<label>Start Date:</label>
						<input type="text" name="appointment_date" class="form-control input-sm" id="datepicker" />
					</div>
					<div class="pull-left mr-10">
						<label>Start Time:</label>
						<input type="text" class="form-control input-sm" name="appointment_time" placeholder="HH:MM" id="tp1" />
					</div>
					<div class="clearfix"></div>
					<div class="pull-left mr-10">
						<label>Duration</label>
						<input type="text" class="form-control input-sm" name="visit_duration" />
					</div>
					<div class="clearfix"></div><br />
					
					<label>Event Color:</label>
					<input type="text" class="form-control input-sm" name="color" data-role="spectrum" />
					<div class="clearfix"></div><br />
					

					<div class="clearfix"></div><br />
					<input type="hidden" name="form_type" value="add" />
					<input type="hidden" name="app_id" value="" />
					<input type="hidden" name="d_id" value="<?php echo Session::Get("session_account_id"); ?>" />
					<button type="submit" onclick="calendar.save()" class="btn btn-primary pull-right">Add Event</button>
				</form>
			</div>
		</div>
		</div>
		</div>
	</div>
	
	<div id="cal_add_customer" class="modal fade">
		<div class="modal-dialog">
		<div class="modal-content">
		<div class="modal-body-import" style="white-space: normal;">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4>Quick add patient</h4>
			<div class="content pad"> 
				<div data-error="addPatientError" style="color: red;"></div>
				<form id="quickAddPatient">
					<div class="pull-left mr-10">
						<label>First Name</label>
						<input type="text" class="form-control" name="p_fname" />
					</div>
					<div class="pull-left mr-10">
						<label>Last Name</label>
						<input type="text" class="form-control" name="p_lname" />
					</div>
					<div class="clearfix"></div>
					<label>Email</label>
					<input type="text" class="form-control" name="p_email" />
					<label>Phone number</label>
					<input type="text" class="form-control" name="p_phone" />
					<br />
					<input type="hidden" name="provider_id" value="<?php echo Session::Get("session_account_id"); ?>" />
					<button type="submit" class="btn btn-primary pull-right">Add Patient</button>
				</form>
			</div>
		</div>
		</div>
		</div>
	</div>
</div>

<script src="ajaxCalendar/js/custom.js"></script>
<script src="custom_libraries/Dropdown_MultipleSelect/dropdown.js"></script>
<script type="text/javascript">
	// initialize the calendar
	$(document).FullCalendarExt({
		calendarSelector: '#doctor_calendar',
		ajaxJsonFetch: 'ajaxCalendar/includes/cal_events.php',
		ajaxUiUpdate: 'ajaxCalendar/includes/cal_update.php',
		ajaxEventSave: 'ajaxCalendar/includes/cal_save.php',
		ajaxEventQuickSave: 'ajaxCalendar/includes/cal_quicksave.php',
		ajaxEventDelete: 'ajaxCalendar/includes/cal_delete.php',
		ajaxEventEdit: 'ajaxCalendar/includes/cal_edit_update.php',
		ajaxEventExport: 'ajaxCalendar/includes/cal_export.php',
		ajaxRepeatCheck: 'ajaxCalendar/includes/cal_check_rep_events.php',
		ajaxRetrieveDescription: 'ajaxCalendar/includes/cal_description.php',
		ajaxImport: 'ajaxCalendar/importer.php',
		
		formAddEventSelector: 'form#addEvent',
		modalEditSelector: '#cal_add_event',
		modalQuickSaveSelector: '#cal_add_event',
		
		defaultView: 'agendaWeek',
		slotDuration: '00:15:00',
		minTime: '06:00:00',
		maxTime: '21:00:00',
		allDaySlot: false,
	});
	
$(document).ready(function() {
<?php
	$p = new Patients();
	$results = $p -> GetAllPatients();
	$results = database_query("SELECT `id`, `first_name`, `last_name` FROM `meda_patients`, `providers_customers` WHERE `id`=`customer_id` AND `provider_id`=" . Session::Get("session_account_id"));
	echo "var data = [";
	foreach ($results as $r) {
		echo '{ value: "' . $r["id"] . '", label: "' . $r['first_name'] . " " . $r['last_name'].  '"},';
	}
	echo "];";
?>

	// only add the submenu if user goes to this page
	$("ul#topnav > li").each(function() {
		if ($(this).children("a").html() == "Calendar") {
			$(this).html('<a href="index.php?provider=fullCalendar" rel="fullCalendar">Calendar</a>' + 
			'<span style="display: none;">' + 
				'<a href="#cal_add_event" class="btn" data-toggle="modal">Add Event</a>' + 
				'<a href="ajaxCalendar/export.php" class="btn">Export</a>' + 
				'<a href="#cal_import" class="btn" data-toggle="modal">Import</a>' + 
			'</span>');
		}
	});
	
//	$("button.fc-agendaWeek-button").click();

	$("form#addEvent input[name='c_name']").autocomplete({
		source: data,
		focus: function(event, ui) {
			// prevent autocomplete from updating the textbox
			event.preventDefault();
			// manually update the textbox
			$(this).val(ui.item.label);
			if (ui.item == null) { $(this).val('please add a new customer'); }
			else { $(this).val(ui.item.label); }
		},
		select: function(event, ui) {
			// prevent autocomplete from updating the textbox
			event.preventDefault();
			// manually update the textbox and hidden field
			$(this).val(ui.item.label);
			$("input[name='c_id']").val(ui.item.value);
		},
		response: function(event, ui) {
			if (ui.content.length === 0) {
				$("div[data-class='customer_error']").html("No customer found");
				$("input[name='c_id']").val("");
			} else {
				$("div[data-class='customer_error']").empty();
			}
		}
	});
	
	$("form#addEvent").find("select[name='speciality_selector[]']").multiselect({
		nonSelectedText: "Select Speciality",
	});
});
</script>
<?php
}
?>