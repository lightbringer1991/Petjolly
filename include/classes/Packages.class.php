<?php
class Packages {
	private $id;
	private $name;
	private $description;
    private $providerID;
	private $service_ids;			// array contains all services within this package
	private $duration;
	private $price;
    private $isActive;

	public function __construct($i = -1, $n = '', $des = '', $pid = 0, $s = array(), $d = 0, $p = 0, $active = 0) {
		$this -> id = $i;
		$this -> name = $n;
		$this -> description = $des;
        $this -> providerID = $pid;
		$this -> service_ids = $s;
		$this -> duration = $d;
		$this -> price = $p;
        $this -> isActive = $active;
	}

	public function getId() { return $this -> id; }
	public function getName() { return $this -> name; }
	public function getDescription() { return $this -> description; }
    public function getProviderID() { return $this -> providerID; }
	public function getServiceIds() { return $this -> service_ids; }
	public function getServices() {
		$result = array();
		foreach ($this -> service_ids as $id) {
			array_push($result, Services::getServiceById($id));
		}
		return $result;
	}
	public function getDuration() { return $this -> duration; }
	public function getPrice() { return $this -> price; }
    public function isActive() { return $this -> isActive; }

	public function add() {
		if ($this -> id == -1) {
			// insert package
			$sql = sprintf("INSERT INTO `packages`(`name`, `description`, `provider_id`, `duration`, `price`, `isActive`) VALUES('%s', '%s', '%s', '%s', '%s', '%s')", $this -> name, $this -> description, $this -> providerID, $this -> duration, $this -> price, $this -> isActive);
			database_void_query($sql);
			$sql = sprintf("SELECT `id` FROM `packages` WHERE `name`='%s' AND `description`='%s' AND `provider_id`='%s' AND `duration`='%s' AND `price`='%s' AND `isActive`='%s'", $this -> name, $this -> description, $this -> providerID, $this -> duration, $this -> price, $this -> isActive);
			$result = database_query($sql);
			$this -> id = $result[0]['id'];
			
			// link services and package
			foreach ($this -> service_ids as $sid) {
				$sql = sprintf("INSERT INTO `packages_services`(`package_id`, `service_id`) VALUES(%s, %s)", $this -> id, $sid);
				database_void_query($sql);
			}
		}
	}
	
	public function edit() {
		if ($this -> id != -1) {
			// edit name, duration, price
			$sql = sprintf("UPDATE `packages` SET 
								`name`='%s',
								`description`='%s',
								`provider_id`='%s',
								`duration`='%s',
								`price`='%s',
								`isActive`='%s'
							WHERE `id`=%s", $this -> name, $this -> description, $this -> providerID, $this -> duration, $this -> price, $this -> isActive, $this -> id);
			database_void_query($sql);
			
			// edit services list
			// remove previous list
			$sql = "DELETE FROM `packages_services` WHERE `package_id`=" . $this -> id;
			database_void_query($sql);
			// insert new list
			foreach ($this -> service_ids as $sid) {
				$sql = sprintf("INSERT INTO `packages_services`(`package_id`, `service_id`) VALUES(%s, %s)", $this -> id, $sid);
				database_void_query($sql);
			}
		}
	}
	
	public function remove() {
		if ($this -> id != -1) {
			// remove package-service link
			$sql = "DELETE FROM `packages_services` WHERE `package_id`=" . $this -> id;
			database_void_query($sql);

			// remove package from database
			$sql = "DELETE FROM `packages` WHERE `id`=" . $this -> id;
			database_void_query($sql);			
		}
	}

	public static function getAllPackagesByCondition($field = '', $value = '', $active = -1) {
		$sql = "SELECT * FROM `packages`";
        $linkWord = "WHERE";

        if ($active != -1) {
            $sql .= " WHERE `isActive`=$active ";
            $linkWord = "AND";
        }

		if ($field != '') {
			$sql .= " $linkWord `$field`='$value'";
		}
		
		$allPackages = array();
		$result = database_query($sql, DATA_AND_ROWS, ALL_ROWS);
		foreach ($result[0] as $r) {
			// get all services in this package
			$id = $r['id'];
			$secondSql = "SELECT `service_id` FROM `packages_services` WHERE `package_id`=$id";
			$serviceQuery = database_query($secondSql);
			$serviceList = array();
			foreach ($serviceQuery as $sq) {
				array_push($serviceList, $sq['service_id']);
			}

			array_push($allPackages, new Packages($r['id'], $r['name'], $r['description'], $r['provider_id'], $serviceList , $r['duration'], $r['price'], $r['isActive']));
		}
		return $allPackages;
	}

    public static function getAllActivePackagesByProviderID($id) {
        return Packages::getAllPackagesByCondition('provider_id', $id, 1);
    }

    public static function getAllPackagesByProviderID($id) {
        return Packages::getAllPackagesByCondition('provider_id', $id);
    }

	public static function getPackageById($id) {
		$results = Packages::getAllPackagesByCondition('id', $id);
        if (count($results) == 0) { return null; }
		else { return $results[0]; }
	}
}
?>