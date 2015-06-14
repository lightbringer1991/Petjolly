<?php

	// Loader - class and connection
	include('loader.php');

	// Catch start, end and id from javascript
	$start = strtotime($_POST['start']);
	$end = strtotime($_POST['end']);
	$interval = ($end - $start) / 60;
	
	$params = array(
		'id' => $_POST['original_id'],
		'start_date' => date('Y-m-d', $start),
		'start_time' => date('H:i:s', $start),
		'duration' => $interval,
	);
	
	echo $calendar->update($params);

?>