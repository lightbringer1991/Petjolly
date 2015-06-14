<?php
	include "../include/base.inc.php";
	include "../include/connection.php";
	include_once('../include/messages.inc.php');
	$doctor_id = Session::Get('session_account_id');
	define('APPHP_BASE1', "http://www.vitalscloud.com/alpha/");
	
	
$sql = "SELECT * FROM " . TABLE_SCHEDULES . " WHERE doctor_id = $doctor_id AND ('$date' >= date_from AND '$date' <= date_to)";
$schedule = database_query($sql, DATA_ONLY, FIRST_ROW);

if (!empty($schedule)) {
	// get all timeblocks
	$sql = "SELECT * FROM " . TABLE_SCHEDULE_TIMEBLOCKS . " WHERE schedule_id = $schedule[id]";
	$timeBlocks = database_query($sql, DATA_ONLY);
	$doctorWeekends = array(1 => 'Sun', 2 => 'Mon', 3 => 'Tue', 4 => 'Wed', 5 => 'Thu', 6 => 'Fri', 7 => 'Sat');
	foreach ($timeBlocks AS $timeBlock) {
		if (!empty($doctorWeekends[$timeBlock['week_day']])) {
			unset($doctorWeekends[$timeBlock['week_day']]);
		}
	}
	
	// get current timeblock
	$curWeekDay = date('N', strtotime($date))+1;
	$sql = "SELECT * FROM " . TABLE_SCHEDULE_TIMEBLOCKS . " WHERE schedule_id = $schedule[id] AND week_day = $curWeekDay";
	$curTimeBlock = database_query($sql, DATA_ONLY, FIRST_ROW);
}

// default weekends if not set by doctor
if (empty($doctorWeekends)) {
	$doctorWeekends = array('Sat', 'Sun');
}

// default timeblock if not set by doctor
if (empty($curTimeBlock)) {
	$curTimeBlock = array(
		'time_slots' => 15,
		'time_from' => '08:00:00',
		'time_to' => '18:00:00',
	);
}


$sql = "
	SELECT DISTINCT mdo_patients.id, first_name, last_name
	FROM mdo_patients
	INNER JOIN mdo_appointments ON mdo_patients.id = mdo_appointments.patient_id
	WHERE mdo_appointments.doctor_id = $doctor_id ORDER BY mdo_patients.first_name ASC
";
$patients = database_query($sql);
$sql = "
	SELECT DISTINCT id, first_name, last_name
	FROM mdo_doctors
	WHERE is_active=1
";
$doctors = database_query($sql);
if($_GET['mode']=='edit'){
	$repeat =0;
	$appointsTable = TABLE_APPOINTMENTS;
	$patientsTable = TABLE_PATIENTS;
	$sql = "
		SELECT
			$appointsTable.id,$appointsTable.patient_id,$appointsTable.doctor_id,$appointsTable.doctor_speciality_id,$appointsTable.doctor_address_id,$appointsTable.doctor_address_id,$appointsTable.status,$appointsTable.appointment_type,$appointsTable.appointment_date, $appointsTable.appointment_time, $appointsTable.visit_duration,
			$patientsTable.first_name, $patientsTable.last_name,concat(doc.first_name,' ',doc.last_name) as doctor_name,aptype.type_name as type_name
		FROM $appointsTable
		LEFT JOIN $patientsTable		
		ON $patientsTable.id = $appointsTable.patient_id
		LEFT JOIN mdo_doctors doc	
		ON doc.id = $appointsTable.doctor_id
		LEFT JOIN mdo_appointment_type aptype on aptype.id=$appointsTable.appointment_type
		WHERE 1=1 and $appointsTable.id=".trim($_GET['id']);
	$result =  mysql_query($sql) or die(mysql_error());
	$row = @mysql_fetch_assoc($result);
	@extract($row);
	
	$apstatus_id = $status;
	$sql1 = "SELECT * FROM  " . TABLE_APPOINTMENTS . "_repeat apr inner join $appointsTable on apr.app_id=$appointsTable.id  WHERE  apr.app_id=".$id;
	$result1 =  mysql_query($sql1) or die(mysql_error());
	if(@mysql_num_rows($result1) >0){
	$row1 = @mysql_fetch_assoc($result1);
	@extract($row1);
	$repeat=1;
	}
}
?>

<link href="http://www.vitalscloud.com/alpha/templates/default/css/style.css" rel="stylesheet" type="text/css" media="screen" />
<link href="http://www.vitalscloud.com/alpha/templates/default/css/reveal.css" type="text/css" rel="stylesheet" />	
<link href="http://www.vitalscloud.com/alpha/templates/default/css/jquery.fancybox.css" rel="stylesheet">
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/themes/cupertino/jquery-ui.css" rel="stylesheet" type="text/css" media="screen" />
<!--<script type="text/javascript" src="http://www.vitalscloud.com/alpha/templates/default/js/jquery.fancybox.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>-->

<script type="text/javascript">

function showrepeatdata(){
		var rvalue = $('#repeat_id').val();
		if(rvalue == 4 ){
			<?php if($_GET['mode']=='edit'){ ?>

			$('#repeatdata').html('<table cellpadding="0" cellspacing="0" border="0" ><tr ><td><strong>Repeat every: </strong></td><td><select name="repeat_every" required ><option value="1"<?php echo ($repeat_every==1)?'selected="selected"':'';?>>1</option><option value="2"<?php echo ($repeat_every==2)?'selected="selected"':'';?>>2</option><option value="3"<?php echo ($repeat_every==3)?'selected="selected"':'';?>>3</option><option value="4"<?php echo ($repeat_every==4)?'selected="selected"':'';?>>4</option></select>&nbsp;Weeks<br></td></tr><tr><td><strong>Repeat on: </strong></td><td><input type="checkbox" name="repeaton[]" value="Sun"<?php echo (in_array('Sun',explode(',',$repeat_on)))?'checked="checked"':'';?>  />&nbsp;S &nbsp;&nbsp;<input type="checkbox" name="repeaton[]" value="Mon"<?php echo (in_array('Mon',explode(',',$repeat_on)) &&$repeat_id==4)?'checked="checked"':'';?>/>&nbsp;M&nbsp;&nbsp;<input type="checkbox" name="repeaton[]" value="Tue"<?php echo (in_array('Tue',explode(',',$repeat_on)) && $repeat_id==4)?'checked="checked"':'';?> />&nbsp;T&nbsp;&nbsp;<input type="checkbox" name="repeaton[]" value="Wed" <?php echo (in_array('Wed',explode(',',$repeat_on)) && $repeat_id==4)?'checked="checked"':'';?>/>&nbsp;W&nbsp;&nbsp;<input type="checkbox" name="repeaton[]" value="Thu" <?php echo (in_array('Thu',explode(',',$repeat_on)) && $repeat_id==4)?'checked="checked"':'';?>/>&nbsp;T&nbsp;&nbsp;<input type="checkbox" name="repeaton[]" value="Fri" <?php echo (in_array('Fri',explode(',',$repeat_on)) && $repeat_id==4)?'checked="checked"':'';?>/>&nbsp;F&nbsp;&nbsp;<input type="checkbox" name="repeaton[]" value="Sat"<?php echo (in_array('Sat',explode(',',$repeat_on)) && $repeat_id==4)?'checked="checked"':'';?> />&nbsp;S&nbsp;&nbsp;<br /><span style="color:#FF0000;" id="repeaterror"></span></td></tr></table>');
			<?php }else{?>
			
			$('#repeatdata').html('<table cellpadding="0" cellspacing="0" border="0" ><tr ><td><strong>Repeat every: </strong></td><td><select name="repeat_every" required ><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option></select>&nbsp;Weeks<br></td></tr><tr><td><strong>Repeat on: </strong></td><td><input type="checkbox" name="repeaton[]"   value="Sun"   />&nbsp;S &nbsp;&nbsp;<input type="checkbox" name="repeaton[]" value="Mon" />&nbsp;M &nbsp;&nbsp;<input type="checkbox" name="repeaton[]" value="Tue" />&nbsp;T &nbsp;&nbsp;<input type="checkbox" name="repeaton[]" value="Wed" />&nbsp;W &nbsp;&nbsp;<input type="checkbox" name="repeaton[]" value="Thu" />&nbsp;T &nbsp;&nbsp;<input type="checkbox" name="repeaton[]" value="Fri" />&nbsp;F &nbsp;&nbsp;<input type="checkbox" name="repeaton[]" value="Sat" />&nbsp;S &nbsp;&nbsp;<br><span style="color:#FF0000;" id="repeaterror"></span></td></tr></table>');
			<?php }?>
		}else if(rvalue == 5 ){
		<?php if($_GET['mode']=='edit'){ ?>
			$('#repeatdata').html('<table cellpadding="0" cellspacing="0" border="0" ><tr ><td><strong>Repeat every: </strong></td><td><select name="repeat_every" required ><option value="1" <?php echo ($repeat_every==1)?'selected="selected"':'';?>>1</option><option value="2" <?php echo ($repeat_every==2)?'selected="selected"':'';?>>2</option><option value="3" <?php echo ($repeat_every==3)?'selected="selected"':'';?>>3</option><option value="4" <?php echo ($repeat_every==4)?'selected="selected"':'';?>>4</option><option value="5" <?php echo ($repeat_every==5)?'selected="selected"':'';?>>5</option><option value="6" <?php echo ($repeat_every==6)?'selected="selected"':'';?>>6</option><option value="7" <?php echo ($repeat_every==7)?'selected="selected"':'';?>>7</option><option value="8" <?php echo ($repeat_every==8)?'selected="selected"':'';?>>8</option><option value="9" <?php echo ($repeat_every==9)?'selected="selected"':'';?>>9</option><option value="10" <?php echo ($repeat_every==10)?'selected="selected"':'';?>>10</option><option value="11" <?php echo ($repeat_every==11)?'selected="selected"':'';?>>11</option><option value="12" <?php echo ($repeat_every==12)?'selected="selected"':'';?>>12</option><option value="13" <?php echo ($repeat_every==13)?'selected="selected"':'';?>>13</option><option value="14" <?php echo ($repeat_every==14)?'selected="selected"':'';?>>14</option><option value="15" <?php echo ($repeat_every==15)?'selected="selected"':'';?>>15</option><option value="16" <?php echo ($repeat_every==16)?'selected="selected"':'';?>>16</option><option value="17" <?php echo ($repeat_every==17)?'selected="selected"':'';?>>17</option><option value="18" <?php echo ($repeat_every==18)?'selected="selected"':'';?>>18</option><option value="19" <?php echo ($repeat_every==19)?'selected="selected"':'';?>>19</option><option value="20" <?php echo ($repeat_every==20)?'selected="selected"':'';?>>20</option><option value="21" <?php echo ($repeat_every==21)?'selected="selected"':'';?>>21</option><option value="22" <?php echo ($repeat_every==22)?'selected="selected"':'';?>>22</option><option value="23" <?php echo ($repeat_every==23)?'selected="selected"':'';?>>23</option><option value="24" <?php echo ($repeat_every==24)?'selected="selected"':'';?>>24</option><option value="25" <?php echo ($repeat_every==25)?'selected="selected"':'';?>>25</option><option value="26" <?php echo ($repeat_every==26)?'selected="selected"':'';?>>26</option><option value="27" <?php echo ($repeat_every==27)?'selected="selected"':'';?>>27</option><option value="28" <?php echo ($repeat_every==28)?'selected="selected"':'';?>>28</option><option value="29" <?php echo ($repeat_every==29)?'selected="selected"':'';?>>29</option><option value="30" <?php echo ($repeat_every==30)?'selected="selected"':'';?>>30</option></select>&nbsp;Months<br></td></tr></table>');
 	 <?php }else{?>
	 	$('#repeatdata').html('<table cellpadding="0" cellspacing="0" border="0" ><tr ><td><strong>Repeat every: </strong></td><td><select name="repeat_every" required ><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5">5</option><option value="6">6</option><option value="7">7</option><option value="8">8</option><option value="9">9</option><option value="10">10</option><option value="11">11</option><option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option><option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option><option value="20">20</option><option value="21">21</option><option value="22">22</option><option value="23">23</option><option value="24">24</option><option value="25">25</option><option value="26">26</option><option value="27">27</option><option value="28">28</option><option value="29">29</option><option value="30">30</option></select>&nbsp;Months<br></td></tr></table>');
	 <?php }?>
		}else if(rvalue == 6 ){
		<?php if($_GET['mode']=='edit'){ ?>
			$('#repeatdata').html('<table cellpadding="0" cellspacing="0" border="0" ><tr ><td><strong>Repeat every: </strong></td><td><select name="repeat_every" required ><option value="1" <?php echo ($repeat_every==1)?'selected="selected"':'';?>>1</option><option value="2" <?php echo ($repeat_every==2)?'selected="selected"':'';?>>2</option><option value="3" <?php echo ($repeat_every==3)?'selected="selected"':'';?>>3</option><option value="4" <?php echo ($repeat_every==4)?'selected="selected"':'';?>>4</option><option value="5" <?php echo ($repeat_every==5)?'selected="selected"':'';?>>5</option><option value="6" <?php echo ($repeat_every==6)?'selected="selected"':'';?>>6</option><option value="7" <?php echo ($repeat_every==7)?'selected="selected"':'';?>>7</option><option value="8" <?php echo ($repeat_every==8)?'selected="selected"':'';?>>8</option><option value="9" <?php echo ($repeat_every==9)?'selected="selected"':'';?>>9</option><option value="10" <?php echo ($repeat_every==10)?'selected="selected"':'';?>>10</option><option value="11" <?php echo ($repeat_every==11)?'selected="selected"':'';?>>11</option><option value="12" <?php echo ($repeat_every==12)?'selected="selected"':'';?>>12</option><option value="13" <?php echo ($repeat_every==13)?'selected="selected"':'';?>>13</option><option value="14" <?php echo ($repeat_every==14)?'selected="selected"':'';?>>14</option><option value="15" <?php echo ($repeat_every==15)?'selected="selected"':'';?>>15</option><option value="16" <?php echo ($repeat_every==16)?'selected="selected"':'';?>>16</option><option value="17" <?php echo ($repeat_every==17)?'selected="selected"':'';?>>17</option><option value="18" <?php echo ($repeat_every==18)?'selected="selected"':'';?>>18</option><option value="19" <?php echo ($repeat_every==19)?'selected="selected"':'';?>>19</option><option value="20" <?php echo ($repeat_every==20)?'selected="selected"':'';?>>20</option><option value="21" <?php echo ($repeat_every==21)?'selected="selected"':'';?>>21</option><option value="22" <?php echo ($repeat_every==22)?'selected="selected"':'';?>>22</option><option value="23" <?php echo ($repeat_every==23)?'selected="selected"':'';?>>23</option><option value="24" <?php echo ($repeat_every==24)?'selected="selected"':'';?>>24</option><option value="25" <?php echo ($repeat_every==25)?'selected="selected"':'';?>>25</option><option value="26" <?php echo ($repeat_every==26)?'selected="selected"':'';?>>26</option><option value="27" <?php echo ($repeat_every==27)?'selected="selected"':'';?>>27</option><option value="28" <?php echo ($repeat_every==28)?'selected="selected"':'';?>>28</option><option value="29" <?php echo ($repeat_every==29)?'selected="selected"':'';?>>29</option><option value="30" <?php echo ($repeat_every==30)?'selected="selected"':'';?>>30</option></select>&nbsp;Years<br></td></tr></table>');
		<?php }else{?>
			$('#repeatdata').html('<table cellpadding="0" cellspacing="0" border="0" ><tr ><td><strong>Repeat every: </strong></td><td><select name="repeat_every" required ><option value="1">1</option><option value="2">2</option><option value="3">3</option><option value="4">4</option><option value="5">5</option><option value="6">6</option><option value="7">7</option><option value="8">8</option><option value="9">9</option><option value="10">10</option><option value="11">11</option><option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option><option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option><option value="20">20</option><option value="21">21</option><option value="22">22</option><option value="23">23</option><option value="24">24</option><option value="25">25</option><option value="26">26</option><option value="27">27</option><option value="28">28</option><option value="29">29</option><option value="30">30</option></select>&nbsp;Years<br></td></tr></table>');
		<?php }?>
		}else{
			$('#repeatdata').html('');

		}
	}
jQuery(document).ready(function($){
	$( "#aptabs" ).tabs();
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
			var dcid = $('#doctor_id').val();
			$('#appointTimes').attr('disabled', 'disabled');
			//alert( '<?php echo APPHP_BASE1;  ?>?doctor=calendar&ajax=true&aptime=<?php echo $appointment_time?>&apdoctor_id='+dcid+'&date=' + $(this).val());
			$.ajax({
				url: '<?php echo APPHP_BASE1;  ?>?doctor=calendar&ajax=true&aptime=<?php echo $appointment_time?>&apdoctor_id='+dcid+'&date=' + $(this).val(),
				dataType: 'json',
				success: function(data) {
			//alert(data);
					$('#appointTimes').html(data.appointTimes);
					$('#appointTimes').removeAttr('disabled');
					$('#appointDuration').val(data.timeSlots);
				}
			});
		});
		
		$("#doctor_id").change(function() {
			var dcid = $(this).val();
		
			$.ajax({
				url: '<?php echo APPHP_BASE1;  ?>?doctor=calendar&ajax=1&apdoctorid='+dcid+'&appointment_type=<?php echo $appointment_type;?>&speciality_id=<?php echo $doctor_speciality_id;?>&address_id=<?php echo $doctor_address_id;?>&action=fetchaddress',
				dataType: 'json',
				success: function(data) {
				//	alert(data);
					$('#typediv').html(data['type']);
					$('#specialitydiv').html(data['speciality']);
					$('#addressdiv').html(data['address']);
				}
			});
		});
		<?php if($_GET['mode']=='edit' || $_GET['starttime']!='' ){
if($_GET['starttime']!=''){
			$appointment_time = date('h:i A',strtotime($_GET['starttime']));
			$appointment_date = date('Y-m-d',strtotime($_GET['starttime']));
}
		?>
	
			$.ajax({
				url: '<?php echo APPHP_BASE1;  ?>?doctor=calendar&ajax=true&aptime=<?php echo $appointment_time?>&date=<?php echo $appointment_date;?>',
				dataType: 'json',
				success: function(data) {
		
					$('#appointTimes').html(data.appointTimes);
					$('#appointTimes').removeAttr('disabled');
					$('#appointDuration').val(data.timeSlots);
				}
			});
			$.ajax({
				url: '<?php echo APPHP_BASE1;  ?>?doctor=calendar&ajax=1&apdoctorid=<?php echo $doctor_id;?>&appointment_type=<?php echo $appointment_type;?>&speciality_id=<?php echo $doctor_speciality_id;?>&address_id=<?php echo $doctor_address_id;?>&action=fetchaddress',
				dataType: 'json',
				success: function(data) {
			
				}
			});
		
		<?php
		}?>

});
function selecttiming(){
			var dcid = $('#doctor_id').val();
			$('#appointTimes').attr('disabled', 'disabled');
			
			$.ajax({
				url: '<?php echo APPHP_BASE1;  ?>?doctor=calendar&ajax=true&aptime=<?php echo $appointment_time?>&apdoctor_id='+dcid+'&date=' + $('#appointDate').val()+'&overbooking=1',
				dataType: 'json',
				success: function(data) {
			//alert(data);
					$('#appointTimes').html(data.appointTimes);
					$('#appointTimes').removeAttr('disabled');
					$('#appointDuration').val(data.timeSlots);
				}
			});
		}
	function validatefrm(){

		var flag=true;
		if($('#patient_id').val()=='' || $('#patient_id').val()==0){
			$('#patienterror').html("Please select at least one");
			return false;
		
		}
		if($('input[name^="repeaton"]').val()!=undefined){
		flag=false;
			$('input[name^="repeaton"]').each(function(){
		
			if($(this).attr('checked')==true)
				flag=true;	
		});
		}
	
		if(!flag){
			$('#repeaterror').html("Please select at least one");
			return false;
		}
		return true;
	}

</script>
<div class="doctorLogin" style="overflow-y:scroll;height:450px;">
<div id="aptabs">
<ul>
<li><a href="#addappointmenttab">Add Appointment</a></li>
<li><a href="#viewscheduletab">Timeoff</a></li>
</ul>
<div id="addappointmenttab">
	<div style="display:none">
    
	<div id="s_newAddPatient1"  class="doctorLogin" >
		
 		<?php $objPatients = new Patients();$objPatients->DrawAddMode('index.php?provider=calendar'); ?>
 		
 	</div>
    </div>
		<form name="addappintment" id="addappintment" action="<?php echo APPHP_BASE1; ?>?doctor=calendar" method="POST" onsubmit="return validatefrm()" >
			<table cellspacing="4" cellpadding="1" border="0">
				<tbody>
					<tr>
						<td>
							<strong>Patient:</strong>
						</td>
						<td>
                        <input type="hidden" name="patient_id" id="patient_id" value="<?php echo $patient_id?>" required />
                        
							<a href="javascript:addpatient()" class="form_button" style="background-color:#F97B2C;color:#fff;ng:text-decoration: none;
padding-right: 5px;display: inline-block;" id="selectedpatient" ><span class="s_fontAwsm" style="color:#fff;" ></span>&nbsp;<?php if($_GET['mode']=='edit'){echo $first_name.' '.$last_name;}else{ echo 'Select or Add New Patient';}?></a><br/>
<span style="color:#FF0000;" id="patienterror"></span>
						</td>
						<td colspan="2">
						</td>
					</tr>
					<tr>
						<td>
							<strong>Doctor:</strong>
						</td>
						<td>
							<select name="doctor_id" id="doctor_id" required>
								<option value="">-- Select Patient --</option>
								<?php foreach ($doctors AS $doctor) : ?>
								<option value="<?php echo $doctor['id']; ?>"  <?php if($doctor_id==$doctor['id']){echo "selected='selected'";}?>><?php echo $doctor['first_name'], ' ' , $doctor['last_name']; ?></option>
								<?php endforeach; ?>
							</select>
						</td>
						<td colspan="2">
						</td>
					</tr>
					<tr>
						<td>
							<strong>Appointment Type:</strong>
						</td>
						<td id='typediv'>
							<select name="aptype" class="form_select" required>
								<option value="">-- Select Appointment Type --</option>
								 <?PHP 
								$sql = "SELECT * FROM " . APPOINTMENT_TYPE. " where active='y' AND (docid like '$doctor_id,%' or docid like '%,$doctor_id' or docid = '$doctor_id' or docid like '%,$doctor_id,%' ) order by id asc";
								$appointmenttypes = database_query($sql);
								foreach($appointmenttypes  as $appointmenttype){
								?>
								<option value="<?php echo $appointmenttype['id']?>"  <?php if($appointment_type==$appointmenttype['id']){echo "selected='selected'";}?>><?php echo $appointmenttype['type_name'];?></option>
                                <?php }
								?>
							</select>
							<br>
						</td>
						<td colspan="2">
						</td>
					</tr>
					<tr>
						<td>
							<strong>Speciality:</strong>
						</td>
						<td id='specialitydiv'>
							<select name="dspecid" class="form_select" required>
								<?php
								$sql = "SELECT s.* FROM " . TABLE_DOCTORS_SPECIALITIES . " ds LEFT JOIN " . TABLE_SPECIALITIES . " s ON ds.speciality_id = s.id WHERE doctor_id = $doctor_id ORDER BY is_default DESC, name ASC";
								$specialities = database_query($sql);
								?>
								<?php foreach ($specialities AS $speciality) : ?>
								<option value="<?php echo $speciality['id']; ?>"  <?php if($doctor_speciality_id==$speciality['id']){echo "selected='selected'";}?>><?php echo $speciality['name']; ?></option>
								<?php endforeach; ?>
							</select>
						</td>
						<td colspan="2">
						</td>
					</tr>
					<tr>
						<td>
							<strong>Address:</strong>
						</td>
						<td id='addressdiv'>
							<select name="daddid" class="form_select" required>
								<option value="">-- Select Address --</option>
								<?php
								$sql = "SELECT * FROM " . TABLE_DOCTORS_ADDRESSES . " WHERE doctor_id = $doctor_id ORDER BY priority_order ASC";
								$addresses = database_query($sql);
								?>
								<?php foreach ($addresses AS $address) : ?>
								<option value="<?php echo $address['id']; ?>" <?php if($doctor_address_id==$address['id']){echo "selected='selected'";}?>><?php echo $address['address']; ?></option>
								<?php endforeach; ?>
							</select>
						</td>
						<td colspan="2">
						</td>
					</tr>
					<tr>
						<td>
							<strong>Appointment Date:</strong>
						</td>
						<td>
							<input type="text" name="date" id="appointDate" required  value="<?php echo ($appointment_date!='')?$appointment_date:'';?>"/>
						</td>
						<td colspan="2">
						</td>
					</tr>
					<tr>
						<td>
							<strong>Appointment Time:</strong>
						</td>
						<td>
							<select name="start_time" id="appointTimes" required>
								<option value="08:00:00">08:00 AM</option>
								<option value="08:15:00">08:15 AM</option>
								<option value="08:30:00">08:30 AM</option>
								<option value="08:45:00">08:45 AM</option>
							</select>
                            &nbsp;&nbsp;Overbooking: <input type="checkbox" name="overbooking" id="overbooking" onchange="selecttiming();"
                             
						</td>
						<td colspan="2">
						</td>
					</tr>
					<tr>
						<td>
							<strong>Appointment Duration:</strong>
						</td>
						<td>
							<input type="text" name="duration" value="<?php echo ($_GET['mode']=='edit')?$visit_duration:$curTimeBlock['time_slots']; ?>" id="appointDuration" />
						</td>
						<td colspan="2">
						</td>
					</tr>
                    <?php if($_GET['mode']=='edit'){?>
                    <tr>
						<td>
							<strong>Appointment status:</strong>
						</td>
						<td>
							<select name="status" class="form_select" required>

								<?php
								$sql = "SELECT * FROM " . APPOINTMENT_STATUS . " WHERE active='y'";
								$apstatus = database_query($sql);
								?>
								<?php foreach ($apstatus as $status) : ?>
								<option value="<?php echo $status['id']; ?>" <?php if($apstatus_id==$status['id']){echo "selected='selected'";}?>><?php echo $status['status']; ?></option>
								<?php endforeach; ?>
							</select>
						</td>
						<td colspan="2">
						</td>
					</tr>
                    <?php }?>
					<tr>
						<td>
							<strong>Repeated:</strong>
						</td>
						<td>
							<input type="checkbox" name="repeated" id="appointRepeated" onchange="onRepeatedEvent();" <?php if($_GET['mode']=='edit' && $repeat==1){ echo "checked='checked'";}?>/>
						</td>
						
						<td colspan="2">
						</td>
					</tr>
                    <tr ><td>&nbsp;</td><td colspan="3">
                                <div style="border:1px solid #000000;<?php  if($_GET['mode']=='edit' && $repeat==1){?>display:block<?php }else{?>display:none<?php } ?>" id="s_newAppointRepeatModal">
								<table cellspacing="4" cellpadding="1" border="0">
									<tbody>
										<tr>
											<td >
												<strong>Repeats: </strong>
											</td>
											<td>
												<select name="repeat_id" id="repeat_id"  onchange="showrepeatdata();">
													<option value="1" <?php echo ($repeat_id==1)?'selected="selected"':'';?>>Daily</option>
													<option value="2"  <?php echo ($repeat_id==2)?'selected="selected"':'';?>>Every weekday (Monday to Friday)</option>
													<option value="3"  <?php echo ($repeat_id==3)?'selected="selected"':'';?>>Every Monday, Wednesday, and Friday</option>
													<option value="7"  <?php echo ($repeat_id==7)?'selected="selected"':'';?>  >Every Tuesday, and Thursday</option>
													<option value="4"  <?php echo ($repeat_id==4)?'selected="selected"':'';?>>Weekly</option>
													<option value="5"  <?php echo ($repeat_id==5)?'selected="selected"':'';?>>Monthly</option>
													<option value="6"  <?php echo ($repeat_id==6)?'selected="selected"':'';?>>Yearly</option>
												</select>
											</td>
											
										</tr>
                                        <tr ><td id="repeatdata" colspan="2"></td></tr>
										
                                         <tr>
											<td>
												<strong>Starts on: </strong>
											</td>
											<td>
                                            	<input type="text" name="startdate" id="startdate" value="<?php echo $startson;?>" />
											</td>
											
										</tr>
                                         <tr>
											<td>
												<strong>Ends: </strong>
											</td>
											<td>
                                            <input type="radio" name="ends"  id="ends1"  value="1" <?php echo ($ends==1)?"checked='checked'":'';?>/>Never <br />
                                            <input type="radio" name="ends" id="ends2"  value="2" <?php echo ($ends==2)?"checked='checked'":'';?>/>After <input type="text" name="after_ends" id="after_ends" value="<?php echo ($ends==2)?$after_ends:'';?>" /> 								<br/>                                            
											<input type="radio" name="ends" id="ends3" value="3" <?php echo ($ends==3)?"checked='checked'":'';?>/> On <input type="text" name="enddate" id="enddate" value="<?php echo ($ends==3)?date('Y-m-d',strtotime($endson)):'';?>" />
                                                
											</td>
											
										</tr>
                                        
									</tbody>
								</table>
							</div>							
						</td></tr>
					<tr>
						<td>&nbsp;</td>
						<td>
							<table>
								<tbody>
									<tr>
										<td>
											<button name="newmessage" type="submit" class="s_buttonForSubmit"><span class="s_fontAwsm">&#xf046;</span>Save</button>
										</td>
										<td>
											<a class="close-reveal-modal s_buttonForSubmit" onclick="jQuery.fancybox.close();"><span class="s_fontAwsm">&#xf0e2;</span>Cancel</a>
										</td>
									</tr>
								</tbody>
							</table>
						</td>
						<td colspan="2"></td>
					</tr>
				</tbody>
			</table>
            <?php if($_GET['mode']=='edit'){
			?>
			<input type="hidden" name="mg_action" id="mg_action" value="update" />
            <input type="hidden" name="mg_rid" id="mg_rid" value="<?php echo trim(htmlentities($_GET['id']));?>" />
			<?php
			}?>
		</form>
</div>        
<div id="viewscheduletab">
		<?php
		
		$objTimeoffs = new Timeoffs($doctor_id, 'me');
		echo '<div>';
		$objTimeoffs->DrawAddMode();	
		echo '</div>';
		?>
       
</div></div>
</div>

