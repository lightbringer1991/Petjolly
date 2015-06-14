<?php
/**
 *	Class Pets
 *  -------------- 
 *  Description : encapsulates ammenty methods and properties
 *	Written by  : lightbringer
 *	Version     : 1.0.0
 *  Updated	    : 18-03-2015
 *  Usage       : MedicalAppointment
 *	
 *	PUBLIC				  	STATIC				 	PRIVATE
 * 	------------------	  	---------------     	---------------
 *	__construct			  	getAllAmmenties                                  
 *	__destruct            	GetAmmenties                                          
 *	getId       
 *	getAmenty
 *
 **/
 
 class Ammenties {
	private $id;
	private $ammenty;
	
	public function __construct($i, $a) {
		$this -> id = $i;
		$this -> ammenty = $a;
	}
	
	public function __destruct() { }
	
	public function getId() { return $this -> id; }
	public function getAmmenty() { return $this -> ammenty; }
	
	public static function getAllAmmenties() {
		$allAmmenties = array();
		$sql = "SELECT * FROM `ammenties`";
		$result = database_query($sql, DATA_AND_ROWS, ALL_ROWS);
		foreach ($result[0] as $r) {
			array_push($allAmmenties, new Ammenties($r['id'], $r['ammenty']));
		}
		return $allAmmenties;
	}
	
	public static function GetAmmenties($id) {
		$allAmmenties = array();
		$sql = "SELECT `id`, `ammenty` FROM `ammenties`, `providers_ammenties` WHERE `provider_id`=$id AND `ammenty_id`=`id`";
		$result = database_query($sql, DATA_AND_ROWS, ALL_ROWS);
		foreach ($result[0] as $r) {
			array_push($allAmmenties, new Ammenties($r['id'], $r['ammenty']));
		}
		return $allAmmenties;
	}
 }
?>