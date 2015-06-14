<?php
	// Database Connection
	include('connection.php');
	include('database.class.php');
	$db = new ConnectMe(DB_HOST, DB_USERNAME, DB_PASSWORD, DATABASE);

	$first_name = $db -> escape($_POST['fname']);
	$last_name = $db -> escape($_POST['lname']);
	$email = $db -> escape($_POST['email']);
	$phone = $db -> escape($_POST['phone']);
	$provider = $db -> escape($_POST['providerID']);
	
	function addToProvidersCustomers($db, $providerID, $customerID) {
		$db -> query("INSERT INTO `providers_customers`(`provider_id`, `customer_id`) VALUES($providerID, $customerID)");
	}
	
	$result = $db -> query("SELECT `id` FROM `meda_patients` WHERE `email`='$email' OR `phone`='$phone'");
	if ($db -> num_rows($result) > 0) { 			// patient already exists in `meda_patients` table
		$r = $db -> fetch_row($result);
		$queryOutput = $db -> query("SELECT `provider_id` FROM `providers_customers` WHERE `customer_id`='{$r['id']}'");
		if ($db -> num_rows($queryOutput) > 0) { echo -1; }
		else {
			addToProvidersCustomers($db, $provider, $r['id']);
			echo $r['id'];
		}
	}
	else {
		$db -> query("INSERT INTO `meda_patients`(`first_name`, `last_name`, `email`, `phone`) VALUES ('$first_name', '$last_name', '$email', '$phone')");
		$result = $db -> query("SELECT `id` FROM `meda_patients` WHERE `email`='$email' AND `phone`='$phone'");
		$r = $db -> fetch_row($result);
		addToProvidersCustomers($db, $provider, $r['id']);
		echo $r['id'];
	}
?>