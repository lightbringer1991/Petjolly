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
                $serviceString = '<b>Services: </b><br /><ul>';
                foreach ($services as $sid) {
                    if ($sid == '') { break; }
                    $s = Services::getServiceById($sid);
                    if ($s != null) { $serviceString .= "<li>" . $s -> getName() . "</li>"; }
                }
                $serviceString .= "</ul>";

                $serviceString .= "<b>Packages: </b><br /><ul>";
                foreach ($packages as $pid) {
                    if ($pid == '') { break; }
                    $pkg = Packages::getPackageById($pid);
                    if ($pkg != null) { $serviceString .= "<li>" . $pkg -> getName() . "</li>"; }
                }
                $serviceString .= "</ul>";

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
        $appointment = Appointments::getAppointmentById($id);
        $total = 0;

        echo "<table width='100%' border='1'>
                <tr>
                    <td width='30%'><b>Customer name</b></td>
                    <td colspan='2'>" . $appointment[0]['first_name'] . " " . $appointment[0]['last_name'] . "</td>
                </tr>
                <tr>
                    <td><b>Date/time</b></td>
                    <td colspan='2'>" . $appointment[0]['appointment_date'] . " " . $appointment[0]['appointment_time'] . "</td>
                </tr>";
        // echo service list and its price
        $service_list = explode(',', $appointment[0]['service_list']);
        echo "  <tr>
                    <td colspan='3'><b>Services</b></td>
                </tr>";
        foreach ($service_list as $s) {
            $aService = Services::getServiceById($s);
            if ($aService == null) { break; }
            $total += $aService -> getPrice();
            echo "<tr>
                    <td></td>
                    <td>" . $aService -> getName() . "</td>
                    <td>$" . $aService -> getPrice() . "</td>
                  </tr>";
        }

        // echo package list and its price
        $package_list = explode(',', $appointment[0]['package_list']);
        echo "  <tr>
                    <td colspan='3'><b>Packages</b></td>
                </tr>";
        foreach ($package_list as $p) {
            $aPackage = Packages::getPackageById($p);
            if ($aPackage == null) { break; }
            $total += $aPackage -> getPrice();
            echo "<tr>
                    <td></td>
                    <td>" . $aPackage -> getName() . "</td>
                    <td>$" . $aPackage -> getPrice() . "</td>
                  </tr>";
        }

        // echo price
        echo "<tr>
                <td colspan='2'><b>Total Price</b></td>
                <td>$" . $total . "</td>
              </tr>";

        // end table
        echo "</table>";
        break;
}
?>