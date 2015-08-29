<?php
define('APPHP_EXEC', 'access allowed');
define('APPHP_CONNECT', 'direct');
require_once('../include/base.inc.php');
require_once('../include/connection.php');

$database_connection = mysqli_connect(DATABASE_HOST, DATABASE_USERNAME, DATABASE_PASSWORD, DATABASE_NAME);
$option = isset($_POST['option']) ? mysqli_real_escape_string($database_connection, $_POST['option']) : '';
$date = isset($_POST['date']) ? mysqli_real_escape_string($database_connection, $_POST['date']) : '';
$id = isset($_POST['id']) ? mysqli_real_escape_string($database_connection, $_POST['id']) : '';
$provider_id = Session::Get("session_account_id");

switch ($option) {
	case "getOnDate":
		$results = database_query("SELECT `appointment_number`, `appointment_date`, `appointment_time`, `visit_duration`, `first_name`, `last_name`, `email`, `phone`, `status`, `color` FROM `meda_appointments`, `meda_patients` WHERE `patient_id`=`meda_patients`.`id` AND `appointment_date`='$date'");
		echo json_encode($results);
		break;
	case "getAllDate":
		$results = database_query("SELECT `appointment_date` FROM `meda_appointments` WHERE `doctor_id`=" . Session::Get("session_account_id"));
		echo json_encode($results);
		break;
	case "getAllAppByCustomer":
		$results = database_query("SELECT `meda_appointments`.`id`, `appointment_number`, `appointment_date`, `appointment_time`, `visit_duration`, `status` 
									FROM `meda_appointments`, `meda_patients` 
									WHERE `patient_id`=$id AND `patient_id` = `meda_patients`.`id` AND `doctor_id`=" . Session::Get("session_account_id"));
		echo json_encode($results);
		break;
    // get the most 3 recent appointments
    case "getAppointmentHistory":
        if ($id != '') {
            $query = "SELECT `id`, `appointment_date`, `patient_notes`, `visit_price`, `service_list`, `package_list` 
                        FROM `meda_appointments` 
                        WHERE `patient_id`=$id 
                        ORDER BY `id` DESC 
                        LIMIT 3";
            $result = database_query($query);

            $output = array();

            foreach ($result as $r) {
                $services = explode(',', $r['service_list']);
                $packages = explode(',', $r['package_list']);

                // generate services data
                $serviceString = '<b>Services: </b>';
                foreach ($services as $sid) {
                    if ($sid == '') { break; }
                    $s = Services::getServiceById($sid);
                    if ($s != null) { $serviceString .= $s -> getName() . ", "; }
                }
                $serviceString = substr($serviceString, 0, -2) . "<br />";     // remove ', '

                $serviceString .= "<b>Packages: </b>";
                foreach ($packages as $pid) {
                    if ($pid == '') { break; }
                    $pkg = Packages::getPackageById($pid);
                    if ($pkg != null) { $serviceString .= $pkg -> getName() . ", "; }
                }
                $serviceString = substr($serviceString, 0, -2) . "<br />";     // remove ', '

                array_push($output, array(
                        'id' => $r['id'],
                        'date' => date('d/m/Y', strtotime($r['appointment_date'])),
                        'services' => $serviceString,
                        'notes' => $r['patient_notes'],
                        'price' => $r['visit_price']
                    ));
            }

            echo json_encode($output);
        }
        break;
	case "getSummaryData":
		$results = database_query("SELECT YEAR(`appointment_date`) AS `year`, MONTH(`appointment_date`) AS `month`, COUNT(*) AS `appointments` 
									FROM `meda_appointments`
									WHERE YEAR(`appointment_date`) > 0 AND YEAR(`appointment_date`) >= YEAR(NOW()) - 5
									  AND `doctor_id`=$provider_id
									GROUP BY YEAR(`appointment_date`), MONTH(`appointment_date`)
									ORDER BY YEAR(`appointment_date`), MONTH(`appointment_date`) ASC");
		echo json_encode($results);
		break;
    case "getAppointmentsThisMonth":
        $sql = "SELECT DAY(`appointment_date`) as `day`, COUNT(*) as `appointments`
                    FROM `meda_appointments`
                    WHERE YEAR(`appointment_date`)=YEAR(NOW())
                      AND `doctor_id`=$provider_id
                      AND MONTH(`appointment_date`)=MONTH(NOW())
                      AND `status`!=2
                    GROUP BY DAY(`appointment_date`) ORDER BY DAY(`appointment_date`) ASC";
        $results = database_query($sql, DATA_AND_ROWS, ALL_ROWS);
        $output = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
        foreach ($results[0] as $r) {
            $output[$r['day']] = intval($r['appointments']);
        }
        echo json_encode($output);
        break;
    case "getInvoice":
        $invoice = Invoices::getInvoiceByAppointmentId($id);
        echo $invoice;
        break;
}
?>