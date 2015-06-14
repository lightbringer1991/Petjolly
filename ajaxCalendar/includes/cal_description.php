<?php
// Loader - class and connection
include('loader.php');

$c = $calendar->get_event($_POST['id']);

if ($c == false) {
	echo '';
} else {
	$array = array(
		'customer_name' => $c['first_name'] . " " . $c['last_name'],
		'customer_id' => $c['customer_id'],
		'start_date' => $c['appointment_date'],
		'start_time' => $c['appointment_time'],
		'duration' => $c['visit_duration'],
		'color' => $c['color'],
		'speciality' => $c['speciality_list']
	);
	if (isset($_POST['mode']) && $_POST['mode'] == 'getInfo') {	
		echo json_encode($array);
	} else {
		echo '<b>Customer Name: </b>' . $array['customer_name'] . "<br />" . 
			'<b> Appointment Time: </b>' . $array['start_date'] . " " . $array['start_time'] . '<br />' . 
			'<b> Duration: </b>' . $array['duration'] . '<br />';
	}
}
?>