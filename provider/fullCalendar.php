<?php
// *** Make sure the file isn't accessed directly
defined('APPHP_EXEC') or die('Restricted Access');

if($objLogin->IsLoggedInAsDoctor()){
    draw_title_bar(prepare_breadcrumbs(array(_CALENDAR=>'')));
?>
<ul class="nav nav-tabs">
    <li class="active"><a data-toggle="tab" href="#calendar_appointments">Calendar</a></li>
    <li><a data-toggle="tab" href="#calendar_schedules">Schedules</a></li>
    <li><a data-toggle="tab" href="#calendar_timeoffs">Time Offs</a></li>
    <li><a data-toggle="tab" href="#calendar_appointments_list">Appointments</a></li>
    <li><a data-toggle="modal" href="#cal_addModal" data-role="new_appointment">Add new Appointment</a></li>

</ul>
<div class="tab-content">
    <div id="calendar_appointments" class="tab-pane fade in active">

<style type="text/css">
.modal-body {
	white-space: nowrap !important;
}

.fc-toolbar {
    top: -6px;
}
.ui-autocomplete {
	max-width: 250px;
}
</style>

<!-- <link rel="stylesheet" href="custom_libraries/Dropdown_MultipleSelect/dropdown.css" />	-->

        <div class="row">
        <div class="col-md-12 col-sm-12">
            <div class="row" style="padding-bottom: 10px; padding-right: 15px;">
<!--                <a class="btn btn-warning pull-right" href="#cal_addModal" data-toggle="modal">Add new Appointment</a>  -->
    <!--
                <a class="btn btn-warning pull-right" href="ajaxCalendar/export.php" data-toggle="modal">Export</a>
                <a class="btn btn-warning pull-right" href="#cal_import" data-toggle="modal">Import</a>
    -->
            </div>
            <div class="clearfix"></div>
            <div class="box">
<!--                <div class="header"><h4>Calendar</h4></div>     -->
                <div class="content">
                    <div id="provider_calendar"></div>
                </div>
            </div>
        </div>
        </div>
	</div>
    <div id="calendar_schedules" class="tab-pane fade">
<?php
if($objLogin->IsLoggedInAsDoctor()){

    $action 	= MicroGrid::GetParameter('action');
    $rid    	= MicroGrid::GetParameter('rid');
    $doctor_id  = $objLogin->GetLoggedID();
    $mode       = 'view';
    $msg 	    = '';

    $objSchedules = new Schedules($doctor_id, 'me');

    if($action=='add'){
        $mode = 'add';
    }else if($action=='create'){
        if($objSchedules->AddRecord()){
            $msg = draw_success_message(_ADDING_OPERATION_COMPLETED, false);
            $mode = 'view';
        }else{
            $msg = draw_important_message($objSchedules->error, false);
            $mode = 'add';
        }
    }else if($action=='edit'){
        $mode = 'edit';
    }else if($action=='update'){
        if($objSchedules->UpdateRecord($rid)){
            $msg = draw_success_message(_UPDATING_OPERATION_COMPLETED, false);
            $mode = 'view';
        }else{
            $msg = draw_important_message($objSchedules->error, false);
            $mode = 'edit';
        }
    }else if($action=='delete'){
        if($objSchedules->DeleteRecord($rid)){
            $msg = draw_success_message(_DELETING_OPERATION_COMPLETED, false);
        }else{
            $msg = draw_important_message($objSchedules->error, false);
        }
        $mode = 'view';
    }else if($action=='details'){
        $mode = 'details';
    }else if($action=='cancel_add'){
        $mode = 'view';
    }else if($action=='cancel_edit'){
        $mode = 'view';
    }else{
        $action = '';
    }

    // Start main content
//    draw_title_bar(prepare_breadcrumbs(array(_MY_ACCOUNT=>'',_SCHEDULES=>'',ucfirst($action)=>'')));

    //if($objSession->IsMessage('notice')) echo $objSession->GetMessage('notice');
    echo $msg;

    draw_content_start();
    if($mode == 'view'){
        $objSchedules->DrawViewMode();
    }else if($mode == 'add'){
        $objSchedules->DrawAddMode();
    }else if($mode == 'edit'){
        $objSchedules->DrawEditMode($rid);
    }else if($mode == 'details'){
        $objSchedules->DrawDetailsMode($rid);
    }
    draw_content_end();

}else if($objLogin->IsLoggedIn()){
    draw_title_bar(_DOCTORS);
    draw_important_message(_NOT_AUTHORIZED);
}else{
    draw_title_bar(_DOCTORS);
    draw_message(str_replace('_ACCOUNT_', 'doctor', _MUST_BE_LOGGED));
}
?>
    </div>      <!-- END Schedules -->
    <div id="calendar_timeoffs" class="tab-pane fade">
<?php
if($objLogin->IsLoggedInAsDoctor()){

    $action 	= MicroGrid::GetParameter('action');
    $rid    	= MicroGrid::GetParameter('rid');
    $doctor_id  = $objLogin->GetLoggedID();
    $mode       = 'view';
    $msg 	    = '';

    $objTimeoffs = new Timeoffs($doctor_id, 'me');

    if($action=='add'){
        $mode = 'add';
    }else if($action=='create'){
        if($objTimeoffs->AddRecord()){
            $msg = draw_success_message(_ADDING_OPERATION_COMPLETED, false);
            $mode = 'view';
        }else{
            $msg = draw_important_message($objTimeoffs->error, false);
            $mode = 'add';
        }
    }else if($action=='edit'){
        $mode = 'edit';
    }else if($action=='update'){
        if($objTimeoffs->UpdateRecord($rid)){
            $msg = draw_success_message(_UPDATING_OPERATION_COMPLETED, false);
            $mode = 'view';
        }else{
            $msg = draw_important_message($objTimeoffs->error, false);
            $mode = 'edit';
        }
    }else if($action=='delete'){
        if($objTimeoffs->DeleteRecord($rid)){
            $msg = draw_success_message(_DELETING_OPERATION_COMPLETED, false);
        }else{
            $msg = draw_important_message($objTimeoffs->error, false);
        }
        $mode = 'view';
    }else if($action=='details'){
        $mode = 'details';
    }else if($action=='cancel_add'){
        $mode = 'view';
    }else if($action=='cancel_edit'){
        $mode = 'view';
    }else{
        $action = '';
    }

    // Start main content
//    draw_title_bar(prepare_breadcrumbs(array(_MY_ACCOUNT=>'',_TIMEOFF=>'',ucfirst($action)=>'')));

    //if($objSession->IsMessage('notice')) echo $objSession->GetMessage('notice');
    echo $msg;

    draw_content_start();
    if($mode == 'view'){
        $objTimeoffs->DrawViewMode();
    }else if($mode == 'add'){
        $objTimeoffs->DrawAddMode();
    }else if($mode == 'edit'){
        $objTimeoffs->DrawEditMode($rid);
    }else if($mode == 'details'){
        $objTimeoffs->DrawDetailsMode($rid);
    }
    draw_content_end();

}else if($objLogin->IsLoggedIn()){
    draw_title_bar(_DOCTORS);
    draw_important_message(_NOT_AUTHORIZED);
}else{
    draw_title_bar(_DOCTORS);
    draw_message(str_replace('_ACCOUNT_', 'doctor', _MUST_BE_LOGGED));
}
?>
    </div>      <!-- END Timeoffs -->
    <div id="calendar_appointments_list" class="tab-pane fade">
<?php
if($objLogin->IsLoggedInAsDoctor() && Modules::IsModuleInstalled('appointments')){

    $action = MicroGrid::GetParameter('action');
    $rid    = MicroGrid::GetParameter('rid');
    $mode   = 'view';
    $msg    = '';

    $objAppointments = new Appointments();

    if($action=='add'){
        $mode = 'add';
    }else if($action=='create'){
        $mode = 'view';
    }else if($action=='edit'){
        $mode = 'edit';
    }else if($action=='update'){
        if($objAppointments->UpdateRecord($rid)){
            $msg = draw_success_message(_UPDATING_OPERATION_COMPLETED, false);
            $mode = 'view';
        }else{
            $msg = draw_important_message($objAppointments->error, false);
            $mode = 'edit';
        }
    }else if($action=='delete'){
        $mode = 'view';
    }else if($action=='details'){
        $mode = 'details';
    }else if($action=='cancel_add'){
        $mode = 'view';
    }else if($action=='cancel_edit'){
        $mode = 'view';
    }else{
        $action = '';
    }

    // Start main content
/*
    draw_title_bar(
        prepare_breadcrumbs(array(_MY_ACCOUNT=>'',_APPOINTMENTS_MANAGEMENT=>'',ucfirst($action)=>'')),
        (($mode == 'edit' || $mode == 'details') ? '<a href="javascript:void(\'print\')" onclick="javascript:window.print();"><img src="images/printer.png" alt="print" /> '._PRINT.'</a>' : '')
    );
*/
    //if($objSession->IsMessage('notice')) echo $objSession->GetMessage('notice');
    echo $msg;

    //draw_content_start();
    echo '<div class="pages_contents">';
    if($mode == 'view'){
        $objAppointments->DrawViewMode();
    }else if($mode == 'add'){
        $objAppointments->DrawAddMode();
    }else if($mode == 'edit'){
        $objAppointments->DrawEditMode($rid);
    }else if($mode == 'details'){
        $objAppointments->DrawDetailsMode($rid);
    }
    //draw_content_end();
    echo '</div>';
}else if($objLogin->IsLoggedIn()){
    draw_title_bar(_DOCTORS);
    draw_important_message(_NOT_AUTHORIZED);
}else{
    draw_title_bar(_DOCTORS);
    draw_message(str_replace('_ACCOUNT_', 'doctor', _MUST_BE_LOGGED));
}
?>
    </div>
</div>


    <!-- Modal View Event -->
    <div id="cal_viewModal" class="modal fade">
    	<div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<h4 class="modal-title">Appointment details</h4>
        </div>
        <div class="modal-body">
            <div class="row">
                <div class="col-md-10" data-role="appointment-details">
                </div>
                <div class="col-md-2" data-role="appointment-status">
                    <form data-id="form-status">
                        <input name="status" type="radio" value="3" /> Check In <br />
                        <input name="status" type="radio" value="4" /> Paid <br />
                        <input name="status" type="radio" value="5" /> No Show <br />
                        <input name="status" type="radio" value="0" style="display: none;" />
                    </form>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <a href="#" class="btn btn-danger" data-option="remove">Cancel</a>
            <a href="#" class="btn btn-info" data-option="add-new">Add New</a>
            <a href="#" class="btn btn-info" data-option="edit">Edit</a>
        	<a href="#" class="btn btn-default" data-dismiss="modal">Close</a>
        </div>
        </div>
        </div>
    </div>
	
    <!-- Modal Edit Event -->
<!--
    <div id="cal_editModal" class="modal fade">
    	<div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
        	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        </div>
        <div class="modal-body">
			<form id='form-edit-appointment'>
				<input type="hidden" name='appointment_id' value='' />
				<input type="hidden" name='appointment_customer_id' value='' />
				<fieldset style="padding:5px;margin-left:5px;margin-right:10px;">
					<table class="mgrid_table" width="100%" cellspacing="0" cellpadding="2" border="0">
						<tbody>
							<tr>
								<td width="25%" align="left" style="border-right: 0px dotted rgb(204, 204, 204);">
									<label for="customer_name">Customer name</label>
									<span class="required">*</span>
									:
								</td>
								<td style="text-align:left;padding-left:6px;">
									<input name="customer_name" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:250px;">
								</td>
							</tr>
							<tr>
								<td width="25%" align="left" style="border-right: 0px dotted rgb(204, 204, 204);">
									<label for="service_name">Name</label>
									<span class="required">*</span>
									:
								</td>
								<td style="text-align:left;padding-left:6px;">
									<input name="service_name" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:250px;">
								</td>
							</tr>
						</tbody>
					</table>
				</fieldset>
			</form>
		</div>
        <div class="modal-footer">
            <a href="#" class="btn btn-primary" data-option="save">Save Changes</a>
        	<a href="#" class="btn btn-default" data-dismiss="modal">Close</a>
        </div>
        </div>
        </div>
    </div>
-->
	
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
	<div id="cal_addModal" class="modal fade">
		<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">Add new Appointment</h4>
			</div>

			<div class="modal-body">
				<form id='form-appointment'>
					<fieldset>
						<input type="hidden" name='appointment_id' value='' />
						<input type="hidden" name='appointment_customer_id' value='' />
						<table class="mgrid_table" width="100%" cellspacing="0" cellpadding="0" border="0">
							<tbody>
								<tr>
									<td width="25%" align="left">
										<label for="customer_name">Customer/Pet Name <span class="required">*</span>:</label>
									</td>
									<td style="text-align:left;padding-left:6px;">
										<input type="text" name="customer_name" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:250px;" />
									</td>
								</tr>
								<tr>
									<td>
										<a href="#cal_add_customer" data-toggle="modal" style="color: blue">Add a new customer</a>
									</td>
								</tr>
                                <tr>
                                    <td width="25%" align="left">
                                        <label for="customer_phone">Phone:</label>
                                    </td>
                                    <td style="text-align:left;padding-left:6px;">
                                        <input type="text" name="customer_phone" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:250px;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td width="25%" align="left">
                                        <label for="customer_email">Email:</label>
                                    </td>
                                    <td style="text-align:left;padding-left:6px;">
                                        <input type="text" name="customer_email" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:250px;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td width="25%" align="left">
                                        <label for="customer_pets">Pets:</label>
                                    </td>
                                    <td style="text-align:left;padding-left:6px;">
                                        <input type="text" name="customer_pets" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:250px;" />
                                    </td>
                                </tr>
								<tr>
									<td width="25%" align="left">
										<label for="service_list[]">Service List<span class="required">*</span>:</label>
									</td>
									<td style="text-align:left;padding-left:6px;">
										<select name="service_list[]" style="width:250px;" multiple="multiple" size="5" class="required">
                                            <optgroup label="Services">
<?php
	$services = Services::getAllActiveServicesByProviderID($objLogin -> getLoggedID());
	foreach ($services as $s) {
		echo '<option value="s' . $s -> getId() . '">' . $s -> getName() . '</option>';
	}
?>
                                            </optgroup>
                                            <optgroup label="Packages">
<?php
    $packages = Packages::getAllActivePackagesByProviderID($objLogin -> getLoggedID());
    foreach ($packages as $p) {
        echo '<option value="p' . $p -> getId() . '">' . $p -> getName() . '</option>';
    }
?>
                                            </optgroup>
										</select>
									</td>
								</tr>
								<tr>
									<td width="25%" align="left">
										<label for="appointment_date">Start date <span class="required">*</span>:</label>
									</td>
									<td style="text-align:left;padding-left:6px;">
										<input type="text" name="appointment_date" id="datepicker" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:250px;" />
									</td>
								</tr>
								<tr>
									<td width="25%" align="left">
										<label for="appointment_time">Start time <span class="required">*</span>:</label>
									</td>
									<td style="text-align:left;padding-left:6px;">
										<input type="text" name="appointment_time" placeholder="HH:MM" class="mgrid_text" dir="ltr" id="tp1" maxlength="70" value='' style="width:250px;" />
									</td>
								</tr>
								<tr>
									<td width="25%" align="left">
										<label for="duration">Duration <span class="required">*</span>:</label>
									</td>
									<td style="text-align:left;padding-left:6px;">
<!--										<input name="duration" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:250px;" />   -->
                                        <select name="duration" style="width:250px;">
<?php
    $interval = 15;
    $currentDuration = 0;
    while ($currentDuration < 120) {
        $currentDuration += $interval;
        echo "<option value='$currentDuration'>$currentDuration minutes</option>";
    }
?>
                                        </select>
									</td>
								</tr>
<!--
								<tr>
									<td width="25%" align="left">
										<label for="color">Color <span class="required">*</span>:</label>
									</td>
									<td style="text-align:left;padding-left:6px;">
										<input type="text" class="form-control input-sm" name="color" data-role="spectrum" />
									</td>
								</tr>
-->
							</tbody>
						</table>
					</fieldset>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-warning" data-role='appointment-submit'>Submit</button>
			</div>
		</div>
		</div>
	</div>
	
	<div id="cal_add_customer" class="modal fade">
		<div class="modal-dialog">
		<div class="modal-content">
        <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<h4 class="modal-title">Add new customer</h4>
        </div>
		<div class="modal-body">
			<form id='form-customer'>
				<fieldset>
					<table class="mgrid_table" width="100%" cellspacing="0" cellpadding="0" border="0">
						<tbody>
							<tr>
								<td width="25%" align="left">
									<label for="customer_fname">First Name <span class="required">*</span>:</label>
								</td>
								<td style="text-align:left;padding-left:6px;">
									<input name="customer_fname" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:250px;" />
								</td>
							</tr>
							<tr>
								<td width="25%" align="left">
									<label for="customer_lname">Last Name <span class="required">*</span>:</label>
								</td>
								<td style="text-align:left;padding-left:6px;">
									<input name="customer_lname" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:250px;" />
								</td>
							</tr>
							<tr>
								<td width="25%" align="left">
									<label for="customer_phone">Phone <span class="required">*</span>:</label>
								</td>
								<td style="text-align:left;padding-left:6px;">
									<input name="customer_phone" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:250px;" />
								</td>
							</tr>
							<tr>
								<td width="25%" align="left">
									<label for="customer_email">Email <span class="required">*</span>:</label>
								</td>
								<td style="text-align:left;padding-left:6px;">
									<input name="customer_email" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:250px;" />
								</td>
							</tr>
						</tbody>
					</table>
				</fieldset>
			</form>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			<button type="button" class="btn btn-warning" data-role='calendar-customer-submit'>Add</button>
		</div>
		</div>
		</div>
	</div>

<script src="ajaxCalendar/js/custom.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	// initialize the calendar
	createCalendar({
		calendarSelector: '#provider_calendar'
	}, {
		defaultView: 'agendaWeek',
		slotDuration: '00:15:00',
		minTime: '06:00:00',
		maxTime: '21:00:00',
		allDaySlot: false,
	});

    var height = $(".content-wrapper").height();
    $(".main-sidebar").height(height);

	// only add the submenu if user goes to this page
	$("ul#topnav > li").each(function() {
		if ($(this).children("a").html() == "Calendar") {
			$(this).html('<a href="index.php?provider=fullCalendar" rel="fullCalendar">Calendar</a>' + 
			'<span style="display: none;">' + 
				'<a href="#cal_addModal" class="btn" data-toggle="modal">Add Event</a>' + 
				'<a href="ajaxCalendar/export.php" class="btn">Export</a>' + 
				'<a href="#cal_import" class="btn" data-toggle="modal">Import</a>' + 
			'</span>');
		}
	});
});
</script>
<?php
}
?>