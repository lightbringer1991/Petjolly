<?php

error_reporting(E_ALL);
ini_set('display_errors','1');
/**
* @project ApPHP Medical Appointment
* @copyright (c) 2012 - 2014 ApPHP
* @author ApPHP <info@apphp.com>
* @license http://www.gnu.org/licenses/
*/

// *** Make sure the file isn't accessed directly
defined('APPHP_EXEC') or die('Restricted Access');
$step = isset($_REQUEST['step'])?$_REQUEST['step']:'';
//--------------------------------------------------------------------------
if($objLogin->IsLoggedIn() && (ModulesSettings::Get('doctors', 'allow_registration') == 'yes') && $step !=''){
#echo "<pre>";
echo var_dump($_REQUEST);
	$doc_id = (int)$objLogin->GetLoggedID();
	switch ($step) {
		case 1: 
			// get longitude and lattitude
			$address = isset($_REQUEST['address']) ? prepare_input($_REQUEST['address']) : '';
			$city = isset($_REQUEST['city']) ? prepare_input($_REQUEST['city']) : '';
			$state = isset($_REQUEST['state']) ? prepare_input($_REQUEST['state']) : '';
			$zipcode = isset($_REQUEST['zipcode']) ? prepare_input($_REQUEST['zipcode']) : '';
			$mapaddress = urlencode("$address $city $state $zipcode");
			$url = "https://maps.googleapis.com/maps/api/geocode/xml?address=$mapaddress&sensor=false";
			$page = file_get_contents($url);                        
			$xml = new SimpleXMLElement($page);
			$longitude = @$xml->result->geometry->location->lng;
			$latitude = @$xml->result->geometry->location->lat;
			$new_address = $address ."==". $city ."==". $state ."==". $zipcode;
			
			$sql = "INSERT INTO " . TABLE_DOCTOR_ADDRESSES . 
				"(`doctor_id`, `address`, `latitude`, `longitude`, `access_level`, `priority_order`, `is_default`, `is_active` )
				VALUES ( '$doc_id', '$new_address', '$latitude', '$longitude', 'public', 0, 0, 1);"; 
			database_void_query($sql);
			
			// get business hours
			$monOp = isset($_REQUEST['monday_open']) ? prepare_input($_REQUEST['monday_open']) : '';
			$monCl = isset($_REQUEST['monday_close']) ? prepare_input($_REQUEST['monday_close']) : '';
			$tueOp = isset($_REQUEST['tuesday_open']) ? prepare_input($_REQUEST['tuesday_open']) : '';
			$tueCl = isset($_REQUEST['tuesday_close']) ? prepare_input($_REQUEST['tuesday_close']) : '';
			$wedOp = isset($_REQUEST['wednesday_open']) ? prepare_input($_REQUEST['wednesday_open']) : '';
			$wedCl = isset($_REQUEST['wednesday_close']) ? prepare_input($_REQUEST['wednesday_close']) : '';
			$thurOp = isset($_REQUEST['thursday_open']) ? prepare_input($_REQUEST['thursday_open']) : '';
			$thurCl = isset($_REQUEST['thursday_close']) ? prepare_input($_REQUEST['thursday_close']) : '';
			$friOp = isset($_REQUEST['friday_open']) ? prepare_input($_REQUEST['friday_open']) : '';
			$friCl = isset($_REQUEST['friday_close']) ? prepare_input($_REQUEST['friday_close']) : '';
			$satOp = isset($_REQUEST['saturday_open']) ? prepare_input($_REQUEST['saturday_open']) : '';
			$satCl = isset($_REQUEST['saturday_close']) ? prepare_input($_REQUEST['saturday_close']) : '';
			$sunOp = isset($_REQUEST['sunday_open']) ? prepare_input($_REQUEST['sunday_open']) : '';
			$sunCl = isset($_REQUEST['sunday_close']) ? prepare_input($_REQUEST['sunday_close']) : '';
			
			$sql = "UPDATE " . TABLE_DOCTORS . " SET 
					list_mon_open='$monOp',
					list_mon_close='$monCl',
					list_tue_open='$tueOp',
					list_tue_close='$tueCl',
					list_wed_open='$wedOp',
					list_wed_close='$wedCl',
					list_thur_open='$thurOp',
					list_thur_close='$thurCl',
					list_fri_open='$friOp',
					list_fri_close='$friCl',
					list_sat_open='$satOp',
					list_sat_close='$satCl',
					list_sun_open='$sunOp',
					list_sun_close='$sunCl' 
				WHERE id=$doc_id";
			database_void_query($sql);
			break;
	}
}
	
/*	
	if($step == 'step1'){
		$address = isset($_REQUEST['address'])?$_REQUEST['address']:'';
		$city = isset($_REQUEST['city'])?$_REQUEST['city']:'';
		$state = isset($_REQUEST['state'])?$_REQUEST['state']:'';
		$zipcode = isset($_REQUEST['zipcode'])?$_REQUEST['zipcode']:'';
		$mapaddress = urlencode("$address $city $state $zipcode");
		$url = "https://maps.googleapis.com/maps/api/geocode/xml?address=$mapaddress&sensor=false";
        // Retrieve the URL contents
		$page = file_get_contents($url);                        
		$xml = new SimpleXMLElement($page);
		$longitude = @$xml->result->geometry->location->lng;
		$latitude = @$xml->result->geometry->location->lat;
		
		
		if($longitude && $latitude){
			$sql = "select count(*) from ".TABLE_DOCTOR_ADDRESSES." where latitude = '".$latitude."' and longitude = '".$longitude ."'";
			$result = mysql_query($sql);
			$total_nums = mysql_num_rows($result);
		}
		$new_address = $address ."==". $city ."==". $state ."==". $zipcode;
        //PRINT_R($POINT);
		$business_hrs =	serialize($_REQUEST['business_hours']);	
		if($address != '' && $business_hrs != ''){
			$monOp = '';
			$monCl = '';
			$tueOp = '';
			$tueCl = '';
			$wedOp = '';
			$wedCl = '';
			$thurOp = '';
			$thurCl = '';
			$friOp = '';
			$friCl = '';
			$satOp = '';
			$satCl = '';
			$sunOp = '';
			$sunCl = '';
			
			foreach($_REQUEST['business_hours']['weekday'] as $key => $val){
				switch($key){
					case 0 : $monOp = $_REQUEST['business_hours']['hours-start'][0];
							 $monCl = $_REQUEST['business_hours']['hours-end'][0];
							 break;
					case 1 : $tueOp = $_REQUEST['business_hours']['hours-start'][1];
							 $tueCl = $_REQUEST['business_hours']['hours-end'][1];
							 break;
					case 2 : $wedOp = $_REQUEST['business_hours']['hours-start'][2];
							 $wedCl = $_REQUEST['business_hours']['hours-end'][2];
							 break;
					case 3 : $thurOp = $_REQUEST['business_hours']['hours-start'][3];
							 $thurCl = $_REQUEST['business_hours']['hours-end'][3];
							 break;
					case 4 : $friOp = $_REQUEST['business_hours']['hours-start'][4];
							 $friCl = $_REQUEST['business_hours']['hours-end'][4];
							 break;
					case 5 : $satOp = $_REQUEST['business_hours']['hours-start'][5];
							 $satCl = $_REQUEST['business_hours']['hours-end'][5];
							 break;
					case 6 : $sunOp = $_REQUEST['business_hours']['hours-start'][6];
							 $sunCl = $_REQUEST['business_hours']['hours-end'][6];
							 break;
				} 
			}
			
			
			
			$sql = 'UPDATE '.TABLE_DOCTORS.' SET 
					list_mon_open=\''.encode_text($monOp).'\',
					list_mon_close=\''.encode_text($monCl).'\',
					list_tue_open=\''.encode_text($tueOp).'\',
					list_tue_close=\''.encode_text($tueCl).'\',
					list_wed_open=\''.encode_text($wedOp).'\',
					list_wed_close=\''.encode_text($wedCl).'\',
					list_thur_open=\''.encode_text($thurOp).'\',
					list_thur_close=\''.encode_text($thurCl).'\',
					list_fri_open=\''.encode_text($friOp).'\',
					list_fri_close=\''.encode_text($friCl).'\',
					list_sat_open=\''.encode_text($satOp).'\',
					list_sat_close=\''.encode_text($satCl).'\',
					list_sun_open=\''.encode_text($sunOp).'\',
					list_sun_close=\''.encode_text($sunCl).'\'
			 WHERE id = "'.$doc_id .'"'; 
				mysql_query($sql);
			if($total_nums <= 0){
				$sql = 'INSERT INTO '.TABLE_DOCTOR_ADDRESSES.'(`doctor_id`,
																	`address`,
																	`latitude`,
																	`longitude`,
																	`access_level`,
																	`priority_order`,
																	`is_default`,
																	`is_active` ) VALUES ( '.$doc_id.',
																	 "'.encode_text($new_address).'",
																	 "'.$latitude.'",
																	 "'.$longitude.'",
																	 "public",
																	 "0",
																	 "0",
																	 "1"
																	);'; 
				mysql_query($sql);
			}
				echo true;
				exit;
		} else {
			echo false;
			exit;
		}
		
	} else if($step == 'step2'){
	
		$phone = isset($_REQUEST['phone'])?$_REQUEST['phone']:'';
		$mobile_number = isset($_REQUEST['mobile_number'])?$_REQUEST['mobile_number']:'';
		$list_website = isset($_REQUEST['list_website'])?$_REQUEST['list_website']:'';
		$list_twitter = isset($_REQUEST['list_twitter'])?$_REQUEST['list_twitter']:'';
		$list_facebook = isset($_REQUEST['list_facebook'])?$_REQUEST['list_facebook']:'';
        $list_google = isset($_REQUEST['list_google'])?$_REQUEST['list_google']:'';
        $list_storefeatured = isset($_REQUEST['storerfeatured'])?$_REQUEST['storerfeatured']:'';  
        $popupdesc = isset($_REQUEST['popupdesc'])?$_REQUEST['popupdesc']:'';  
		$map_flg = 1;
		$fax = isset($_REQUEST['fax'])?$_REQUEST['fax']:'';
		$sql = 'UPDATE '.TABLE_DOCTORS.' SET 
				list_facebook=\''.encode_text($list_facebook).'\',
				list_google=\''.encode_text($list_google).'\',
				list_twitter=\''.encode_text($list_twitter).'\',
				list_website=\''.encode_text($list_website).'\',
				list_mobile=\''.encode_text($mobile_number).'\',
				phone=\''.encode_text($phone).'\',
                fax=\''.encode_text($fax).'\',
                mapflg=\''.$map_flg.'\',
                storerfeatured=\''.$list_storefeatured.'\',
                popupdesc=\''.$popupdesc.'\'
                
                
		 WHERE id = "'.$doc_id .'"'; 
			mysql_query($sql);
			echo true;
			exit;

	}
	
}
*/
?>