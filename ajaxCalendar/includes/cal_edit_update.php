<?php

	// Loader - class and connection
	include('loader.php');
/*
	// Catch post data from edit modal form
	$event = array(
		'id' => $_POST['id'],
		'title' => $_POST['title'],
		'description' => $_POST['description'],
		'start_date' => $_POST['start_date'],
		'start_time' => $_POST['start_time'],
		'duration' => $_POST['duration']
	);
	
	if(isset($_POST['url'])) 
	{
		$event['url'] = $_POST['url'];
	} else {
		$event['url'] = 'false';	
	}
	
	if(isset($_POST['rep_id']) && isset($_POST['method']) && $_POST['method'] == 'repetitive_event')
	{
		$event['rep_id'] = $_POST['rep_id'];	
	}
	
	if(isset($_POST['category']))
	{
		$event['category'] = $_POST['category'];
	} else {
		$event['category'] = '';	
	}
	
	if(strtotime($event['end_date']) < strtotime($event['start_date']))
	{
		return false;	
	}
	
	if($calendar->updates($params) === true) {
		return true;	
	} else {
		return false;	
	}
*/	
		
	$params = array(
		'id' => $_POST['id'],
		'date' => $_POST['start_date'],
		'start_time' => $_POST['start_time'],
		'duration' => $_POST['duration'],
	);
	
	return $calendar -> updates($params);

?>