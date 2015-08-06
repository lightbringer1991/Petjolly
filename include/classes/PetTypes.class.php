<?php
class PetTypes {
	private $id;
	private $name;
	
	public function __construct($id = -1, $name = '') {
		$this -> id = $id;
		$this -> name = $name;
	}
	
	public function __destruct() {
		// nothing to do
	}
	
	public function getId() { return $this -> id; }
	public function getName() { return $this -> name; }
	
	public function setName($name) { $this -> name = $name; }
	
	public function saveType() {
		if ($this -> id == -1) {
			$types = PetTypes::getPetTypesByCondition('name', $this -> name);
			if (count($types) == 0) {
				$sql = "INSERT INTO `meda_pet_types`(`name`) VALUES ('" . $this -> name . "')";
				database_void_query($sql);
				$aType = PetTypes::getPetTypesByCondition('name', $this -> name);
				$this -> id = $aType[0] -> getId();
				return true;
			}
		}
		return false;
	}
	
	public static function getPetTypesByCondition($field = '', $value = '') {
		$sql = "SELECT * FROM `meda_pet_types`";
		if ($field != '') {
			$sql .= " WHERE `$field`='$value'";
		}
		$allTypes = array();
		$result = database_query($sql, DATA_AND_ROWS, ALL_ROWS);
		foreach ($result[0] as $r) {
			array_push($allTypes, new PetTypes($r['id'], $r['name']));
		}
		return $allTypes;
	}
}
?>