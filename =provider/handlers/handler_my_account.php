<?php

/**

* @project ApPHP Medical Appointment

* @copyright (c) 2012 - 2014 ApPHP

* @author ApPHP <info@apphp.com>

* @license http://www.gnu.org/licenses/

*/



// *** Make sure the file isn't accessed directly

defined('APPHP_EXEC') or die('Restricted Access');

//--------------------------------------------------------------------------



if(!$objLogin->IsLoggedInAsDoctor()){

	$objSession->SetMessage('notice', str_replace('_ACCOUNT_', 'doctor', _MUST_BE_LOGGED));

    redirect_to('index.php?doctor=login');

}else{

	if(isset($_POST['first_name'])){

	$first_name   = isset($_POST['first_name']) ? prepare_input($_POST['first_name']) : '';

	

	$last_name    = isset($_POST['last_name']) ? prepare_input($_POST['last_name']) : '';

	$mobile       = isset($_POST['mobile']) ? prepare_input($_POST['mobile']) : '';

	$title        = isset($_POST['title']) ? prepare_input($_POST['title']) : '';



	$website = isset($_POST['website']) ? prepare_input($_POST['website']) : '';

	$twitter_username = isset($_POST['twitter_username']) ? prepare_input($_POST['twitter_username']) : '';

	$facebook_url = isset($_POST['facebook_url']) ? prepare_input($_POST['facebook_url']) : '';



	

	

	$address   = isset($_POST['address']) ? prepare_input($_POST['address']) : '';

	
	$google_url      = isset($_POST['google_url']) ? prepare_input($_POST['google_url']) : '';

	$list_desc   = isset($_POST['list_desc']) ? prepare_input($_POST['list_desc']) : '';

	$price   = isset($_POST['price']) ? prepare_input($_POST['price']) : '';

	

	$phone       = isset($_POST['phone_no']) ? prepare_input($_POST['phone_no']) : '';

	$fax         = isset($_POST['fax']) ? prepare_input($_POST['fax']) : '';

	
	$email       = isset($_POST['email']) ? prepare_input($_POST['email']) : '';

	

	$user_name   = isset($_POST['user_name']) ? prepare_input($_POST['user_name']) : '';

	$user_password1 = isset($_POST['user_password1']) ? prepare_input($_POST['user_password1']) : '';

	$user_password2 = isset($_POST['user_password2']) ? prepare_input($_POST['user_password2']) : '';

	
	
	$monOp       = isset($_POST['monOp']) ? prepare_input($_POST['monOp']) : '';
	
	$monCl       = isset($_POST['monCl']) ? prepare_input($_POST['monCl']) : '';
	
	$tueOp       = isset($_POST['tueOp']) ? prepare_input($_POST['tueOp']) : '';
	
	$tueCl       = isset($_POST['tueCl']) ? prepare_input($_POST['tueCl']) : '';
	
	$wedOp       = isset($_POST['wedOp']) ? prepare_input($_POST['wedOp']) : '';
	
	$wedCl       = isset($_POST['wedCl']) ? prepare_input($_POST['wedCl']) : '';
	
	$thurOp       = isset($_POST['thurOp']) ? prepare_input($_POST['thurOp']) : '';
	
	$thurCl       = isset($_POST['thurCl']) ? prepare_input($_POST['thurCl']) : '';
	
	$friOp       = isset($_POST['friOp']) ? prepare_input($_POST['friOp']) : '';
	
	$friCl       = isset($_POST['friCl']) ? prepare_input($_POST['friCl']) : '';
	
	$satOp       = isset($_POST['satOp']) ? prepare_input($_POST['satOp']) : '';
	
	$satCl       = isset($_POST['satCl']) ? prepare_input($_POST['satCl']) : '';
	
	$sunOp       = isset($_POST['sunOp']) ? prepare_input($_POST['sunOp']) : '';
	
	$sunCl       = isset($_POST['sunCl']) ? prepare_input($_POST['sunCl']) : '';

	
	
	$query='update meda_doctors set 
				first_name=\''.encode_text($first_name).'\', 
				last_name=\''.encode_text($last_name).'\',
				email=\''.encode_text($email).'\',
				user_name=\''.encode_text($user_name).'\',
				phone=\''.encode_text($phone).'\',
				fax=\''.encode_text($fax).'\',
				list_title=\''.encode_text($title).'\',
				list_address=\''.encode_text($address).'\',
				list_mobile=\''.encode_text($mobile).'\',
				list_website=\''.encode_text($wesbite).'\',
				list_twitter=\''.encode_text($twitter_username).'\',
				list_facebook=\''.encode_text($facebook_url).'\',
				list_google=\''.encode_text($google_url).'\',
				list_desc=\''.encode_text($list_desc).'\',
				list_price=\''.encode_text($price).'\',
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
				list_sun_close=\''.encode_text($sunCl).'\'';
				
				
				
				if($user_password1!=''){
					if(!PASSWORDS_ENCRYPTION){
	
					$user_password = '\''.encode_text($user_password1).'\'';
	
					}else{
		
						if(strtolower(PASSWORDS_ENCRYPTION_TYPE) == 'aes'){					
		
							//$user_password = AES_ENCRYPT(encode_text($user_password1),PASSWORDS_ENCRYPT_KEY);
		
						}else if(strtolower(PASSWORDS_ENCRYPTION_TYPE) == 'md5'){
		
							//$user_password = MD5(encode_text($user_password1));
		
						}
		
					}
					
					//$query.=',user_password=\''.$user_password.'\'';
			
				}
				
				$query.=" where id=".(int)$objLogin->GetLoggedID();
				
			
				mysql_query($query);
				
				mysql_query("update meda_doctor_addresses set address='$address', latitude='".$_POST['lat']."', longitude='".$_POST['long']."' where doctor_id=".(int)$objLogin->GetLoggedID());
				
				mysql_query("delete from list_ammenties where doctor_id=".(int)$objLogin->GetLoggedID());
				foreach($_POST['ammenties'] as $amm){
						mysql_query("insert into list_ammenties values('','".(int)$objLogin->GetLoggedID()."','$amm')");
					}
 
	
	}

	$task = isset($_POST['task']) ? prepare_input($_POST['task']) : '';

	/*$password_one = isset($_POST['password_one']) ? prepare_input($_POST['password_one']) : '';

	$password_two = isset($_POST['password_two']) ? prepare_input($_POST['password_two']) : '';

	$msg = '';

	

	$objDoctors = new Doctors('me');	

	

	if($task == 'change_password'){

		$msg = Doctors::ChangePassword($password_one, $password_two);		

	}
*/


}

?>