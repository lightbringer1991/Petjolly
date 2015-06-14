<?php
define('APPHP_EXEC', 'access allowed');
define('APPHP_CONNECT', 'direct');
require_once('../include/base.inc.php');
require_once('../include/connection.php');

$database_connection = mysqli_connect(DATABASE_HOST, DATABASE_USERNAME, DATABASE_PASSWORD, DATABASE_NAME);
$category = isset($_REQUEST['category'])?$_REQUEST['category']:'';
$type = isset($_REQUEST['type'])?$_REQUEST['type']:'';
$provider_id = Session::Get("session_account_id");

if ($category == 'service') {
	if ($type == '') {
		$id = isset($_REQUEST['service_id'])?$_REQUEST['service_id']:'';
		if ($id == '') { $type = "create"; }
		else { $type = "edit"; }
	}
	switch ($type) {
		case "delete":
			$id = isset($_REQUEST['id'])?$_REQUEST['id']:'';
			$service = Services::getServiceById($id);
			$service -> remove();
			break;
		case "create":
			$name = isset($_REQUEST['service_name']) ? mysqli_real_escape_string($database_connection, $_REQUEST['service_name']) : '';
			$description = isset($_REQUEST['service_description']) ? mysqli_real_escape_string($database_connection, $_REQUEST['service_description']) : '';
			$duration = isset($_REQUEST['service_duration']) ? mysqli_real_escape_string($database_connection, $_REQUEST['service_duration']) : '';
			$price = isset($_REQUEST['service_price']) ? mysqli_real_escape_string($database_connection, $_REQUEST['service_price']) : '';
            $active = isset($_REQUEST['service_active']) ? 1 : 0;
			$service = new Services(-1, $name, $description, $provider_id, $duration, $price, $active);
			$service -> add();
			break;
		case "edit":
			$id = isset($_REQUEST['service_id']) ? mysqli_real_escape_string($database_connection, $_REQUEST['service_id']) : '';
			$name = isset($_REQUEST['service_name']) ? mysqli_real_escape_string($database_connection, $_REQUEST['service_name']) : '';
			$description = isset($_REQUEST['service_description']) ? mysqli_real_escape_string($database_connection, $_REQUEST['service_description']) : '';
			$duration = isset($_REQUEST['service_duration']) ? mysqli_real_escape_string($database_connection, $_REQUEST['service_duration']) : '';
			$price = isset($_REQUEST['service_price']) ? mysqli_real_escape_string($database_connection, $_REQUEST['service_price']) : '';
            $active = isset($_REQUEST['service_active']) ? 1 : 0;
			$service = new Services($id, $name, $description, $provider_id, $duration, $price, $active);
			$service -> edit();
			break;

	}

} elseif ($category == 'package') {
	if ($type == '') {
		$id = isset($_REQUEST['package_id'])?$_REQUEST['package_id']:'';
		if ($id == '') { $type = "create"; }
		else { $type = "edit"; }
	}
	switch ($type) {
		case "delete":
			$id = isset($_REQUEST['id'])?$_REQUEST['id']:'';
			$package = Packages::getPackageById($id);
			$package -> remove();
			break;
		case "create":
			$name = isset($_REQUEST['package_name']) ? mysqli_real_escape_string($database_connection, $_REQUEST['package_name']) : '';
			$description = isset($_REQUEST['package_description']) ? mysqli_real_escape_string($database_connection, $_REQUEST['package_description']) : '';
			$duration = isset($_REQUEST['package_duration']) ? mysqli_real_escape_string($database_connection, $_REQUEST['package_duration']) : '';
			$price = isset($_REQUEST['package_price']) ? mysqli_real_escape_string($database_connection, $_REQUEST['package_price']) : '';
			$services = isset($_REQUEST['package_services']) ? $_REQUEST['package_services'] : array();
            $active = isset($_REQUEST['package_active']) ? 1 : 0;

            $package = new Packages(-1, $name, $description, $provider_id, $services, $duration, $price, $active);
			$package -> add();
			break;
		case "edit":
			$id = isset($_REQUEST['package_id'])?$_REQUEST['package_id']:'';
			$name = isset($_REQUEST['package_name']) ? mysqli_real_escape_string($database_connection, $_REQUEST['package_name']) : '';
			$description = isset($_REQUEST['package_description']) ? mysqli_real_escape_string($database_connection, $_REQUEST['package_description']) : '';
			$duration = isset($_REQUEST['package_duration']) ? mysqli_real_escape_string($database_connection, $_REQUEST['package_duration']) : '';
			$price = isset($_REQUEST['package_price']) ? mysqli_real_escape_string($database_connection, $_REQUEST['package_price']) : '';
			$services = isset($_REQUEST['package_services']) ? $_REQUEST['package_services'] : array();
            $active = isset($_REQUEST['package_active']) ? 1 : 0;

			$package = new Packages($id, $name, $description, $provider_id, $services, $duration, $price, $active);
			$package -> edit();
	}
}
?>