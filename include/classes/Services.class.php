<?php
class Services {
	private $id;
	private $name;
	private $description;
    private $providerID;                    // default to be current logged in userid
	private $duration;
	private $price;
    private $isActive;

	public function __construct($i = -1, $n = '', $des = '', $pid = 0, $d = 0, $p = 0, $active = 0) {
		$this -> id = $i;
		$this -> name = $n;
		$this -> description = $des;
        $this -> providerID = $pid;
		$this -> duration = $d;
		$this -> price = $p;
        $this -> isActive = $active;
	}

	public function getId() { return $this -> id; }
	public function getName() { return $this -> name; }
	public function getDescription() { return $this -> description; }
    public function getProviderID() { return $this -> providerID; }
	public function getDuration() { return $this -> duration; }
	public function getPrice() { return $this -> price; }
    public function isActive() { return $this -> isActive; }

	public function add() {
		if ($this -> id == -1) {
			$sql = sprintf("INSERT INTO `services`(`name`, `description`, `provider_id`  , `duration`, `price`, `isActive`) VALUES('%s', '%s', '%s', '%s', '%s', '%s')", $this -> name, $this -> description, $this -> providerID, $this -> duration, $this -> price, $this -> isActive);
			database_void_query($sql);
			$sql = sprintf("SELECT `id` FROM `services` WHERE `name`='%s' AND `description`='%s' AND `provider_id`='%s' AND `duration`='%s' AND `price`='%s' AND `isActive`='%s'", $this -> name, $this -> description, $this -> providerID, $this -> duration, $this -> price, $this -> isActive);
			$result = database_query($sql);
			$this -> id = $result[0]['id'];
		}
	}

	public function edit() {
		if ($this -> id != -1) {
			$sql = sprintf("UPDATE `services` SET 
								`name`='%s',
								`description`='%s',
								`provider_id`='%s',
								`duration`='%s',
								`price`='%s',
								`isActive`='%s'
							WHERE `id`=%s", $this -> name, $this -> description, $this -> providerID, $this -> duration, $this -> price, $this -> isActive, $this -> id);
			database_void_query($sql);
		}
	}

	public function remove() {
		if ($this -> id != -1) {
			// delete links between any packages and this service
			$sql = "DELETE FROM `packages_services` WHERE `service_id`=" . $this -> id;
			database_void_query($sql);			

			// delete from services table
			$sql = "DELETE FROM `services` WHERE `id`=" . $this -> id;
			database_void_query($sql);
		}
	}

    /*
     * get all services by certain condition, default is all services
     */
	public static function getAllServicesByCondition($field = '', $value = '', $active = -1) {
		$sql = "SELECT * FROM `services`";
        $linkWord = "WHERE";

        if ($active != -1) {
            $sql .= " WHERE `isActive`=$active ";
            $linkWord = "AND";
        }
		if ($field != '') {
			$sql .= " $linkWord `$field`='$value'";
		}

		$allServices = array();
		$result = database_query($sql, DATA_AND_ROWS, ALL_ROWS);
		foreach ($result[0] as $r) {
			array_push($allServices, new Services($r['id'], $r['name'], $r['description'], $r['provider_id'], $r['duration'], $r['price'], $r['isActive']));
		}
		return $allServices;
	}

    public static function getAllActiveServicesByProviderID($id) {
        return Services::getAllServicesByCondition('provider_id', $id, 1);
    }

    public static function getAllServicesByProviderID($id) {
        return Services::getAllServicesByCondition('provider_id', $id);
    }

	public static function getServiceById($id) {
		$results = Services::getAllServicesByCondition('id', $id);
        if (count($results) == 0) { return null; }
		else { return $results[0]; }
	}
}
?>