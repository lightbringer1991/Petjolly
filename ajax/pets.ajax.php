<?php
define('APPHP_EXEC', 'access allowed');
define('APPHP_CONNECT', 'direct');
require_once('../include/base.inc.php');
require_once('../include/connection.php');

$database_connection = mysqli_connect(DATABASE_HOST, DATABASE_USERNAME, DATABASE_PASSWORD, DATABASE_NAME);

$action = isset($_GET['action']) ? mysqli_real_escape_string($database_connection, $_GET['action']) : '';

switch ($action) {
	case "getDetails":
		$id = mysqli_real_escape_string($database_connection, $_POST['id']);
		$sql = "SELECT `p`.`name`, `p`.`notes`, `c`.`first_name`, `c`.`last_name`, `c`.`phone`, `c`.`cellphone`, `c`.`email`
					FROM `meda_pets` AS `p` 
					LEFT JOIN `meda_patients` AS `c` ON `p`.`customer_id`=`c`.`id`
					WHERE `p`.`id`=$id";
		$result = database_query($sql, DATA_ONLY,FIRST_ROW_ONLY);

		// get latest customer notes from the last appointment
		$sql = "SELECT `a`.`patient_notes`, `a`.`appointment_date`, `a`.`appointment_time` 
					FROM `meda_appointments` AS `a`
					LEFT JOIN `meda_pets` AS `p` ON `a`.`patient_id`=`p`.`id` 
					WHERE `a`.`appointment_date` IN (SELECT MAX(`appointment_date`) FROM `meda_appointments` WHERE `patient_id`=$id) 
					ORDER BY `appointment_time` DESC 
					LIMIT 1";
		$notes = database_query($sql, DATA_ONLY,FIRST_ROW_ONLY);
		$result['customer_notes'] = $notes['patient_notes'];

		echo json_encode($result);
		break;
	case "editDetails":
		$id = mysqli_real_escape_string($database_connection, $_POST['id']);
		$name = mysqli_real_escape_string($database_connection, $_POST['pet_name']);
		$customer_name = mysqli_real_escape_string($database_connection, $_POST['customer_name']);
		$phone = mysqli_real_escape_string($database_connection, $_POST['customer_phone']);
		$mobile = mysqli_real_escape_string($database_connection, $_POST['customer_mobile']);
		$email = mysqli_real_escape_string($database_connection, $_POST['customer_email']);
		$pet_notes = mysqli_real_escape_string($database_connection, $_POST['pet_notes']);

		$aPet = Pets::getPetById($id);
		if ($aPet != null) {
			$aPet -> update('name', $name);
			$aPet -> update('notes', $pet_notes);
		}

		$exploded_name = explode(' ', $customer_name, 2);
		Patients::updatePatientDetails($aPet -> getField('customer_id'), array(
			'first_name' => $exploded_name[0],
			'last_name' => $exploded_name[1],
			'phone' => $phone,
			'cellphone' => $mobile,
			'email' => $email
		));

		echo "Pet details updated";
		break;
	case "getAppointmentHistory":
		$id = mysqli_real_escape_string($database_connection, $_POST['id']);

		$sql = "SELECT `appointment_date`, `appointment_time`, `visit_duration`, `patient_notes`, `service_list`, `package_list`
					FROM `meda_appointments`
					WHERE `patient_id`=$id
					ORDER BY `appointment_date`, `appointment_time` DESC";
		$result = database_query($sql, DATA_AND_ROWS, ALL_ROWS);
		$output = "	<table id='table-appointmentHistory'>
						<thead class='center'>
							<th>Date/Time</th>
							<th>Duration (minutes)</th>
							<th>Services/Packages</th>
							<th>Notes</th>
						</thead>
						<tbody>";

		foreach ($result[0] as $r) {
			$services_packages = '<b>Services:</b>';
			// get services
			$service_ids = explode(',', $r['service_list']);
			foreach ($service_ids as $sid) {
				$s = Services::getServiceById($sid);
				if ($s != null) { $services_packages .= $s -> getName() . ', '; }
			}
			$services_packages = substr($services_packages, 0, -2) . "<br /><b>Packages:</b>";
			// get packages
			$package_ids = explode(',', $r['package_list']);
			foreach ($package_ids as $pid) {
				$p = Packages::getPackageById($pid);
				if ($p != null) { $services_packages.= $p -> getName() . ', '; }
			}
			$services_packages = substr($services_packages, 0, -2);

			$output .= "<tr>
							<td>" . date('d/m/Y H:i:s', strtotime($r['appointment_date'] . " " . $r['appointment_time'])) . "</td>
							<td>" . $r['visit_duration'] . "</td>
							<td>" . $services_packages . "</td>
							<td>" . $r['patient_notes'] . "</td>
						</tr>";
		}
		$output .= "	</tbody>
					</table>
					<script type='text/javascript'>
					$(document).ready(function() {
						$(document).find('#table-appointmentHistory').DataTable();
					});
					</script>";
		echo $output;
		break;
	case "deletePets":
		$ids = $_POST['id'];
		foreach ($ids as $id) {
			$sql = "DELETE FROM `meda_pets` WHERE `id`=$id";
			database_void_query($sql);
		}
		break;
	case "customerAutocomplete":
		$term = isset($_REQUEST['term']) ? mysqli_real_escape_string($database_connection, $_REQUEST['term']) : '';
		$sql = "SELECT `id`, CONCAT(`first_name`, ' ', `last_name`) AS `fullName`
					FROM `meda_patients`
					HAVING `fullName` LIKE '%$term%'";
		$result = database_query($sql, DATA_AND_ROWS, ALL_ROWS);
		$customerList = array();
		foreach ($result[0] as $r) {
            $record = array(
                'id' => '',
                'label' => $r['id'],
                'description' => $r['fullName'],
                'value' => $r['id'],
            );
            array_push($customerList, $record);
		}
		echo json_encode($customerList);
		break;
	case "addPet":
		$pet = new Pets(array(
			'customer_id' => $_POST['customer_id'],
			'name' => $_POST['pet_name'],
			'type_id' => $_POST['pet_type'],
			'breed' => $_POST['pet_breed']
		));
		$pet -> add();
		break;
}
?>