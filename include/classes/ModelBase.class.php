<?php
class ModelBase {
	protected $fields;

	public function __construct($fields) {
		$this -> fields = $fields;
	}

	public function getTableName() {
		return 'base table';
	}

	public function getField($field) {
		if (in_array($field, array_keys($this -> fields))) {
			return $this -> fields[$field];
		} else {
			return null;
		}
	}

	public function update($field, $value) {
		$sql = "UPDATE `" . $this -> getTableName() . "` SET `$field`='$value' WHERE `id`=" . $this -> fields['id'];
		database_void_query($sql);
	}

	public function add() {
		$data = $this -> cleanAllFields();
		$sql = "INSERT INTO `" . $this -> getTableName() . "`(`" . implode('`, `', array_keys($data)) . "`) VALUES ('" . implode("', '", array_values($data)) . "')";
		database_void_query($sql);
	}

	public function cleanAllFields() {
		$data = array();
		foreach ($this -> fields as $k => $v) {
			$data[$k] = clean_field($v);
		}
		return $data;
	}
}
?>
