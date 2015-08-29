<?php
define('APPHP_EXEC', 'access allowed');
define('APPHP_CONNECT', 'direct');
require_once('../include/base.inc.php');
require_once('../include/connection.php');
$database_connection = mysqli_connect(DATABASE_HOST, DATABASE_USERNAME, DATABASE_PASSWORD, DATABASE_NAME);

switch ($_GET['action']) {
	case 'edit':
		$key = isset($_POST['key']) ? mysqli_real_escape_string($database_connection, $_POST['key']) : '';
		$value = isset($_POST['value']) ? mysqli_real_escape_string($database_connection, $_POST['value']) : '';
		$id = isset($_POST['app_id']) ? mysqli_real_escape_string($database_connection, $_POST['app_id']) : '';

		$invoice = Invoices::getInvoiceByAppointmentId($id);
		$invoice -> update(array($key => $value));
		break;
}
?>