<?php
define('APPHP_EXEC', 'access allowed');
define('APPHP_CONNECT', 'direct');
require_once('../include/base.inc.php');
require_once('../include/connection.php');

$database_connection = mysqli_connect(DATABASE_HOST, DATABASE_USERNAME, DATABASE_PASSWORD, DATABASE_NAME);
$option = isset($_REQUEST['option']) ? mysqli_real_escape_string($database_connection, $_REQUEST['option']) : '';
$mode = isset($_REQUEST['mode']) ? mysqli_real_escape_string($database_connection, $_REQUEST['mode']) : '';
$doc_id = Session::Get("session_account_id");

$statusColor = array(
    1 => '#0000ff',
    3 => '#FF8000',
    4 => '#00FF00',
    5 => '#FF0000'
);

switch ($option) {
	case "eventDescription":
		$id = isset($_POST['id']) ? mysqli_real_escape_string($database_connection, $_POST['id']) : '';
		$event = Appointments::getAppointmentById($id);

		if ($mode == 'getInfo') {
            $output = array(
                'appointment_id' => $event[0]['id'],
                'pet_id' => $event[0]['pet_id'],
                'pet_name' => $event[0]['name'],
                'customer_name' => $event[0]['first_name'] . " " . $event[0]['last_name'],
                'customer_phone' => $event[0]['phone'],
                'customer_phone_sms' => $event[0]['phone_SMS'],
                'customer_cellphone' => $event[0]['cellphone'],
                'customer_cellphone_sms' => $event[0]['cellphone_SMS'],
                'customer_email' => $event[0]['email'],
                'alternate_name1' => $event[0]['alternate_name1'],
                'customer_alternate_phone1' => $event[0]['alternate_phone1'],
                'customer_alternate_phone1_sms' => $event[0]['alternate_SMS1'],
                'communication_preference' => ($event[0]['communication_preference'] != '') ? $event[0]['communication_preference'] : 'phone',
                'alternate_name2' => $event[0]['alternate_name2'],
                'customer_alternate_phone2' => $event[0]['alternate_phone2'],
                'customer_alternate_phone2_sms' => $event[0]['alternate_SMS2'],
                'customer_notes' => $event[0]['patient_notes'],
                'service_list' => $event[0]['service_list'],
                'package_list' => $event[0]['package_list'],
                'appointment_date' => $event[0]['appointment_date'],
                'appointment_time' => $event[0]['appointment_time'],
                'duration' => $event[0]['visit_duration'],
                'pet_notes' => $event[0]['notes']
            );

            echo json_encode($output);
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

            $output = array(
                'description' =>    '<b>Customer Name: </b>' . $event[0]['first_name'] . " " . $event[0]['last_name'] . "<br />" . 
                                    '<b>Pet Name: </b>' . $event[0]['name'] . "<br />" .
                                    '<b>Appointment Time: </b>' . $event[0]['appointment_date'] . " " . $event[0]['appointment_time'] . '<br />' .
                                    '<b>Duration: </b>' . $event[0]['visit_duration'] . ' minutes<br />' .
                                    '<b>Services: </b><br />' . $serviceList . '<br />' .
                                    '<b>Packages: </b><br />' . $packageList . '<br />',
                'status' => in_array($event[0]['status'], array(3, 4, 5)) ? $event[0]['status'] : 0

            );
            echo json_encode($output);
		}
        break;
    case "changeStatus":
        $value = $_POST['status'];
        $id = $_POST['id'];
        Appointments::updateField($id, 'status', $value);
        Appointments::updateField($id, 'color', $statusColor[$value]);
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
                'color' => $e['color'],
                'pets' => $e['name']
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

        $service_list = array();
        $package_list = array();
        $service_package_list = isset($_POST['service_list']) ? $_POST['service_list'] : '';
        foreach ($service_package_list as $sp) {
            if (substr($sp, 0, 1) == 'p') { array_push($package_list, substr($sp, 1)); }
            else { array_push($service_list, substr($sp, 1)); }
        }

        $fields = array(
            'appointment_date'      => isset($_POST['appointment_date']) ? mysqli_real_escape_string($database_connection, $_POST['appointment_date']) : '',
            'appointment_time'      => isset($_POST['appointment_time']) ? mysqli_real_escape_string($database_connection, $_POST['appointment_time']) : '',
            'visit_duration'        => isset($_POST['duration']) ? mysqli_real_escape_string($database_connection, $_POST['duration']) : '',
            'patient_id'            => isset($_POST['pet_id']) ? mysqli_real_escape_string($database_connection, $_POST['pet_id']) : 0,
            'service_list'          => implode(',', $service_list),
            'package_list'          => implode(',', $package_list),
            'patient_notes'          => isset($_POST['customer_notes']) ? mysqli_real_escape_string($database_connection, $_POST['customer_notes']) : ''
        );

        $sql = "UPDATE `meda_appointments` SET ";
        foreach ($fields as $key => $value) {
            $sql .= "`$key`='$value',";
        }
        $sql = rtrim($sql, ",");
        $sql .= " WHERE `id`=$app_id";

        database_void_query($sql);

        // update customer fields
        $petList = Pets::getAllPetsByCondition('id', $_POST['pet_id']);
        Patients::updatePatientDetails($petList[0] -> getField('customer_id'), array(
            'communication_preference'  => isset($_POST['communication_preference']) ? mysqli_real_escape_string($database_connection, $_POST['communication_preference']) : 'phone',
            'phone_SMS'                 => (isset($_POST['customer_phone_sms']) && ($_POST['customer_phone_sms'] == 'on')) ? 1 : 0,
            'cellphone_SMS'             => (isset($_POST['customer_cellphone_sms']) && ($_POST['customer_cellphone_sms'] == 'on')) ? 1 : 0,
            'alternate_name1'           => isset($_POST['alternate_name1']) ? mysqli_real_escape_string($database_connection, $_POST['alternate_name1']) : '',
            'alternate_phone1'          => isset($_POST['customer_alternate_phone1']) ? mysqli_real_escape_string($database_connection, $_POST['customer_alternate_phone1']) : '',
            'alternate_SMS1'            => (isset($_POST['customer_alternate_phone1_sms']) && ($_POST['customer_alternate_phone1_sms'] == 'on')) ? 1 : 0,
            'alternate_name2'           => isset($_POST['alternate_name2']) ? mysqli_real_escape_string($database_connection, $_POST['alternate_name2']) : '',
            'alternate_phone2'          => isset($_POST['customer_alternate_phone2']) ? mysqli_real_escape_string($database_connection, $_POST['customer_alternate_phone2']) : '',
            'alternate_SMS2'            => (isset($_POST['customer_alternate_phone2_sms']) && ($_POST['customer_alternate_phone2_sms'] == 'on')) ? 1 : 0,
        ));


        // update pet notes
        $petNotes = isset($_POST['pet_notes']) ? mysqli_real_escape_string($database_connection, $_POST['pet_notes']) : '';
        $sql = "UPDATE `meda_pets` SET `notes`='$petNotes' WHERE `id`={$_POST['pet_id']}";
        database_void_query($sql);

        break;
    case "createEvent":
        // get services and packages ids
        $service_list = array();
        $package_list = array();
        $service_package_list = isset($_POST['service_list']) ? $_POST['service_list'] : '';
        foreach ($service_package_list as $sp) {
            if (substr($sp, 0, 1) == 'p') { array_push($package_list, substr($sp, 1)); }
            else { array_push($service_list, substr($sp, 1)); }
        }

        Appointments::DoAppointment(array(
            'doctor_id'                 => $doc_id,
            'appointment_date'          => isset($_POST['appointment_date']) ? mysqli_real_escape_string($database_connection, $_POST['appointment_date']) : '',
            'appointment_time'          => isset($_POST['appointment_time']) ? mysqli_real_escape_string($database_connection, $_POST['appointment_time']) : '',
            'visit_duration'            => isset($_POST['duration']) ? mysqli_real_escape_string($database_connection, $_POST['duration']) : '',
            'patient_id'                => isset($_POST['pet_id']) ? mysqli_real_escape_string($database_connection, $_POST['pet_id']) : 0,
            'service_list'              => implode(',', $service_list),
            'package_list'              => implode(',', $package_list),
            'color'                     => $statusColor[1],
            'patient_notes'             => isset($_POST['customer_notes']) ? mysqli_real_escape_string($database_connection, $_POST['customer_notes']) : '',
            'pet_notes'                 => isset($_POST['pet_notes']) ? mysqli_real_escape_string($database_connection, $_POST['pet_notes']) : ''
        ));
    
        // update customer fields
        $petList = Pets::getAllPetsByCondition('id', $_POST['pet_id']);
        Patients::updatePatientDetails($petList[0] -> getField('customer_id'), array(
            'communication_preference'  => isset($_POST['communication_preference']) ? $_POST['communication_preference'] : 'phone',
            'phone_SMS'                 => (isset($_POST['customer_phone_sms']) && ($_POST['customer_phone_sms'] == 'on')) ? 1 : 0,
            'cellphone_SMS'             => (isset($_POST['customer_cellphone_sms']) && ($_POST['customer_cellphone_sms'] == 'on')) ? 1 : 0,
            'alternate_name1'           => isset($_POST['alternate_name1']) ? mysqli_real_escape_string($database_connection, $_POST['alternate_name1']) : '',
            'alternate_phone1'          => isset($_POST['alternate_phone1']) ? mysqli_real_escape_string($database_connection, $_POST['alternate_phone1']) : '',
            'alternate_SMS1'            => (isset($_POST['customer_alternate_phone1_sms']) && ($_POST['customer_alternate_phone1_sms'] == 'on')) ? 1 : 0,
            'alternate_name2'           => isset($_POST['alternate_name2']) ? mysqli_real_escape_string($database_connection, $_POST['alternate_name2']) : '',
            'alternate_phone2'          => isset($_POST['alternate_phone2']) ? mysqli_real_escape_string($database_connection, $_POST['alternate_phone2']) : '',
            'alternate_SMS2'            => (isset($_POST['customer_alternate_phone2_sms']) && ($_POST['customer_alternate_phone2_sms'] == 'on')) ? 1 : 0,
        ));

        break;
    case "deleteEvent":
        $id = isset($_POST['id']) ? mysqli_real_escape_string($database_connection, $_POST['id']) : '';
        $sql = "UPDATE `meda_appointments` SET `status`=2 WHERE `id`=$id";
        database_void_query($sql);
        $sql = "SELECT `appointment_number` FROM `meda_appointments` WHERE `id`=$id";
        $result = database_query($sql, DATA_ONLY,FIRST_ROW_ONLY);
        Appointments::SendAppointmentEmail('appointment_canceled', $result['appointment_number']);
        break;
    case "petAutocomplete":
        $term = isset($_REQUEST['term']) ? mysqli_real_escape_string($database_connection, $_REQUEST['term']) : '';
        /*
            $petList = array(
                '<customer_id>' => array(
                    'fullName' => '<string>',
                    'phone' => '<string>',
                    'pet' => '<string>'
                )
            )
        */
        $petList = array();

        $sql = "SELECT `p`.`id`, `p`.`name`, CONCAT(`c`.`first_name`, ' ', `c`.`last_name`) AS `fullName`, `p`.`notes`, `c`.`phone`, `c`.`email`
                    FROM `meda_pets` AS `p`
                    LEFT JOIN `meda_patients` AS `c` ON `p`.`customer_id`=`c`.`id`
                    LEFT JOIN `providers_customers` AS `pc` ON `c`.`id`=`pc`.`customer_id`
                    WHERE `pc`.`provider_id`=$doc_id AND `p`.`name` LIKE '%$term%'";
        $results = database_query($sql, DATA_AND_ROWS, ALL_ROWS);
        foreach ($results[0] as $r) {
            array_push($petList, $r);
        }

        // format the output
        $output = array();

        foreach ($results[0] as $r) {
            $record = array(
                'id' => '',
                'label' => $r['name'],
                'description' => $r['fullName'],
                'phone' => $r['phone'],
                'email' => $r['email'],
                'notes' => $r['notes'],
                'value' => $r['id'],
            );
            array_push($output, $record);
        }
        echo json_encode($output);
        break;
    case "createCustomer":
        $customerDetails = array(
            'first_name' => isset($_POST['customer_fname']) ? mysqli_real_escape_string($database_connection, $_POST['customer_fname']) : '',
            'last_name' => isset($_POST['customer_lname']) ? mysqli_real_escape_string($database_connection, $_POST['customer_lname']) : '',
            'phone' => isset($_POST['customer_phone']) ? mysqli_real_escape_string($database_connection, $_POST['customer_phone']) : '',
            'email' => isset($_POST['customer_email']) ? mysqli_real_escape_string($database_connection, $_POST['customer_email']) : ''
        );
        $petDetails = array(
            'name' => isset($_POST['pet_name']) ? mysqli_real_escape_string($database_connection, $_POST['pet_name']) : '',
            'type' => isset($_POST['pet_type']) ? mysqli_real_escape_string($database_connection, $_POST['pet_type']) : '',
            'breed' => isset($_POST['pet_breed']) ? mysqli_real_escape_string($database_connection, $_POST['pet_breed']) : ''
        );
        $id = 0;

        // check if customer already exists
        $sql = "SELECT `id` FROM `meda_patients` WHERE `phone`='{$customerDetails['phone']}' AND `email`='{$customerDetails['email']}'";
        $result = database_query($sql, DATA_AND_ROWS, FIRST_ROW_ONLY);
        // user doesn't exist
        if ($result[1] == 0) {
            $sql = "INSERT INTO `meda_patients`(`" . implode(array_keys($customerDetails), '`, `') . "`) VALUES ('" . implode(array_values($customerDetails), "', '") . "')";
            database_void_query($sql);

            $sql = "SELECT `id` FROM `meda_patients` WHERE `phone`='{$customerDetails['phone']}' AND `email`='{$customerDetails['email']}'";
            $r = database_query($sql, DATA_AND_ROWS, FIRST_ROW_ONLY);
            $id = $r[0]['id'];
        } else { $id = $result[0]['id']; }

        // insert a new entry in providers_customers table
        $sql = "INSERT INTO `providers_customers`(`provider_id`, `customer_id`) VALUES($doc_id, $id)";
        database_void_query($sql);

        // insert a new pet
        $petType = PetTypes::getPetTypesByCondition('name', $petDetails['type']);
        $newType = null;
        // if pet type cannot be found -> add new pet type
        if (empty($petType)) {
            $newType = new PetTypes();
            $newType -> setName($petDetails['type']);
            $newType -> saveType();
        } else {
            $newType = $petType[0];
        }
        $newPet = new Pets(array(
                'customer_id' => $id,
                'name' => $petDetails['name'],
                'type_id' => $newType -> getId(),
                'breed' => $petDetails['breed']
            ));
        $newPet -> add();

        // generate returned data
        $output = array(
            'id' => $id,
            'customer_name' => $customerDetails['first_name'] . ' ' . $customerDetails['last_name'],
            'customer_phone' => $customerDetails['phone'],
            'customer_email' => $customerDetails['email'],
            'pet_id' => $newPet -> getId(),
            'pet_name' => $newPet -> getName()
        );
        echo json_encode($output);
        break;
    case "petDetails":
        $id = isset($_POST['id']) ? mysqli_real_escape_string($database_connection, $_POST['id']) : '';
        $sql = "SELECT `p`.`name`, `p`.`breed`, `c`.`first_name`, `c`.`last_name` 
                    FROM `meda_pets` AS `p`
                    LEFT JOIN `meda_patients` AS `c` ON `p`.`customer_id`=`c`.`id`
                    WHERE `p`.`id`=$id";
        $result = database_query($sql, DATA_AND_ROWS, FIRST_ROW_ONLY);

        $output = array(
            'name' => $result[0]['name'],
            'breed' => $result[0]['breed'],
            'customerName' => $result[0]['first_name'] . ' ' . $result[0]['last_name'],
        );
        echo json_encode($output);
        break;
}
?>
