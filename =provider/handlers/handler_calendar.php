<?php

$doctor_id = Session::Get('session_account_id');
$appointsTable = TABLE_APPOINTMENTS;
$patientsTable = TABLE_PATIENTS;

$post=array();
foreach (explode('&', file_get_contents('php://input')) as $keyValuePair) {
	if(strstr($keyValuePair,'mg_action=')!='' || strstr($keyValuePair,'mg_rid=')!='' ){
    list($key, $value) = explode('=', $keyValuePair);
    $post[$key][] = $value;
	}
}


$action = ($_POST['mg_action']!='')?$_POST['mg_action']:$post['mg_action'][0];
$rid = ($_POST['mg_rid']!='')?$_POST['mg_rid']:$post['mg_rid'][0];
if($action=='update'){
		$objAppointments = new Appointments();
		if($objAppointments->UpdateRecord($rid)){
			$msg = draw_success_message(_UPDATING_OPERATION_COMPLETED, false);
			$mode = 'view';
		}else{
			$msg = draw_important_message($objAppointments->error, false);
			$mode = 'edit';
		}		
}
function output_json($data) {	
	echo json_encode($data); exit;
}


$date = !empty($_GET['date']) ? date('Y-m-d', strtotime($_GET['date'])) : date('Y-m-d');
list($year, $month, $day) = explode('-', $date);

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
if($_GET['action']=="addapp" && $_GET['ajax']==1){
//print_r($_POST);
	$appointNum = strtoupper(get_random_string(10));
	$appointDesc = 'Appointment with doctor';
	$visitPrice = '';
	$apdate = 	date('Y-m-d',strtotime($_POST['apptStartTime']));
	$aptime = 	date('H:i:s',strtotime($_POST['apptStartTime']));	
	$duration = $curTimeBlock['time_slots'];
	$sql = "INSERT INTO " . TABLE_APPOINTMENTS . " VALUES('', '$appointNum', '$appointDesc', '$_POST[aptype]', '$doctor_id', '$_POST[dspecid]', '$doctor_id', '$_POST[cpatient_id]', NOW(), '$apdate', '$aptime', '$duration', '$visitPrice', '$doctorNotes', '$patientNotes', 0, 0, 0, '0000-00-00 00:00:00', 0, 0, 0)";
	database_void_query($sql);
	$sql1 = "SELECT DISTINCT mdo_patients.id, first_name, last_name
	FROM mdo_patients	
	WHERE id= '$_POST[cpatient_id]' ORDER BY mdo_patients.first_name ASC";
	$patients = database_query($sql1,DATA_AND_ROWS, FIRST_ROW_ONLY);
	$patient = $patients[0];
	$patientname =  $patient['first_name'].' '.$patient['last_name'];
	echo $patientname."&&&##&&&";
	echo $msg = draw_success_message(_APPOINTMENT_SUCCESS_BOOKED_DOCTOR, false);
	exit;
}

if($_GET['action']=="fetchaddress" && $_GET['ajax']==1){

			$apdoctorid =  $_GET['apdoctorid'];
			$return['type'] = '<select name="aptype" class="form_select" required><option value="">-- Select Appointment Type --</option>';
			$sql = "SELECT * FROM " . APPOINTMENT_TYPE. " where active='y' AND (docid like '$apdoctorid,%' or docid like '%,$apdoctorid' or docid = '$apdoctorid' or docid like '%,$apdoctorid,%' ) order by id asc";
			$appointmenttypes = database_query($sql); 
			foreach($appointmenttypes  as $appointmenttype){
			$sel1='';if($_GET['appointment_type']==$appointmenttype['id']){$sel1 =  "selected='selected'";} 
			$return['type'] .= '<option value="'.$appointmenttype['id'].'"  '.$sel1.'>'.$appointmenttype['type_name'].'</option>';
			 
			 }
			$return['type'] .=  '</select>'; 
			$return['speciality'] = '<select name="dspecid" class="form_select" required>';		
			$sql = "SELECT s.* FROM " . TABLE_DOCTORS_SPECIALITIES . " ds LEFT JOIN " . TABLE_SPECIALITIES . " s ON ds.speciality_id = s.id WHERE doctor_id = $apdoctorid ORDER BY is_default DESC, name ASC";
			$specialities = database_query($sql);
			foreach ($specialities AS $speciality){ 
			$sel2='';if($_GET['speciality_id']==$speciality['id']){$sel2 =  "selected='selected'";} 
			$return['speciality'] .= '<option value="'.$speciality['id'].'"  '.$sel2.'>'.$speciality['name'].'</option>';
			
			 }
			 $return['speciality'] .=  '</select>';
			 $return['address'] = '<select name="daddid" class="form_select" required>
			 <option value="">-- Select Address --</option>';
			$sql = "SELECT * FROM " . TABLE_DOCTORS_ADDRESSES . " WHERE doctor_id = $apdoctorid ORDER BY priority_order ASC";
			$addresses = database_query($sql); 
			foreach ($addresses AS $address) {
			$sel3='';if($_GET['address_id']==$address['id']){$sel3 =  "selected='selected'";} 
			 $return['address'] .= '<option value="'.$address['id'].'"  '.$sel3.'>'.$address['address'].'</option>';			
			 }
			$return['address'] .=  '</select>';
			
			echo json_encode( $return);
			exit;
}

$sql = "SELECT * FROM " . TABLE_TIMEOFFS . " WHERE doctor_id = $doctor_id";
$docTimeOffs = database_query($sql);
foreach ($docTimeOffs AS $docTimeOff) {
	$timeOffStart = $docTimeOff['date_from'] . ' ' . $docTimeOff['time_from'];
	$timeOffEnd = $docTimeOff['date_to'] . ' ' . $docTimeOff['time_to'];
	
	$docAllTimeOff = array();
	if ('00:00:00' == $docTimeOff['time_from'] && $docTimeOff['date_to'] == date('Y-m-d', strtotime($docTimeOff['date_from'] . ' +1 day'))) {
		$docAllTimeOff = true;
	}
}
// handle calendar populate requests
if ($_GET['resorces']==1) {
	$sql = "SELECT DISTINCT id, first_name, last_name
	FROM mdo_doctors WHERE is_active=1";
	$doctors = database_query($sql);	

	foreach($doctors as $doctor){
		$resources[]  = array("name" => $doctor['first_name'].' '.$doctor['last_name'],"id"=>"res".$doctor['id']);

	}
	echo json_encode($resources);exit;
}
if (!empty($_GET['start']) && !empty($_GET['end']) || (!empty($_GET['aptype'])  || !empty($_GET['apaddress']) || !empty($_GET['apdoctorid']) || !empty($_GET['apresorces'])) || !empty($_GET['apreports'])) {
	$doctor_id = Session::Get('session_account_id');
	
	$start = date('Y-m-d', $_GET['start']);
	$end = date('Y-m-d', $_GET['end']);
	$aptype =  trim($_GET['aptype']);
	$apaddress =  trim($_GET['apaddress']);
	$doctorid =  trim($_GET['apdoctorid']);

	$sql = "
		SELECT
			$appointsTable.id,$appointsTable.doctor_id,$appointsTable.doctor_address_id,$appointsTable.appointment_type,$appointsTable.appointment_date, $appointsTable.appointment_time, $appointsTable.visit_duration,
			$patientsTable.first_name, $patientsTable.last_name,concat(doc.first_name,' ',doc.last_name) as doctor_name,aptype.type_name as type_name
		FROM $appointsTable
		LEFT JOIN $patientsTable		
		ON $patientsTable.id = $appointsTable.patient_id
		LEFT JOIN mdo_doctors doc	
		ON doc.id = $appointsTable.doctor_id
		LEFT JOIN mdo_appointment_type aptype on aptype.id=$appointsTable.appointment_type
		WHERE 1=1  ";
	if(!empty($_GET['start']) && !empty($_GET['end']))	
	$sql .= " and $appointsTable.appointment_date BETWEEN '$start' AND '$end'";
	if($aptype!='')	
	$sql .= " and $appointsTable.appointment_type ='$aptype'";
	if($apaddress!='')	
	$sql .= " and $appointsTable.doctor_address_id ='$apaddress'";
	if($_GET['apresorces']!=1){
	if($doctorid!='')	
	$sql .= " AND $appointsTable.doctor_id = " . $doctorid . "	";
	else
	$sql .= " #AND $appointsTable.doctor_id = " . $doctor_id . "	";
	}
	$appointments = database_query($sql);
	$json_array = array();
	$ii=0;
	foreach ($appointments AS $appointment) {
		
		$appointStart = $appointment['appointment_date'] .  ' ' . $appointment['appointment_time'];
		$appointEnd   = date('Y-m-d H:i:s', strtotime($appointStart) + ($appointment['visit_duration']*60));
		$patient_name = $appointment['first_name'] . ' ' . $appointment['last_name'];
		$appoint_time = date('H:i a', strtotime($appointment['appointment_time']));
		$appoint_type = $appointment['appointment_type'];
		
		$json_array[] = array(
			'id' => 'app-' . $appointment['id'],
			'title' => "$patient_name",
			'start' => $appointStart,
			'end' => $appointEnd,
			'url' => APPHP_BASE . '?doctor=appointments&mg_action=details&mg_rid='.$appointment['id'],
			'allDay' => false,
			'description' => date('h:i A',strtotime($appointment['appointment_time']))."<br/>Doctor Name:".$appointment['doctor_name']."<br/>Patient Name:".$patient_name."<br/>Appointment Type: ".$appointment['type_name']."<br/>",
			'class' => 'appoint ap'.$appoint_type
		);

		if($_GET['apresorces']==1){
			$json_array[$ii]['resource']="res".$appointment['doctor_id'];
		}
		if($_GET['apreports']==1){
			$json_array[$ii]['appdate']=$appointment['appointment_date'];
		}	


		$ii++;
		
	}
	
	// get repeated events
	  
		$firstDay = $_GET['start'];
		$lastDay = $_GET['end'];
		$sql = "SELECT * FROM  " . TABLE_APPOINTMENTS . "_repeat apr inner join $appointsTable on apr.app_id=$appointsTable.id  WHERE  if(apr.ends=3,apr.endson>'".date('Y-m-d',$firstDay)."',apr.endson='0000-00-00 00:00:00') ";
		if($aptype!='')	
		$sql .= " and $appointsTable.appointment_type ='$aptype'";
		if($apaddress!='')	
		$sql .= " and $appointsTable.doctor_address_id ='$apaddress'";
		if($_GET['apresorces']!=1){
		if($doctorid!='')	
		$sql .= " AND apr.doctor_id = " . $doctorid . "	";
		else
		$sql .= " and apr.doctor_id='$doctor_id'";
		}
		$repeatedapps = database_query($sql);
		
		if(count($repeatedapps)>0){
			foreach($repeatedapps as $repeatapp){
				$sql = "SELECT	$appointsTable.id,$appointsTable.doctor_id,$appointsTable.doctor_address_id,$appointsTable.appointment_type, $appointsTable.appointment_date, $appointsTable.appointment_time, $appointsTable.visit_duration,
					$patientsTable.first_name, $patientsTable.last_name,concat(doc.first_name,' ',doc.last_name) as doctor_name,aptype.type_name as type_name
				FROM $appointsTable
				LEFT JOIN $patientsTable				
				ON $patientsTable.id = $appointsTable.patient_id
				 LEFT JOIN mdo_doctors doc	
		ON doc.id = $appointsTable.doctor_id LEFT JOIN mdo_appointment_type aptype on aptype.id=$appointsTable.appointment_type
				WHERE 1=1  and $appointsTable.id= ".$repeatapp['app_id'];
				$appointment = database_query($sql,DATA_AND_ROWS, FIRST_ROW_ONLY);
				$appointment = $appointment[0];
				$appoint_type = $appointment['appointment_type'];
				$patient_name = $appointment['first_name'] . ' ' . $appointment['last_name'];
				for($i=$firstDay;$i<=$lastDay;$i=strtotime('+1 day', $i) ){
					$repeat=false;
					$appointStart = date('Y-m-d',$i). ' ' . $appointment['appointment_time'];
					$appointEnd = date('Y-m-d H:i:s', strtotime($appointStart) + ($appointment['visit_duration']*60));

					if($i>strtotime($repeatapp['startson']) && !in_array(date('D',$i),$doctorWeekends)){
						$continee = 0;
						if($repeatapp['repeat_id']==1){
							$continee=1;
						}
						if($repeatapp['repeat_id']==2 || $repeatapp['repeat_id']==3 || $repeatapp['repeat_id']==7){
							if(in_array(date('D',$i),explode(',',$repeatapp['repeat_on']))){
								$continee=1;
							}							
						}
						if($repeatapp['repeat_id']==4){							
							$date1 = strtotime($repeatapp['startson']);	
							$date2= $i;	
							$nrSeconds = abs($date2 - $date1);
							$nrWeeksPassed = floor($nrSeconds / 604800); 
							$nrWeeksPassed = ceil($nrWeeksPassed%4);
							$repeatedweek = 0;

							if($nrWeeksPassed < $repeatapp['repeat_every']){
								if(in_array(date('D',$i),explode(',',$repeatapp['repeat_on']))){
									$repeatedweek=1;
								}
							}
							if($repeatedweek==1){
								$continee=1;								
							}
						}
						if($repeatapp['repeat_id']==4){							
							$date1 = strtotime($repeatapp['startson']);	
							$date2= $i;	
							$nrSeconds = abs($date2 - $date1);
							$nrWeeksPassed = floor($nrSeconds / 604800); 
							$nrWeeksPassed = ceil($nrWeeksPassed%4);
							$repeatedweek = 0;

							if($nrWeeksPassed < $repeatapp['repeat_every']){
								if(in_array(date('D',$i),explode(',',$repeatapp['repeat_on']))){
									$repeatedweek=1;
								}
							}
							if($repeatedweek==1){
								$continee=1;								
							}
						}
						if($repeatapp['repeat_id']==5){	
							$date1 = strtotime($appointment['appointment_date']);	
							$date2= $i;	
							$nrSeconds = abs($date2 - $date1);
							$nrmonthsPassed = floor($nrSeconds / 86400 / 30); 							
							if(($nrmonthsPassed%$repeatapp['repeat_every']) ==0){
							if(date('d',$i) == date('d', strtotime($appointment['appointment_date']))){
								$continee=1;								
							}
							}
						}
						if($repeatapp['repeat_id']==6){	

							$date1 = strtotime($appointment['appointment_date']);	
							$date2= $i;	
							$nrSeconds = abs($date2 - $date1);
							$nryearssPassed = floor($nrSeconds / (365*60*60*24));							
							
							if(($nryearssPassed%$repeatapp['repeat_every'])==0){
						
							if(date('m-d',$i) == date('m-d', strtotime($appointment['appointment_date']))){
								$continee=1;								
							}
							}
						}
						
						
						if($continee==1){
							if($repeatapp['ends']==1){								
								$repeat = true;
							}
							if($repeatapp['ends']==2){							
								$date1 = strtotime($repeatapp['startson']);	
								$date2= $i;	
								$nrSeconds = abs($date2 - $date1);
								$nrWeeksPassed = floor($nrSeconds / 604800); 
								if($nrWeeksPassed < $repeatapp['after_ends']){
									$repeat = true;
								}
							}
							if($repeatapp['ends']==3){							
								if($i <=  strtotime($repeatapp['endson']) ){	
									$repeat = true;
								}
							}	
						}
					}
					if($repeat)
					{
						$json_array[] = array(
									'id' => 'app-' . $appointment['id'],
									'title' => "$patient_name",
									'start' => $appointStart,
									'end' => $appointEnd,
									'url' => APPHP_BASE . '?doctor=appointments&mg_action=details&mg_rid='.$appointment['id'],
									'allDay' => false,
									'description' => date('h:i A',strtotime($appointment['appointment_time']))."<br/>Doctor Name:".$appointment['doctor_name']."<br/>Patient Name:".$patient_name."<br/>Appointment Type: ".$appointment['type_name']."<br/>",
									'class' => 'appoint ap'.$appoint_type,
						);
						if($_GET['apresorces']==1){ 
							$json_array[$ii]['resource']="res".$appointment['doctor_id'];
						}	
						if($_GET['apreports']==1){
							$json_array[$ii]['appdate']=date('Y-m-d',strtotime($appointStart));
						}	
						$ii++;

					}
					}
				}
			}
		
	$sql = "SELECT * FROM " . TABLE_TIMEOFFS . " WHERE  (date_from BETWEEN '$start' AND '$end') ";
	if($_GET['apresorces']!=1){
	if($doctorid!='')	
	$sql .= " #AND doctor_id = " . $doctorid . "	";
	else
	$sql .= " and doctor_id='$doctor_id'";
	}
	$timeOffs = database_query($sql);
	foreach ($timeOffs AS $timeOff) {
		$timeOffStart = $timeOff['date_from'] . ' ' . $timeOff['time_from'];
		$timeOffEnd = $timeOff['date_to'] . ' ' . $timeOff['time_to'];
		
		$timeOffAllDay = false;
		if ('00:00:00' == $timeOff['time_from'] && $timeOff['date_to'] == date('Y-m-d', strtotime($timeOff['date_from'] . ' +1 day'))) {
			$timeOffAllDay = true;
		}
		
		$json_array[] = array(
			'id' => 'to-' . $timeOff['id'],
			'title' => $timeOff['description'],
			'start' => $timeOffStart,
			'end' => $timeOffEnd,
			'allDay' => $timeOffAllDay,
			'description' => "",
			'class' => 'timeoff',
		);
		if($_GET['apresorces']==1){
			$json_array[$ii]['resource']="res".$timeOff['doctor_id'];
		}	
			
		$ii++;
	}
	
	output_json($json_array);
}

if (!empty($_GET['ajax'])) {
	$doctor_id= $_GET['apdoctor_id'];
	$appointsTable = TABLE_APPOINTMENTS ;
	
		$sql = "SELECT * FROM  " . TABLE_APPOINTMENTS . "_repeat apr inner join mdo_appointments map on apr.app_id=map.id  WHERE  if(apr.ends=3,apr.endson>'".date('Y-m-d',strtotime($date))."',apr.endson='0000-00-00 00:00:00') and apr.doctor_id= $doctor_id";
		
		$repeatedapps = database_query($sql);
		
		if(count($repeatedapps)>0){
			$bookedtime = array();
			foreach($repeatedapps as $repeatapp){
				 $sql = "SELECT	$appointsTable.id,$appointsTable.doctor_id,$appointsTable.doctor_address_id,$appointsTable.appointment_type, $appointsTable.appointment_date, $appointsTable.appointment_time, $appointsTable.visit_duration,
					$patientsTable.first_name, $patientsTable.last_name,concat(doc.first_name,' ',doc.last_name) as doctor_name,aptype.type_name as type_name
				FROM $appointsTable
				LEFT JOIN $patientsTable				
				ON $patientsTable.id = $appointsTable.patient_id
				 LEFT JOIN mdo_doctors doc	
		ON doc.id = $appointsTable.doctor_id LEFT JOIN mdo_appointment_type aptype on aptype.id=$appointsTable.appointment_type
				WHERE 1=1  and $appointsTable.id= ".$repeatapp['app_id']." ";
				$appointment = database_query($sql,DATA_AND_ROWS, FIRST_ROW_ONLY);
				$appointment = $appointment[0];
				$appoint_type = $appointment['appointment_type'];
				$patient_name = $appointment['first_name'] . ' ' . $appointment['last_name'];
					$i=strtotime($date);
					$repeat=false;
					$appointStart = date('Y-m-d',$i). ' ' . $appointment['appointment_time'];
					$appointEnd = date('Y-m-d H:i:s', strtotime($appointStart) + ($appointment['visit_duration']*60));

					if($i>strtotime($repeatapp['startson']) && !in_array(date('D',$i),$doctorWeekends)){
						$continee = 0;
						if($repeatapp['repeat_id']==1){
							$continee=1;
						}
						if($repeatapp['repeat_id']==2 || $repeatapp['repeat_id']==3 || $repeatapp['repeat_id']==7){
							if(in_array(date('D',$i),explode(',',$repeatapp['repeat_on']))){
								$continee=1;
							}							
						}
						if($repeatapp['repeat_id']==4){							
							$date1 = strtotime($repeatapp['startson']);	
							$date2= $i;	
							$nrSeconds = abs($date2 - $date1);
							$nrWeeksPassed = floor($nrSeconds / 604800); 
							$nrWeeksPassed = ceil($nrWeeksPassed%4);
							$repeatedweek = 0;

							if($nrWeeksPassed < $repeatapp['repeat_every']){
								if(in_array(date('D',$i),explode(',',$repeatapp['repeat_on']))){
									$repeatedweek=1;
								}
							}
							if($repeatedweek==1){
								$continee=1;								
							}
						}
						if($repeatapp['repeat_id']==4){							
							$date1 = strtotime($repeatapp['startson']);	
							$date2= $i;	
							$nrSeconds = abs($date2 - $date1);
							$nrWeeksPassed = floor($nrSeconds / 604800); 
							$nrWeeksPassed = ceil($nrWeeksPassed%4);
							$repeatedweek = 0;

							if($nrWeeksPassed < $repeatapp['repeat_every']){
								if(in_array(date('D',$i),explode(',',$repeatapp['repeat_on']))){
									$repeatedweek=1;
								}
							}
							if($repeatedweek==1){
								$continee=1;								
							}
						}
						if($repeatapp['repeat_id']==5){	
							$date1 = strtotime($appointment['appointment_date']);	
							$date2= $i;	
							$nrSeconds = abs($date2 - $date1);
							$nrmonthsPassed = floor($nrSeconds / 86400 / 30); 							
							if(($nrmonthsPassed%$repeatapp['repeat_every']) ==0){
							if(date('d',$i) == date('d', strtotime($appointment['appointment_date']))){
								$continee=1;								
							}
							}
						}
						if($repeatapp['repeat_id']==6){	

							$date1 = strtotime($appointment['appointment_date']);	
							$date2= $i;	
							$nrSeconds = abs($date2 - $date1);
							$nryearssPassed = floor($nrSeconds / (365*60*60*24));							
							
							if(($nryearssPassed%$repeatapp['repeat_every'])==0){
						
							if(date('m-d',$i) == date('m-d', strtotime($appointment['appointment_date']))){
								$continee=1;								
							}
							}
						}
						
						
						if($continee==1){
							if($repeatapp['ends']==1){								
								$repeat = true;
							}
							if($repeatapp['ends']==2){							
								$date1 = strtotime($repeatapp['startson']);	
								$date2= $i;	
								$nrSeconds = abs($date2 - $date1);
								$nrWeeksPassed = floor($nrSeconds / 604800); 
								if($nrWeeksPassed < $repeatapp['after_ends']){
									$repeat = true;
								}
							}
							if($repeatapp['ends']==3){							
								if($i <=  strtotime($repeatapp['endson']) ){	
									$repeat = true;
								}
							}	
						}
					}
					if($repeat)
					{
						$bookedtime[] = array('start'=>$appointment['appointment_time'],'end'=>date('H:i:s',strtotime($appointment['appointment_time']." +".$appointment['visit_duration']." minutes")));

					}
					}
				
			}
	
	$sql = "SELECT * FROM " . TABLE_TIMEOFFS . " WHERE doctor_id = $doctor_id AND ('$date' >= date_from AND '$date' <= date_to)";
	$timeOff = database_query($sql, DATA_ONLY, FIRST_ROW);
	//echo '<pre>'; print_r($timeOff); exit;
	
	list($fromHour, $fromMinute) = explode(':', $curTimeBlock['time_from']);
	list($toHour, $toMinute) = explode(':', $curTimeBlock['time_to']);
	$appointTimes = '';
	for ($i = $fromHour; $i < $toHour; $i++) {
		// timeoff starts before $date? No appoint timmes to show.
		if (!empty($timeOff) && $date > $timeOff['date_from']) {
			break;
		}
 
		for ($j = 0; $j < (60 / $curTimeBlock['time_slots']); $j++) {
			$appointHour = str_pad($i, 2, 0, STR_PAD_LEFT);
			$appointMinute = str_pad($curTimeBlock['time_slots'] * $j, 2, 0);
			$appointTimeVal = "$appointHour:$appointMinute:00";
			$appointTimeStr = date('h:i A', strtotime($appointTimeVal));
			if(empty($_GET['overbooking'])){
			$sql1 = "SELECT * FROM " . TABLE_APPOINTMENTS . " WHERE doctor_id = $doctor_id AND ('$date' = appointment_date AND (appointment_time ='".$appointTimeVal."' || '".$appointTimeVal."' between appointment_time and DATE_ADD(appointment_time, INTERVAL visit_duration MINUTE)))";
			$result1 = mysql_query($sql1);

			if(mysql_num_rows($result1)>0)
				continue;
			$break=0;	

			foreach($bookedtime as $booked){
				
				if(($booked['start']==$appointTimeVal || ($appointTimeVal>=$booked['start'] and $appointTimeVal<$booked['end']))){
					$break=1;break;
				}
			}	
			if($break==1)
				continue;
			}
			if ($timeOff['time_from'] <= $appointTimeVal.':00' && $timeOff['time_to'] >= $appointTimeVal.':00') {
				continue;
			}
			
			$selected='';
			
			if($_GET['aptime']!='' && date('h:i A',strtotime($_GET['aptime'])) == $appointTimeStr ){
				$selected = 'selected="selected"';
			}
			$appointTimes .= "<option value='$appointHour:$appointMinute:00' $selected >$appointTimeStr</option>\n";
		}
	}
	output_json(array(
		'appointTimes' => $appointTimes,
		'timeSlots' => $curTimeBlock['time_slots'],
	));
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
$pageview = mysql_real_escape_string($_GET['pageview']);
if($pageview == '' && $action=='create'){
		
		$objPatients = new Patients();
		if($objPatients->AddRecord()){
			$msg = draw_success_message(_ADDING_OPERATION_COMPLETED, false);
			$mode = 'view';
		}else{
			$msg = draw_important_message($objPatients->error, false);
			$mode = 'add';
		}
		
	
}else if($pageview=='schedule'){
	$action 	= $_POST['mg_action'];
	$operation 	= $_POST['mg_opearation'];
	$operation_field =  $_POST['mg_operation_field'];
	$rid    	= $_POST['mg_rid'];
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
	}
}else if($pageview=='timeoff'){

	$action 	= $_POST['mg_action'];
	$operation 	= $_POST['mg_opearation'];
	$operation_field =  $_POST['mg_operation_field'];
	$rid    	= $_POST['mg_rid'];
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
	}
}else if (!empty($_POST) && $action!='edit' && $action!='update' && $action!='view' ) {
	$appointNum = strtoupper(get_random_string(10));
	$appointDesc = 'Appointment with doctor';
	$visitPrice = '';
	$doctorNotes = $patientNotes = '';
	$sql = "INSERT INTO " . TABLE_APPOINTMENTS . " VALUES('', '$appointNum', '$appointDesc', '$_POST[aptype]', '$_POST[doctor_id]', '$_POST[dspecid]', '$_POST[daddid]', '$_POST[patient_id]', NOW(), '$_POST[date]', '$_POST[start_time]', '$_POST[duration]', '$visitPrice', '$doctorNotes', '$patientNotes', 0, 0, 0, '0000-00-00 00:00:00', 0, 0, 0)";
	database_void_query($sql);
	$appid  = mysql_insert_id();
	if($_POST['repeat_id']==2){
		$_POST['repeaton'] = array('Mon','Tue','Wed','Thu','Fri');
	}
	if($_POST['repeat_id']==3){
		$_POST['repeaton'] = array('Mon','Wed','Fri');
	}
	if($_POST['repeat_id']==7){
		$_POST['repeaton'] = array('Tue','Thu');
	}
	if(is_array($_POST['repeaton'])){
	$_POST['repeaton'] = implode(',',$_POST['repeaton']);
	}	
	if($_POST['repeated']=='on'){
	$sql = "INSERT INTO " . TABLE_APPOINTMENTS . "_repeat VALUES('', '$appid','$_POST[doctor_id]', '$_POST[repeat_id]', '$_POST[repeat_every]', '$_POST[repeaton]', '$_POST[startdate]', '$_POST[ends]', '$_POST[after_ends]',  '$_POST[enddate]',NOW())";
	database_void_query($sql);	
	}
	$msg = draw_success_message(_APPOINTMENT_SUCCESS_BOOKED_DOCTOR, false);
	return;
}else if (!empty($_POST) && $action=='update' ) {
	$appid =  $_POST['mg_rid'];
	

	$visitPrice = '';
	$doctorNotes = $patientNotes = '';
	$sql = "update " . TABLE_APPOINTMENTS . "  set appointment_type='$_POST[aptype]', doctor_id='$_POST[doctor_id]', doctor_speciality_id='$_POST[dspecid]', doctor_address_id='$_POST[daddid]', patient_id='$_POST[patient_id]', appointment_date= '$_POST[date]', appointment_time='$_POST[start_time]', visit_duration='$_POST[duration]', doctor_notes='$doctorNotes', patient_notes='$patientNotes', status='$_POST[status]',status_changed= NOW()  where id=".$appid;
	database_void_query($sql);
	
	if($_POST['repeat_id']==2){
		$_POST['repeaton'] = array('Mon','Tue','Wed','Thu','Fri');
	}
	if($_POST['repeat_id']==3){
		$_POST['repeaton'] = array('Mon','Wed','Fri');
	}
	if($_POST['repeat_id']==7){
		$_POST['repeaton'] = array('Tue','Thu');
	}
	if(is_array($_POST['repeaton'])){
	$_POST['repeaton'] = implode(',',$_POST['repeaton']);
	}
	//print_r($_POST);
	if($_POST['repeated']=='on'){
	$select = mysql_query("select * from " . TABLE_APPOINTMENTS . "_repeat where app_id='$appid'");
	if(mysql_affected_rows()>0){
		$sql = "update " . TABLE_APPOINTMENTS . "_repeat set doctor_id='$_POST[doctor_id]', repeat_id='$_POST[repeat_id]', repeat_every='$_POST[repeat_every]', repeat_on='$_POST[repeaton]', startson='$_POST[startdate]', ends='$_POST[ends]', after_ends='$_POST[after_ends]',  endson='$_POST[enddate]' where app_id='$appid'";
		database_void_query($sql);
		}else{
		$sql = "INSERT INTO " . TABLE_APPOINTMENTS . "_repeat VALUES('', '$appid','$_POST[doctor_id]', '$_POST[repeat_id]', '$_POST[repeat_every]', '$_POST[repeaton]', '$_POST[startdate]', '$_POST[ends]', '$_POST[after_ends]',  '$_POST[enddate]',NOW())";
		database_void_query($sql);	
	}
	}
	$msg = draw_success_message(_UPDATING_OPERATION_COMPLETED, false);
	return;
}
