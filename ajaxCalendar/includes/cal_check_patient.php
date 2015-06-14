<?php
include('connection.php');

$connection = mysqli_connect(DB_HOST, DB_USERNAME, DB_PASSWORD, DATABASE);
mysqli_query($connection, "SET NAMES 'utf8'");
mysqli_query($connection, 'SET character_set_connection=utf8');
mysqli_query($connection, 'SET character_set_client=utf8');
mysqli_query($connection, 'SET character_set_results=utf8');

$email = mysqli_real_escape_string($connection, $_POST['email']);

$result = mysqli_query($connection, "SELECT `id` FROM `meda_patients` WHERE `email`='$email'");
if (mysqli_num_rows($result) == 0) { echo -1; }
else {
	$r = mysqli_fetch_array($result, MYSQLI_ASSOC);
	echo $r['id'];
}

?>