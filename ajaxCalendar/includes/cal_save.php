<?php

	// Loader - class and connection
	include('loader.php');
	include('../../include/functions.common.inc.php');
	
	// Catch start, end and id from javascript
	$params = array(
		'docid' => $_POST['d_id'],
		'patient_id' => $_POST['c_id'],
		'date' => $_POST['appointment_date'],
		'start_time' => $_POST['appointment_time'],
		'duration' => $_POST['visit_duration'],
		'services' => $_POST['appointment_services'],
		'color' => $_POST['color'],
	);
	
	if ($params['patient_id'] == 0) { return 0; }
	
	if ($_POST['form_type'] == 'add') { echo $calendar -> addEvent($params); }
	elseif ($_POST['form_type'] == 'edit') { 
		$params['app_id'] = $_POST['app_id'];
		echo $calendar -> updates($params);
	}
?>