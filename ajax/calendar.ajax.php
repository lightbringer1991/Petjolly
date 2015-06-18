<?php
define('APPHP_EXEC', 'access allowed');
define('APPHP_CONNECT', 'direct');
require_once('../include/base.inc.php');
require_once('../include/connection.php');

$database_connection = mysqli_connect(DATABASE_HOST, DATABASE_USERNAME, DATABASE_PASSWORD, DATABASE_NAME);
$option = isset($_REQUEST['option']) ? mysqli_real_escape_string($database_connection, $_REQUEST['option']) : '';
$mode = isset($_REQUEST['mode']) ? mysqli_real_escape_string($database_connection, $_REQUEST['mode']) : '';
$doc_id = Session::Get("session_account_id");

switch ($option) {
	case "eventDescription":
		$id = isset($_POST['id']) ? mysqli_real_escape_string($database_connection, $_POST['id']) : '';
		$event = Appointments::getAppointmentById($id);
		if ($mode == 'getInfo') {
			echo json_encode($event[0]);
		} else {
            $services = explode(',', $event[0]['service_list']);

            $serviceList = "<ul>";
            foreach ($services as $s) {
                $sv = Services::getServiceById($s);
                if ($sv != null) { $serviceList .= "<li>" . $sv -> getName() . "</li>"; }
            }
            $serviceList .= "</ul>";

            $packageList = "<ul>";
            $packages = explode(',', $event[0]['package_list']);
            foreach ($packages as $p) {
                $pkg = Packages::getPackageById($p);
                if ($pkg != null) { $packageList .= "<li>" . $pkg -> getName() . "</li>"; }
            }
            $packageList .= "</ul>";

			echo '<b>Customer Name: </b>' . $event[0]['first_name'] . " " . $event[0]['last_name'] . "<br />" . 
				'<b>Appointment Time: </b>' . $event[0]['appointment_date'] . " " . $event[0]['appointment_time'] . '<br />' .
				'<b>Duration: </b>' . $event[0]['visit_duration'] . ' minutes<br />' .
                '<b>Services: </b><br />' . $serviceList . '<br />' .
                '<b>Packages: </b><br />' . $packageList . '<br />';
		}
        break;
    case "getTimeOff":
        $start = isset($_REQUEST['start']) ? mysqli_real_escape_string($database_connection, $_REQUEST['start']) : '';
        $end = isset($_REQUEST['end']) ? mysqli_real_escape_string($database_connection, $_REQUEST['end']) : '';
        $timeoffs = Timeoffs::getTimeOff($doc_id, $start, $end);
        $timeoffEvents = array();
        foreach ($timeoffs as $to) {
            $anEvent = array(
                'title' => $to['description'],
                'start' => $to['start'],
                'end' => $to['end'],
                'color' => '#BCBCBC',
                'className' => "disabled",
                'editable' => false
            );
            array_push($timeoffEvents, $anEvent);
        }
        echo json_encode($timeoffEvents);
        break;
    case "getAllEvents":
        $start = isset($_REQUEST['start']) ? mysqli_real_escape_string($database_connection, $_REQUEST['start']) : '';
        $end = isset($_REQUEST['end']) ? mysqli_real_escape_string($database_connection, $_REQUEST['end']) : '';
        $allEvents = Appointments::getAllAppointmentsByLoggedProvider($start, $end);
        $jsonArray = array();
        foreach ($allEvents[0] as $e) {
            $startTime = strtotime($e['appointment_date'] . " " . $e['appointment_time']);
            $startTimeStr = date('c', $startTime);
            $endTimeStr = date('c', strtotime('+' . $e['visit_duration'] . ' minutes', $startTime));
            
            $anEvent = array(
                'id' => $e['id'],
                'title' => $e['first_name'] . " " . $e['last_name'],
                'start' => $startTimeStr,
                'end' => $endTimeStr,
                'color' => $e['color']
            );

            array_push($jsonArray, $anEvent);
        }
        echo json_encode($jsonArray);
        break;
    case "uiUpdateEvent":
        $id = isset($_POST['id']) ? mysqli_real_escape_string($database_connection, $_POST['id']) : '';
        $start = isset($_POST['start']) ? mysqli_real_escape_string($database_connection, $_POST['start']) : '';
        $end = isset($_POST['end']) ? mysqli_real_escape_string($database_connection, $_POST['end']) : '';

        // get duration in minutes
        $start = new DateTime($start);
        $end = new DateTime($end);
        $duration = ($end -> getTimestamp() - $start -> getTimestamp()) / 60;

        // get appointment date and time
        $date = $start -> format('Y-m-d');
        $time = $start -> format('H:i:s');

        // update database
        $sql = "UPDATE `meda_appointments` SET
                    `appointment_date`='$date',
                    `appointment_time`='$time',
                    `visit_duration`='$duration'
                WHERE `id`=$id";
        database_void_query($sql);

        // send email to patient
        $sql = "SELECT `appointment_number` FROM `meda_appointments` WHERE `id`=$id";
        $result = database_query($sql, DATA_ONLY,FIRST_ROW_ONLY);
        Appointments::SendAppointmentEmail('appointment_rescheduled_by_provider', $result['appointment_number']);
        break;
    case "editEvent":
        $app_id = isset($_POST['appointment_id']) ? mysqli_real_escape_string($database_connection, $_POST['appointment_id']) : '';
        $cus_id = isset($_POST['appointment_customer_id']) ? mysqli_real_escape_string($database_connection, $_POST['appointment_customer_id']) : '';
        $service_package_list = isset($_POST['service_list']) ? $_POST['service_list'] : '';
        $app_date = isset($_POST['appointment_date']) ? mysqli_real_escape_string($database_connection, $_POST['appointment_date']) : '';
        $app_time = isset($_POST['appointment_time']) ? mysqli_real_escape_string($database_connection, $_POST['appointment_time']) : '';
        $duration = isset($_POST['duration']) ? mysqli_real_escape_string($database_connection, $_POST['duration']) : '';
        $color = isset($_POST['color']) ? mysqli_real_escape_string($database_connection, $_POST['color']) : '';

        $service_list = array();
        $package_list = array();
        foreach ($service_package_list as $sp) {
            if (substr($sp, 0, 1) == 'p') { array_push($package_list, substr($sp, 1)); }
            else { array_push($service_list, substr($sp, 1)); }
        }

        $sql = sprintf("UPDATE `meda_appointments` SET
                        `patient_id`='%s',
                        `service_list`='%s',
                        `package_list`='%s',
                        `appointment_date`='%s',
                        `appointment_time`='%s',
                        `visit_duration`='%s',
                        `color`='%s' WHERE `id`='%s'",
                        $cus_id,
                        implode(',', $service_list),
                        implode(',', $package_list),
                        $app_date,
                        $app_time,
                        $duration,
                        $color,
                        $app_id
             );
        database_query($sql);
        break;
    case "createEvent":
        $cus_id = isset($_POST['appointment_customer_id']) ? mysqli_real_escape_string($database_connection, $_POST['appointment_customer_id']) : '';
        $service_package_list = isset($_POST['service_list']) ? $_POST['service_list'] : '';
        $app_date = isset($_POST['appointment_date']) ? mysqli_real_escape_string($database_connection, $_POST['appointment_date']) : '';
        $app_time = isset($_POST['appointment_time']) ? mysqli_real_escape_string($database_connection, $_POST['appointment_time']) : '';
        $duration = isset($_POST['duration']) ? mysqli_real_escape_string($database_connection, $_POST['duration']) : '';
        $color = isset($_POST['color']) ? mysqli_real_escape_string($database_connection, $_POST['color']) : '';

        $service_list = array();
        $package_list = array();
        foreach ($service_package_list as $sp) {
            if (substr($sp, 0, 1) == 'p') { array_push($package_list, substr($sp, 1)); }
            else { array_push($service_list, substr($sp, 1)); }
        }

        Appointments::DoAppointment(array(
            'docid' => $doc_id,
            'date' => $app_date,
            'start_time' => $app_time,
            'duration' => $duration,
            'patient_id' => $cus_id,
            'service_list' => implode(',', $service_list),
            'package_list' => implode(',', $package_list),
        ));
/*
        $sql = "SELECT `id` FROM `meda_appointments` WHERE `doctor_id`=$doc_id
                    AND `appointment_date`='$app_date'
                    AND `appointment_time`='$app_time'
                    AND `visit_duration`='$duration'";
        $result = database_query($sql, DATA_AND_ROWS, FIRST_ROW_ONLY);
        $app_id = $result[0]['id'];
        $sql = sprintf("UPDATE `meda_appointments` SET
                    `color`='%s',
                    `service_list`='%s',
                    `package_list`='%s'
                     WHERE `id`=$app_id", $color, implode(',', $service_list), implode(',', $package_list));
        database_void_query($sql);
*/
        break;
    case "deleteEvent":
        $id = isset($_POST['id']) ? mysqli_real_escape_string($database_connection, $_POST['id']) : '';
        $sql = "UPDATE `meda_appointments` SET `status`=2 WHERE `id`=$id";
        database_void_query($sql);
        $sql = "SELECT `appointment_number` FROM `meda_appointments` WHERE `id`=$id";
        $result = database_query($sql, DATA_ONLY,FIRST_ROW_ONLY);
        Appointments::SendAppointmentEmail('appointment_canceled', $result['appointment_number']);
        break;
    case "customerAutocomplete":
        $term = isset($_REQUEST['term']) ? mysqli_real_escape_string($database_connection, $_REQUEST['term']) : '';
        /*
            $customerList = array(
                '<customer_id>' => array(
                    'fullName' => '<string>',
                    'phone' => '<string>',
                    'pet' => '<string>'
                )
            )
        */
        $customerList = array();

        // search by customer name or phone number
        $sql = "SELECT `id`, CONCAT(`first_name`, ' ', `last_name`) AS `fullName`, `phone`
                FROM `meda_patients` 
                LEFT JOIN `providers_customers` ON `id`=`customer_id`
                WHERE `provider_id`=$doc_id 
                    AND ((CONCAT(`first_name`, ' ', `last_name`) LIKE '%$term%') OR (`phone` LIKE '%$term%'))";

        $results = database_query($sql, DATA_AND_ROWS, ALL_ROWS);
        foreach ($results[0] as $r) {
            $customerList[$r['id']] = array(
                'fullName' => $r['fullName'],
                'phone' => $r['phone'],
                'pet' => ''
            );
        }
        // search pet name
        $sql = "SELECT `pa`.`id`, CONCAT(`first_name`, ' ', `last_name`) AS `fullName`, `pe`.`name`
                    FROM `meda_patients` AS `pa`
                    LEFT JOIN `providers_customers` AS `pc` ON `pa`.`id`=`pc`.`customer_id`
                    LEFT JOIN `meda_pets` AS `pe` ON `pc`.`customer_id`=`pe`.`customer_id`
                    WHERE `pc`.`provider_id`=$doc_id
                    AND `pe`.name LIKE '%$term%'";
        $results = database_query($sql, DATA_AND_ROWS, ALL_ROWS);

        // concatenate pet names with the same owner
        foreach ($results[0] as $r) {
            if (isset($customerList[$r['id']])) {
                if ($customerList[$r['id']]['pet'] != '') {
                    $customerList[$r['id']]['pet'] .= ", {$r['name']}";
                } else {
                    $customerList[$r['id']]['pet'] .= $r['name'];
                }
            } else {
                $customerList[$r['id']] = array(
                    'fullName' => $r['fullName'],
                    'phone' => '',
                    'pet' => $r['name']
                );
            }
        }

        // format the output
        $output = array();
        foreach ($customerList as $k => $v) {
            $record = array(
                'id' => '',
                'label' => $v['fullName'],
                'description' => '',
                'value' => $k
            );
            if ($v['phone'] != '') { $record['description'] = "Phone: " . $v['phone']; }
            if ($v['pet'] != '') { 
                if ($record['description'] == '') {
                    $record['description'] = "Pet: " . $v['pet'];
                } else {
                    $record['description'] .= "<br />Pet: " . $v['pet'];
                }
                
            }

            array_push($output, $record);
        }

        echo json_encode($output);
        break;
    case "createCustomer":
        $fname = isset($_POST['customer_fname']) ? mysqli_real_escape_string($database_connection, $_POST['customer_fname']) : '';
        $lname = isset($_POST['customer_lname']) ? mysqli_real_escape_string($database_connection, $_POST['customer_lname']) : '';
        $phone = isset($_POST['customer_phone']) ? mysqli_real_escape_string($database_connection, $_POST['customer_phone']) : '';
        $email = isset($_POST['customer_email']) ? mysqli_real_escape_string($database_connection, $_POST['customer_email']) : '';
        $id = 0;

        $sql = "SELECT `id` FROM `meda_patients` WHERE `phone`='$phone' AND `email`='$email'";
        $result = database_query($sql, DATA_AND_ROWS, FIRST_ROW_ONLY);
        if ($result[1] == 0) {          // user doesn't exist
            $sql = "INSERT INTO `meda_patients`(`first_name`, `last_name`, `phone`, `email`)
                        VALUES ('$fname', '$lname', '$phone', '$email')";
            database_void_query($sql);

            $sql = "SELECT `id` FROM `meda_patients` WHERE `phone`='$phone' AND `email`='$email'";
            $r = database_query($sql, DATA_AND_ROWS, FIRST_ROW_ONLY);
            $id = $r[0]['id'];
        } else { $id = $result[0]['id']; }

        $sql = "INSERT INTO `providers_customers`(`provider_id`, `customer_id`) VALUES($doc_id, $id)";
        database_void_query($sql);

        echo $id;

        break;
}
?>
