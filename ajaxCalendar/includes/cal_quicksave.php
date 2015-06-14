<?php
	// Loader - class and connection
	include('loader.php');
	include('../../include/functions.common.inc.php');
	
	// Catch start, end and id from javascript
	$params = array(
		'docid' => $_POST['d_id'],
		'patient_id' => $_POST['pid'],
		'date' => $_POST['start_date'],
		'start_time' => $_POST['start_time'],
		'duration' => $_POST['duration'],
	);
	
	echo $calendar -> addEvent($params);
?>