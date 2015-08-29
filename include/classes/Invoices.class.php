<?php
/**
 *	Class Invoices
 *  -------------- 
 *  Description : encapsulates invoices methods and properties
 *	Written by  : lightbringer
 *	Version     : 1.0.0
 *  Updated	    : 29-08-2015
 *  Usage       : MedicalAppointment
 *	
 *	PUBLIC				  	STATIC				 	PRIVATE
 * 	------------------	  	---------------     	---------------
 *	__construct			  	                                  
 *	__destruct            	                          
 *	add	    				
 *	remove  				
 *	update                  
 *	expose
 **/
class Invoices {
	private $fields;

	// $params = array(<field> => <value>);
	public function __construct($params = array()) {
		$this -> fields = $params;
	}

	public function getField($field) {
		return isset($this -> fields[$field]) ? $this -> fields[$field] : '';
	}

	// $params = array(<field> => <value>);
	public function update($params) {
		$data = $this -> cleanAllFields();
		$sql = "UPDATE `meda_invoices` SET ";
		foreach ($params as $k => $v) {
			$sql .= "`$k`='$v', ";
		}
		$sql = substr($sql, 0, -2); 	// remove ', '
		$sql .= " WHERE `id`={$this -> fields['id']}";

		database_void_query($sql);
	}

	public function add() {
		$data = $this -> cleanAllFields();
		$sql = "INSERT INTO `meda_invoices`(`" . implode('`, `', array_keys($data)) . "`) VALUES ('" . implode("', '", array_values($data)) . "')";
		database_void_query($sql);

		return database_insert_id();
	}

	public function __toString() {
		$apppointmentData = Appointments::getAppointmentById($this -> fields['appointment_id']);
		$total = 0;

		$output = "<table border='1' class='invoice-table col-md-12 col-xs-12 col-lg-12'>
					<tr>
						<td width='30%'><b>Customer name</b></td>
						<td colspan='2'>" . $apppointmentData[0]['first_name'] . " " . $apppointmentData[0]['last_name'] . "</td>
					</tr>
					<tr>
						<td><b>Date/time</b></td>
						<td colspan='2'>" . $apppointmentData[0]['appointment_date'] . " " . $apppointmentData[0]['appointment_time'] . "</td>
					</tr>";
		// add service list and its price
		$service_list = explode(',', $apppointmentData[0]['service_list']);
		$output .= "<tr>
						<td colspan='3'><b>Services</b></td>
					</tr>";
		foreach ($service_list as $s) {
			$aService = Services::getServiceById($s);
			if ($aService == null) { break; }
			$total += $aService -> getPrice();
			$output .= "<tr>
							<td></td>
							<td>" . $aService -> getName() . "</td>
							<td>$" . $aService -> getPrice() . "</td>
						</tr>";
		}

		// add package list and its price
		$package_list = explode(',', $apppointmentData[0]['package_list']);
		$output .= "<tr>
						<td colspan='3'><b>Packages</b></td>
					</tr>";
		foreach ($package_list as $p) {
			$aPackage = Packages::getPackageById($p);
			if ($aPackage == null) { break; }
			$total += $aPackage -> getPrice();
			$output .= "<tr>
							<td></td>
							<td>" . $aPackage -> getName() . "</td>
							<td>$" . $aPackage -> getPrice() . "</td>
						</tr>";
		}

		// add discount
		$output .= "<tr>
						<td colspan='2'><b>Discount</b></td>
						<td>$" . $this -> fields['discount'] . "
					</tr>";
		$total -= $this -> fields['discount'];

		// echo price
		$output .= "<tr>
						<td colspan='2'><b>Total Price</b></td>
						<td>$" . $total . "</td>
					</tr>";

		// end table
		$output .= "</table>";
		return $output;
	}

	public static function createInvoiceFromAppointmentId($id) {
		$sql = "INSERT IGNORE INTO `meda_invoices`(`appointment_id`, `discount`) VALUES ($id, 0)";
		database_void_query($sql);
	}

	public static function getInvoiceByAppointmentId($id) {
		// make sure there is a record for the appointment
		self::createInvoiceFromAppointmentId($id);
		$id = mysql_real_escape_string($id);
		$sql = "SELECT * FROM `meda_invoices` WHERE `appointment_id`=$id";
		$result = database_query($sql, DATA_AND_ROWS, FIRST_ROW_ONLY);
		return new Invoices($result[0]);
	}

	private function cleanAllFields() {
		$data = array();
		foreach ($this -> fields as $k => $v) {
			$data[$k] = mysql_real_escape_string($v);
		}
		return $data;
	}
}
?>