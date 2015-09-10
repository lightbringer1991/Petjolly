<?php
/**
 *	Class Pets
 *  -------------- 
 *  Description : encapsulates pets methods and properties
 *	Written by  : lightbringer
 *	Version     : 1.0.0
 *  Updated	    : 18-03-2015
 *  Usage       : MedicalAppointment
 *	
 *	PUBLIC				  	STATIC				 	PRIVATE
 * 	------------------	  	---------------     	---------------
 *	__construct			  	getAllPetsByCondition                                  
 *	__destruct            	                          
 *	add	    				
 *	remove  				
 *	update                  
 *	getId       
 *	getName
 *	getType
 *	getBreed
 *	expose
 **/
class Pets extends ModelBase {
	
	public function __construct($fields) {
		parent::__construct($fields);
	}
	
	public function getTableName() {
		return 'meda_pets';
	}

	public function __destruct() {
		// nothing to do
	}
	
	// return a list of class variables to be parsed to front end javascript via JSON
	public function expose() {
		return get_object_vars($this);
	}
	
	public static function getAllPetsByCondition($field = '', $value = '') {
		$sql = "SELECT * FROM `meda_pets`";
		if ($field != '') {
			$sql .= " WHERE `$field`='$value'";
		}
		
		$allPets = array();
		$result = database_query($sql, DATA_AND_ROWS, ALL_ROWS);
		foreach ($result[0] as $r) {
			array_push($allPets, new Pets($r));
		}
		return $allPets;
	}

	public static function getAllPetsByProviderId($id) {
		$sql = "SELECT * FROM `meda_pets` AS `p`
					LEFT JOIN `providers_customers` AS `pc` ON `p`.`customer_id`=`pc`.`customer_id`
					WHERE `pc`.`provider_id`=$id";
		$result = database_query($sql, DATA_AND_ROWS, ALL_ROWS);
		$allPets = array();
		foreach ($result[0] as $r) {
			array_push($allPets, new Pets($r));
		}
		return $allPets;
	}

	public static function getPetById($id) {
		$sql = "SELECT * FROM `meda_pets` WHERE `id`=$id";
		$result = database_query($sql, DATA_AND_ROWS, FIRST_ROW_ONLY);
		if ($result[1] == 0) {
			return null;
		} else {
			return new Pets($result[0]);
		}
	}
}

?>