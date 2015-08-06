<?php
define('APPHP_EXEC', 'access allowed');
define('APPHP_CONNECT', 'direct');
require_once('../include/base.inc.php');
require_once('../include/connection.php');

$database_connection = mysqli_connect(DATABASE_HOST, DATABASE_USERNAME, DATABASE_PASSWORD, DATABASE_NAME);
$step = isset($_REQUEST['step'])?$_REQUEST['step']:'';
//--------------------------------------------------------------------------
$doc_id = Session::Get("session_account_id");
if (isset($_FILES['image_upload'])) {
	$target_path = "../images/doctors/" . $_FILES['image_upload']['name'];
	if(move_uploaded_file($_FILES['image_upload']['tmp_name'], $target_path)) {
		$sql = "INSERT INTO " . TABLE_DOCTOR_IMAGES . "(`doctor_id`, `item_file`, `priority_order`, `is_active`)
				VALUES ($doc_id, '" . $_FILES['image_upload']['name'] . "', 0, 1);";
		database_void_query($sql);
        echo 1;
    } else {
        echo 0;
    }
} elseif (isset($_POST['action'])) {
	switch($_POST['action']) {
		case "deleteImg":
			$imgId = $_POST['imgId'];
			$sql = "DELETE FROM " . TABLE_DOCTOR_IMAGES . " WHERE `id`=$imgId";
			database_void_query($sql);
			break;
	}
} else {
switch ($step) {
	case 1: 
		// get longitude and lattitude
		$business_name = isset($_REQUEST['business_name']) ? mysqli_real_escape_string($database_connection, $_REQUEST['business_name']) : '';
		$description = isset($_REQUEST['description']) ? mysqli_real_escape_string($database_connection, $_REQUEST['description']) : '';
		$ammenties = isset($_REQUEST['ammenties']) ? $_REQUEST['ammenties'] : array();
        $specialities = isset($_REQUEST['specialities']) ? $_REQUEST['specialities'] : array();
		$address = isset($_REQUEST['address']) ? mysqli_real_escape_string($database_connection, $_REQUEST['address']) : '';
		$city = isset($_REQUEST['city']) ? mysqli_real_escape_string($database_connection, $_REQUEST['city']) : '';
		$state = isset($_REQUEST['state']) ? mysqli_real_escape_string($database_connection, $_REQUEST['state']) : '';
		$zipcode = isset($_REQUEST['zipcode']) ? mysqli_real_escape_string($database_connection, $_REQUEST['zipcode']) : '';
		$latitude = isset($_REQUEST['latitude']) ? mysqli_real_escape_string($database_connection, $_REQUEST['latitude']) : '';
		$longitude = isset($_REQUEST['longitude']) ? mysqli_real_escape_string($database_connection, $_REQUEST['longitude']) : '';
		
		$mapaddress = urlencode("$address $city $state $zipcode");
		$url = "https://maps.googleapis.com/maps/api/geocode/xml?address=$mapaddress&sensor=false";
		$page = file_get_contents($url);                        
		$xml = new SimpleXMLElement($page);
		$new_address = $address ."==". $city ."==". $state ."==". $zipcode;
		
		// get business hours
		$monOp = isset($_REQUEST['monday_start']) ? mysqli_real_escape_string($database_connection, $_REQUEST['monday_start']) : '';
		$monCl = isset($_REQUEST['monday_end']) ? mysqli_real_escape_string($database_connection, $_REQUEST['monday_end']) : '';
		$tueOp = isset($_REQUEST['tuesday_start']) ? mysqli_real_escape_string($database_connection, $_REQUEST['tuesday_start']) : '';
		$tueCl = isset($_REQUEST['tuesday_end']) ? mysqli_real_escape_string($database_connection, $_REQUEST['tuesday_end']) : '';
		$wedOp = isset($_REQUEST['wednesday_start']) ? mysqli_real_escape_string($database_connection, $_REQUEST['wednesday_start']) : '';
		$wedCl = isset($_REQUEST['wednesday_end']) ? mysqli_real_escape_string($database_connection, $_REQUEST['wednesday_end']) : '';
		$thurOp = isset($_REQUEST['thursday_start']) ? mysqli_real_escape_string($database_connection, $_REQUEST['thursday_start']) : '';
		$thurCl = isset($_REQUEST['thursday_end']) ? mysqli_real_escape_string($database_connection, $_REQUEST['thursday_end']) : '';
		$friOp = isset($_REQUEST['friday_start']) ? mysqli_real_escape_string($database_connection, $_REQUEST['friday_start']) : '';
		$friCl = isset($_REQUEST['friday_end']) ? mysqli_real_escape_string($database_connection, $_REQUEST['friday_end']) : '';
		$satOp = isset($_REQUEST['saturday_start']) ? mysqli_real_escape_string($database_connection, $_REQUEST['saturday_start']) : '';
		$satCl = isset($_REQUEST['saturday_end']) ? mysqli_real_escape_string($database_connection, $_REQUEST['saturday_end']) : '';
		$sunOp = isset($_REQUEST['sunday_start']) ? mysqli_real_escape_string($database_connection, $_REQUEST['sunday_start']) : '';
		$sunCl = isset($_REQUEST['sunday_end']) ? mysqli_real_escape_string($database_connection, $_REQUEST['sunday_end']) : '';
		
		$sql = "UPDATE " . TABLE_DOCTORS . " SET 
				`popupdesc`='$description',
				`business_name`='$business_name',
				`list_mon_open`='$monOp',
				`list_mon_close`='$monCl',
				`list_tue_open`='$tueOp',
				`list_tue_close`='$tueCl',
				`list_wed_open`='$wedOp',
				`list_wed_close`='$wedCl',
				`list_thur_open`='$thurOp',
				`list_thur_close`='$thurCl',
				`list_fri_open`='$friOp',
				`list_fri_close`='$friCl',
				`list_sat_open`='$satOp',
				`list_sat_close`='$satCl',
				`list_sun_open`='$sunOp',
				`list_sun_close`='$sunCl',
				`b_address`='$address',
				`b_city`='$city',
				`b_state`='$state',
				`b_zipcode`='$zipcode',
				`latitude`='$latitude',
				`longitude`='$longitude' 
			WHERE id=$doc_id";
		database_void_query($sql);
		
		// insert ammenties list
		// remove current ammenties list
		$sql = "DELETE FROM `providers_ammenties` WHERE `provider_id`=$doc_id";
		database_void_query($sql);
		
		// insert new ammenties list
		foreach ($ammenties as $a) {
			$sql = sprintf("INSERT INTO `providers_ammenties`(`provider_id`, `ammenty_id`) VALUES ('%s', '%s')", $doc_id, $a);
			database_void_query($sql);
		}

        // insert specialities list
        // remove current specialities list
        $sql = "DELETE FROM " . TABLE_DOCTOR_SPECIALITIES . " WHERE `doctor_id`=$doc_id";
        database_void_query($sql);

        // insert new specialities list
        foreach ($specialities as $s) {
            $sql = sprintf("INSERT INTO `" . TABLE_DOCTOR_SPECIALITIES . "`(`doctor_id`, `speciality_id`) VALUES ('%s', '%s')", $doc_id, $s);
            database_void_query($sql);
        }

		echo "1";
		break;
	case 2:
        $list_storefeatured = isset($_REQUEST['storerfeatured']) ? mysqli_real_escape_string($database_connection, $_REQUEST['storerfeatured']) : '';
		$phone = isset($_REQUEST['phone']) ? mysqli_real_escape_string($database_connection, $_REQUEST['phone']) : '';
		$mobile_number = isset($_REQUEST['mobile']) ? mysqli_real_escape_string($database_connection, $_REQUEST['mobile']) : '';
		$fax = isset($_REQUEST['fax']) ? mysqli_real_escape_string($database_connection, $_REQUEST['fax']) : '';
		$list_website = isset($_REQUEST['list_website']) ? mysqli_real_escape_string($database_connection, $_REQUEST['list_website']) : '';

		$list_twitter = isset($_REQUEST['list_twitter']) ? mysqli_real_escape_string($database_connection, $_REQUEST['list_twitter']) : '';
		$list_facebook = isset($_REQUEST['list_facebook']) ? mysqli_real_escape_string($database_connection, $_REQUEST['list_facebook']) : '';
        $list_google = isset($_REQUEST['list_google']) ? mysqli_real_escape_string($database_connection, $_REQUEST['list_google']) : '';
		
		$map_flg = 1;
		$sql = "UPDATE " . TABLE_DOCTORS . " SET 
					list_facebook='$list_facebook',
					list_google='$list_google',
					list_twitter='$list_twitter',
					list_website='$list_website',
					list_mobile='$mobile_number',
					phone='$phone',
					fax='$fax',
					mapflg='$map_flg',
					storerfeatured='$list_storefeatured'
				WHERE id = $doc_id"; 
		database_void_query($sql);
		echo "1";
		break;
}
}
?>