<?php
	session_start();
	
	// Database Connection
	include('connection.php');
	
	// Calendar Class
	include('calendar.php');
	
	// Embed Class
	include('embed.php');
	
	// Formater Class
	include('formater.php');
	
	// Google Maps
	include('maps.class.php');
	
	// Search
	if(isset($_POST['search']) && strlen($_POST['search']) !== 0)
	{
		$_SESSION['condition'] = " title LIKE '%".$_POST['search']."%' OR description LIKE '%".$_POST['search']."%'";
	} elseif(isset($_POST['search']) && strlen($_POST['search']) == '') {
		unset($_SESSION['condition']);	
	}
	
	if(isset($_SESSION['condition']) && strlen($_SESSION['condition']) !== 0) {
		$calendar = new calendar(DB_HOST, DB_USERNAME, DB_PASSWORD, DATABASE, TABLE, $_SESSION['condition']);
	} else {
		$calendar = new calendar(DB_HOST, DB_USERNAME, DB_PASSWORD, DATABASE, TABLE);		
	}
	
?>