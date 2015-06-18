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
class Pets {
	private $id;
	private $customer_id;
	private $name;
	private $type_id;
	private $breed;
	
	public function __construct($newId = -1, $newCustomer_id = -1, $newName = '', $newTypeID = '', $newBreed = '') {
		//initiate an existing record
		if (($newId != -1) and ($newCustomer_id == -1) and ($newName == '') and ($newTypeID == '') and ($newBreed == '')) {
			$aPet = Pets::getPetById($newId);
			$this -> id = $aPet -> getId();
			$this -> customer_id = $aPet -> getCustomerId();
			$this -> name = $aPet -> getName();
			$this -> type_id = $aPet -> getTypeId();
			$this -> breed = $aPet -> getBreed();
		}
		else {
			$this -> id = $newId;
			$this -> customer_id = $newCustomer_id;
			$this -> name = $newName;
			$this -> type_id = $newTypeID;
			$this -> breed = $newBreed;
		}
	}
	
	public function __destruct() {
		// nothing to do
	}
	
	public function getId() { return $this -> id; }
	public function getCustomerId() { return $this -> customer_id; }
	public function getName() { return $this -> name; }
	public function getTypeId() { return $this -> type_id; }
	public function getBreed() { return $this -> breed; }

	public function add() {
		if ($this -> id == -1) {
			$sql = sprintf("INSERT INTO `meda_pets`(`customer_id`, `name`, `type_id`, `breed`) VALUES('%s', '%s', '%s', '%s')", $this -> customer_id, $this -> name, $this -> type_id, $this -> breed);
			database_void_query($sql);
		}
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
			array_push($allPets, new Pets($r['id'], $r['customer_id'], $r['name'], $r['type_id'], $r['breed']));
		}
		return $allPets;
	}
}

?>