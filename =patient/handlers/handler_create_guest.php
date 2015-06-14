<?php
error_reporting(E_ALL);
ini_set('dsiplay_errors','1');
/**
* @project ApPHP Medical Appointment
* @copyright (c) 2012 - 2014 ApPHP
* @author ApPHP <info@apphp.com>
* @license http://www.gnu.org/licenses/
*/
// *** Make sure the file isn't accessed directly

defined('APPHP_EXEC') or die('Restricted Access');
//--------------------------------------------------------------------------
if(!$objLogin->IsLoggedIn() && (ModulesSettings::Get('patients', 'allow_registration') == 'yes')){
error_log("called : hander_create_guest - STep : 1  <br>", 3, "/home1/aimsinfo/public_html/ingagevoice/log/my-errors.log");

	$act 		  = isset($_POST['act']) ? prepare_input($_POST['act']) : '';
	$send_updates = isset($_POST['send_updates']) ? prepare_input($_POST['send_updates']) : '1';
	$first_name   = isset($_POST['first_name']) ? prepare_input($_POST['first_name']) : '';
	$last_name    = isset($_POST['last_name']) ? prepare_input($_POST['last_name']) : '';
	$phone       = isset($_POST['phone']) ? prepare_input($_POST['phone']) : '';
	$email       = isset($_POST['email']) ? prepare_input($_POST['email']) : '';
	$user_name   = isset($_POST['user_name']) ? prepare_input($_POST['user_name']) : '';
	$user_password1 = isset($_POST['password']) ? prepare_input($_POST['password']) : '';
//	$user_password2 = isset($_POST['user_password2']) ? prepare_input($_POST['user_password2']) : '';
	$user_ip     = get_current_ip();			
	$focus_field = '';
//	$reg_confirmation = ModulesSettings::Get('patients', 'reg_confirmation');
//	$image_verification_allow = ModulesSettings::Get('patients', 'image_verification_allow');
//	$admin_alert_new_registration = ModulesSettings::Get('patients', 'admin_alert_new_registration');
	$msg_default = draw_message(_ACCOUNT_CREATE_MSG, false);
	$msg = '';
	$account_created = false;
	if($act == 'create'){
		if($first_name == ''){
			$msg = draw_important_message(_FIRST_NAME_EMPTY_ALERT, false);
			$focus_field = 'first_name';
		}else if($last_name == ''){
			$msg = draw_important_message(_LAST_NAME_EMPTY_ALERT, false);
		}else if($email == ''){
			$msg = draw_important_message(_EMAIL_EMPTY_ALERT, false);
			$focus_field = 'email';
		}else if($email != '' && !check_email_address($email)){
			$msg = draw_important_message(_EMAIL_VALID_ALERT, false);
			$focus_field = 'email';
		}else if($user_name == ''){
			$msg = draw_important_message(_USERNAME_EMPTY_ALERT, false);
			$focus_field = 'frmReg_user_name';
		}else if(($user_name != '') && (strlen($user_name) < 4)){
			$msg = draw_important_message(_USERNAME_LENGTH_ALERT, false);
			$focus_field = 'frmReg_user_name';
		}else if($user_password1 == ''){
			$msg = draw_important_message(_PASSWORD_IS_EMPTY, false);
			$focus_field = 'frmReg_user_password1';
		}else if(($user_password1 != '') && (strlen($user_password1) < 6)){
			$msg = draw_important_message(_PASSWORD_IS_EMPTY, false);
			$user_password1 = $user_password2 = '';
			$focus_field = 'frmReg_user_password1';
		}
		
		// deny all operations in demo version
		if(strtolower(SITE_MODE) == 'demo'){
			error_log("hander_create_guest - STep : 5 Demo <br>", 3, "/home1/aimsinfo/public_html/ingagevoice/log/my-errors.log");
			$msg = draw_important_message(_OPERATION_BLOCKED, false);
		}
		// check if user IP or email don't blocked
		if($msg == ''){
			if($objLogin->IpAddressBlocked($user_ip)) $msg = draw_important_message(_IP_ADDRESS_BLOCKED, false);
			else if($objLogin->EmailBlocked($email)) $msg = draw_important_message(_EMAIL_BLOCKED, false);			
		} /*else {
			 redirect_to(Session::Get('last_visited')) ;
		}*/
		
		// check if user already exists                    
		if($msg == ''){
			$sql = 'SELECT * FROM '.TABLE_PATIENTS.' WHERE user_name = \''.encode_text($user_name).'\'';
			$result = database_query($sql, DATA_AND_ROWS);
			if($result[1] > 0){
				$msg = draw_important_message(_USER_EXISTS_ALERT, false);
			}else{			
				// check if email already exists                    
				$sql = 'SELECT * FROM '.TABLE_PATIENTS.' WHERE email = \''.encode_text($email).'\'';
				$result = database_query($sql, DATA_AND_ROWS);
				if($result[1] > 0){
					$msg = draw_important_message(_USER_EMAIL_EXISTS_ALERT, false);
				}			
			}			
		}
		if($msg == ''){			
		
			$registration_code = strtoupper(get_random_string(19));
			$is_active = 1;
			if(!PASSWORDS_ENCRYPTION){
				$user_password = '\''.encode_text($user_password1).'\'';
			}else{
				if(strtolower(PASSWORDS_ENCRYPTION_TYPE) == 'aes'){					
					$user_password = 'AES_ENCRYPT(\''.encode_text($user_password1).'\', \''.PASSWORDS_ENCRYPT_KEY.'\')';
				}else if(strtolower(PASSWORDS_ENCRYPTION_TYPE) == 'md5'){
					$user_password = 'MD5(\''.encode_text($user_password1).'\')';
				}
			}

			// insert new user
			$sql = 'INSERT INTO '.TABLE_PATIENTS.'(
						first_name,
						last_name,
						phone,
						email,
						user_name,
						user_password,
						preferred_language,
						date_created,
						registered_from_ip,
						email_notifications,
						is_active,
						is_removed,
						comments,
						registration_code)
					VALUES(
						'.(PATIENTS_ENCRYPTION ? 'AES_ENCRYPT(\''.encode_text($first_name).'\', "'.PASSWORDS_ENCRYPT_KEY.'")' : '\''.encode_text($first_name).'\'').',
						'.(PATIENTS_ENCRYPTION ? 'AES_ENCRYPT(\''.encode_text($last_name).'\', "'.PASSWORDS_ENCRYPT_KEY.'")' : '\''.encode_text($last_name).'\'').',
						'.(PATIENTS_ENCRYPTION ? 'AES_ENCRYPT(\''.encode_text($phone).'\', "'.PASSWORDS_ENCRYPT_KEY.'")' : '\''.encode_text($phone).'\'').',
						\''.encode_text($email).'\',
						\''.encode_text($user_name).'\',
						'.$user_password.',
						\''.Application::Get('lang').'\',
						\''.date('Y-m-d H:i:s').'\',
						\''.$user_ip.'\',
						\''.$send_updates.'\',
						'.$is_active.',
						0,
						\'\',
						\''.$registration_code.'\')';
			if(database_void_query($sql) > 0){
		/*		if($reg_confirmation == 'by email'){
					$email_template = 'new_account_created_confirm_by_email';					
				}else if($reg_confirmation == 'by admin'){
					$email_template = 'new_account_created_confirm_by_admin';
				}else{ */
					$email_template = 'new_account_created';
//				}

				send_email(
					$email,
					$objSettings->GetParameter('admin_email'),
					$email_template,
					array(
						'{FIRST NAME}' => $first_name,
						'{LAST NAME}'  => $last_name,
						'{USER NAME}'  => $user_name,
						'{USER PASSWORD}' => $user_password1,
						'{YEAR}' 	   => date('Y'),
						'{ACCOUNT TYPE}' => 'patient'
					)
				);
				////////////////////////////////////////////////////////////
				/*if($reg_confirmation == 'by email'){
					$msg = draw_success_message(_ACCOUNT_CREATED_CONF_BY_EMAIL_MSG, false);
					$msg .= '<br />'.draw_message(str_replace('_ACCOUNT_', 'patient', _ACCOUT_CREATED_CONF_LINK), false);				
				}else if($reg_confirmation == 'by admin'){
					$msg = draw_success_message(_ACCOUNT_CREATED_CONF_BY_ADMIN_MSG, false);
					$msg .= '<br />'.draw_message(str_replace('_ACCOUNT_', 'patient', _ACCOUT_CREATED_CONF_LINK), false);
				}else{
					$msg = draw_success_message(_ACCOUNT_CREATED_NON_CONFIRM_MSG, false);
					$msg .= '<br />'.draw_message(str_replace('_ACCOUNT_', 'patient', _ACCOUNT_CREATED_NON_CONFIRM_LINK), false);
				}*/
				$account_created = true;
				$objLogin    = new Login();
			}else{
				$msg = draw_important_message(_CREATING_ACCOUNT_ERROR, false);
			}                    		
		}		
	} else {
	 error_log(" patient/handler_create_guest - : ready to load create_user.php", 3, "/home1/aimsinfo/public_html/ingagevoice/log/my-errors.log");
	}
}

?>
