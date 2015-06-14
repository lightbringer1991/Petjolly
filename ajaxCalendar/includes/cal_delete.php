<?php

	// Loader - class and connection
	include('loader.php');
	$id = $_POST['id'];
	$calendar->delete($id, '', '');

?>