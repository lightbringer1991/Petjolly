<?php
define('APPHP_EXEC', 'access allowed');
define('APPHP_CONNECT', 'direct');
require_once('../include/base.inc.php');
require_once('../include/connection.php');

$database_connection = mysqli_connect(DATABASE_HOST, DATABASE_USERNAME, DATABASE_PASSWORD, DATABASE_NAME);
$option = isset($_POST['option']) ? mysqli_real_escape_string($database_connection, $_POST['option']) : '';
$id = isset($_POST['id']) ? mysqli_real_escape_string($database_connection, $_POST['id']) : '';
$petId=isset($_POST['petId']) ? mysqli_real_escape_string($database_connection, $_POST['petId']) : '';
switch ($option) {
	case "update":
		$fname = isset($_POST['fname']) ? mysqli_real_escape_string($database_connection, $_POST['fname']) : '';
		$lname = isset($_POST['lname']) ? mysqli_real_escape_string($database_connection, $_POST['lname']) : '';
		$address1 = isset($_POST['address1']) ? mysqli_real_escape_string($database_connection, $_POST['address1']) : '';
		$address2 = isset($_POST['address2']) ? mysqli_real_escape_string($database_connection, $_POST['address2']) : '';
		$city = isset($_POST['city']) ? mysqli_real_escape_string($database_connection, $_POST['city']) : '';
		$state = isset($_POST['state']) ? mysqli_real_escape_string($database_connection, $_POST['state']) : '';
		$country = isset($_POST['country']) ? mysqli_real_escape_string($database_connection, $_POST['country']) : '';
		$zipcode = isset($_POST['zipcode']) ? mysqli_real_escape_string($database_connection, $_POST['zipcode']) : '';
		$phone = isset($_POST['phone']) ? mysqli_real_escape_string($database_connection, $_POST['phone']) : '';
		$email = isset($_POST['email']) ? mysqli_real_escape_string($database_connection, $_POST['email']) : '';

		if ($id != '') {
			$sql = "UPDATE `meda_patients` SET 
						`first_name`='$fname',
						`last_name`='$lname',
						`b_address`='$address1',
						`b_address_2`='$address2',
						`b_city`='$city',
						`b_state`='$state',
						`b_country`='$country',
						`b_zipcode`='$zipcode',
						`phone`='$phone',
						`email`='$email'
					WHERE `id`=$id";
			database_void_query($sql);
		}
		break;
	case "addPet":
		$name = isset($_POST['pet_name']) ? mysqli_real_escape_string($database_connection, $_POST['pet_name']) : '';
		$type = isset($_POST['type']) ? mysqli_real_escape_string($database_connection, $_POST['type']) : '';
        $breed = isset($_POST['pet_breed']) ? mysqli_real_escape_string($database_connection, $_POST['pet_breed']) : '';
		$aPet = new Pets(-1, $id, $name, $type, $breed);
		$aPet -> add();
		break;
	case "getAllPetsByCustomer":
		$allPets = Pets::getAllPetsByCondition('customer_id', $id);
		$results = array();
		foreach ($allPets as $p) {
			$type = PetTypes::getPetTypesByCondition('id', $p -> getTypeId());
			$pet = array(
				'id' => $p -> getId(),
				'name' => $p -> getName(),
				'type' => $type[0] -> getName()
			);
			array_push($results, $pet);
		}
		echo json_encode($results);
		break;
		case "deletePets":
		// delete from pets table
		
			
		$sql_1 = "DELETE FROM `meda_pets` WHERE `id`=$petId";
		database_void_query($sql_1);
		
		
		break;
	case "deleteCustomer":
		// delete from customer table
		$sql = "DELETE FROM `meda_patients` WHERE `id`=$id";
		database_void_query($sql);
		
		// delete provider-customer link
		$sql = "DELETE FROM `providers_customers` WHERE `customer_id`=$id";
		database_void_query($sql);
		break;
	
	case "addCustomer":
		// create new customer
		$fname = isset($_POST['fname']) ? mysqli_real_escape_string($database_connection, $_POST['fname']) : '';
		$lname = isset($_POST['lname']) ? mysqli_real_escape_string($database_connection, $_POST['lname']) : '';
		$address = isset($_POST['address']) ? mysqli_real_escape_string($database_connection, $_POST['address']) : '';
		$city = isset($_POST['city']) ? mysqli_real_escape_string($database_connection, $_POST['city']) : '';
		$state = isset($_POST['state']) ? mysqli_real_escape_string($database_connection, $_POST['state']) : '';
		$zipcode = isset($_POST['zipcode']) ? mysqli_real_escape_string($database_connection, $_POST['zipcode']) : '';
		$phone = isset($_POST['phone']) ? mysqli_real_escape_string($database_connection, $_POST['phone']) : '';
		$email = isset($_POST['email']) ? mysqli_real_escape_string($database_connection, $_POST['email']) : '';
				
		$sql = sprintf("INSERT INTO `meda_patients`(`first_name`, `last_name`, `b_address`, `b_city`, 
				`b_state`, `b_country`, `b_zipcode`, `phone`, `email`) 
				VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')", $fname, $lname,
				$address, $city, $state, 'US', $zipcode, $phone, $email);
		database_void_query($sql);
		
		// link customer to provider
		$doc_id = Session::Get("session_account_id");
		$sql = sprintf("SELECT `id` FROM `meda_patients` WHERE 
				`first_name`='%s' AND 
				`last_name`='%s' AND 
				`b_address`='%s' AND 
				`b_city`='%s' AND 
				`b_state`='%s' AND 
				`b_zipcode`='%s' AND 
				`phone`='%s' AND 
				`email`='%s'", $fname, $lname, $address, $city, $state, $zipcode, $phone, $email);
		$result = database_query($sql);
		$cus_id = $result[0]['id'];
		$sql = "INSERT INTO `providers_customers`(`provider_id`, `customer_id`) VALUES ($doc_id, $cus_id)";
		database_void_query($sql);
		
		break;
	case "validatePhone":
		$value = isset($_POST['value']) ? mysqli_real_escape_string($database_connection, $_POST['value']) : '';
		$sql = "SELECT `id` FROM `meda_patients` WHERE `phone`='$value'";
		$result = database_query($sql);
		if (count($result) == 0) { echo 1; }
		else { echo 0; }
		break;
	case "validateEmail":
		$value = isset($_POST['value']) ? mysqli_real_escape_string($database_connection, $_POST['value']) : '';
		$sql = "SELECT `id` FROM `meda_patients` WHERE `email`='$value'";
		$result = database_query($sql);
		if (count($result) == 0) { echo 1; }
		else { echo 0; }
		break;
}
?>