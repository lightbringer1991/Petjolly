<?php
/**
* @project ApPHP Medical Appointment
* @copyright (c) 2012 - 2014 ApPHP
* @author ApPHP <info@apphp.com>
* @license http://www.gnu.org/licenses/
*/
// *** Make sure the file isn't accessed 
defined('APPHP_EXEC') or die('Restricted Access');
//--------------------------------------------------------------------------

if(!$objLogin->IsLoggedIn() && (ModulesSettings::Get('doctors', 'allow_registration') == 'yes')){
	include_once('modules/captcha/securimage.php');
	$objImg = new Securimage();
	$act 		  = isset($_POST['act']) ? prepare_input($_POST['act']) : '';
	$send_updates = isset($_POST['send_updates']) ? prepare_input($_POST['send_updates']) : '1';
	$first_name   = isset($_POST['first_name']) ? prepare_input($_POST['first_name']) : '';
	$catg  = isset($_POST['catg']) ? prepare_input($_POST['catg']) : '';
	$last_name    = isset($_POST['last_name']) ? prepare_input($_POST['last_name']) : '';
	$mobile       = isset($_POST['mobile']) ? prepare_input($_POST['mobile']) : '';
	$title        = isset($_POST['title']) ? prepare_input($_POST['title']) : '';
	
	$zip_code =   isset($_POST['zip_code']) ? prepare_input($_POST['zip_code']) : '';
	
	$website = isset($_POST['website']) ? prepare_input($_POST['website']) : '';
	$twitter_username = isset($_POST['twitter_username']) ? prepare_input($_POST['twitter_username']) : '';
	$facebook_url = isset($_POST['facebook_url']) ? prepare_input($_POST['facebook_url']) : '';
	$address   = isset($_POST['address']) ? prepare_input($_POST['address']) : '';
	$google_url      = isset($_POST['google_url']) ? prepare_input($_POST['google_url']) : '';
	$list_desc   = isset($_POST['list_desc']) ? prepare_input($_POST['list_desc']) : '';
	$price   = isset($_POST['price']) ? prepare_input($_POST['price']) : '';
	$b_state     = isset($_POST['b_state']) ? prepare_input($_POST['b_state'], false, 'extra') : '';
	$phone       = isset($_POST['phone_no']) ? prepare_input($_POST['phone_no']) : '';
	
	$fax         = isset($_POST['fax']) ? prepare_input($_POST['fax']) : '';
	$work_phone  = isset($_POST['work_phone']) ? prepare_input($_POST['work_phone']) : '';
	$work_mobile_phone = isset($_POST['work_mobile_phone']) ? prepare_input($_POST['work_mobile_phone']) : '';
	$email       = isset($_POST['email']) ? prepare_input($_POST['email']) : '';
	$user_name   = isset($_POST['user_name']) ? prepare_input($_POST['user_name']) : '';
	$user_password1 = isset($_POST['user_password1']) ? prepare_input($_POST['user_password1']) : '';
	$user_password2 = isset($_POST['user_password2']) ? prepare_input($_POST['user_password2']) : '';
	$business_name = isset($_POST['business_name']) ? prepare_input($_POST['business_name']) : '';
	$agree       = isset($_POST['agree']) ? prepare_input($_POST['agree']) : '';
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
	$user_ip     = get_current_ip();			
	$focus_field = '';
	$reg_confirmation = ModulesSettings::Get('doctors', 'reg_confirmation');
	$image_verification_allow = ModulesSettings::Get('doctors', 'image_verification_allow');
	$admin_alert_new_registration = ModulesSettings::Get('doctors', 'admin_alert_new_registration');
	$arr_titles	= array('Mr.'=>'Mr.', 'Ms.'=>'Ms.', 'Mrs.'=>'Mrs.', 'Miss'=>'Miss');
	$arr_degrees = array('BMBS'=>'BMBS', 'MBBS'=>'MBBS', 'MBChB'=>'MBChB', 'MB BCh'=>'MB BCh', 'BMed'=>'BMed', 'MD'=>'MD', 'MDCM'=>'MDCM', 'Dr.MuD'=>'Dr.MuD', 'Dr.Med'=>'Dr.Med', 'Cand.med'=>'Cand.med', 'Med'=>'Med');					
	$msg_default = draw_message(_ACCOUNT_CREATE_MSG, false);
	$msg = '';
	$account_created = false;

	if($act == 'create'){
		$captcha_code= isset($_POST['captcha_code']) ? prepare_input($_POST['captcha_code']) : '';
		if($first_name == ''){
			$msg = draw_important_message(_FIRST_NAME_EMPTY_ALERT, false);
			$focus_field = 'first_name';
		}else if($last_name == ''){

			$msg = draw_important_message(_LAST_NAME_EMPTY_ALERT, false);

			$focus_field = 'last_name';

		}else if($email == ''){

			$msg = draw_important_message(_EMAIL_EMPTY_ALERT, false);

			$focus_field = 'email';

		}else if($email != '' && !check_email_address($email)){

			$msg = draw_important_message(_EMAIL_VALID_ALERT, false);

			$focus_field = 'email';

		}/*else if($address == ''){

			$msg = draw_important_message(_ADDRESS_EMPTY_ALERT, false);

			$focus_field = 'address';

		}*/else if($user_name == ''){

			$msg = draw_important_message(_USERNAME_EMPTY_ALERT, false);

			$focus_field = 'frmReg_user_name';

		}else if(($user_name != '') && (strlen($user_name) < 4)){

			$msg = draw_important_message(_USERNAME_LENGTH_ALERT, false);

			$focus_field = 'frmReg_user_name';

		}else if($user_password1 == ''){

			$msg = draw_important_message(_PASSWORD_IS_EMPTY, false);

			$user_password1 = $user_password2 = '';

			$focus_field = 'frmReg_user_password1';

		}else if(($user_password1 != '') && (strlen($user_password1) < 6)){

			$msg = draw_important_message(_PASSWORD_IS_EMPTY, false);

			$user_password1 = $user_password2 = '';

			$focus_field = 'frmReg_user_password1';

		}else if(($user_password1 != '') && ($user_password2 == '')){

			$msg = draw_important_message(_CONF_PASSWORD_IS_EMPTY, false);

			$user_password1 = $user_password2 = '';

			$focus_field = 'frmReg_user_password1';

		}else if(($user_password1 != '') && ($user_password2 != '') && ($user_password1 != $user_password2)){

			$msg = draw_important_message(_CONF_PASSWORD_MATCH, false);

			$user_password1 = $user_password2 = '';

			$focus_field = 'frmReg_user_password1';

		}else if($agree == ''){

			$msg = draw_important_message(_CONFIRM_TERMS_CONDITIONS, false);

		}else if($image_verification_allow == 'yes' && !$objImg->check($captcha_code)){

			$msg = draw_important_message(_WRONG_CODE_ALERT, false);	    

			$focus_field = 'frmReg_captcha_code';

		} else if(trim($business_name)  == ''){
					
				$msg = draw_important_message(_BUSINESS_NAME_EMPTY_ALERT, false);	    	
				$focus_field = 'business_name';
		}



		// deny all operations in demo version

		if(strtolower(SITE_MODE) == 'demo'){

			$msg = draw_important_message(_OPERATION_BLOCKED, false);

		}				



		// check if user IP or email don't blocked

		if($msg == ''){

			if($objLogin->IpAddressBlocked($user_ip)) $msg = draw_important_message(_IP_ADDRESS_BLOCKED, false);

			else if($objLogin->EmailBlocked($email)) $msg = draw_important_message(_EMAIL_BLOCKED, false);			

		}



		// check if user already exists                    

		if($msg == ''){

			$sql = 'SELECT * FROM '.TABLE_DOCTORS.' WHERE user_name = \''.encode_text($user_name).'\'';

			$result = database_query($sql, DATA_AND_ROWS);

			if($result[1] > 0){

				$msg = draw_important_message(_USER_EXISTS_ALERT, false);

			}else{			

				// check if email already exists                    

				$sql = 'SELECT * FROM '.TABLE_DOCTORS.' WHERE email = \''.encode_text($email).'\'';

				$result = database_query($sql, DATA_AND_ROWS);

				if($result[1] > 0){

					$msg = draw_important_message(_USER_EMAIL_EXISTS_ALERT, false);

				}			

			}			

		}

		

		if($msg == ''){			

			if($reg_confirmation == 'by email'){

				$registration_code = strtoupper(get_random_string(19));

				$is_active = '0';

			}else if($reg_confirmation == 'by admin'){

				$registration_code = strtoupper(get_random_string(19));

				$is_active = '0';

			}else{

				$registration_code = '';

				$is_active = '1';

			}

			

			if(!PASSWORDS_ENCRYPTION){

				$user_password = '\''.encode_text($user_password1).'\'';

			}else{

				if(strtolower(PASSWORDS_ENCRYPTION_TYPE) == 'aes'){					

					$user_password = 'AES_ENCRYPT(\''.encode_text($user_password1).'\', \''.PASSWORDS_ENCRYPT_KEY.'\')';

				}else if(strtolower(PASSWORDS_ENCRYPTION_TYPE) == 'md5'){

					$user_password = 'MD5(\''.encode_text($user_password1).'\')';

				}

			}

			

			$default_plan_info = MembershipPlans::GetDefaultPlanInfo();

			$default_plan_id = isset($default_plan_info['id']) ? (int)$default_plan_info['id'] : 0;

            $default_plan_images_count = isset($default_plan_info['images_count']) ? (int)$default_plan_info['images_count'] : 0;

            $default_plan_addresses_count = isset($default_plan_info['addresses_count']) ? (int)$default_plan_info['addresses_count'] : 0;

			$default_plan_duration = isset($default_plan_info['duration']) ? (int)$default_plan_info['duration'] : 0;

            $default_plan_show_in_search = isset($default_plan_info['show_in_search']) ? (int)$default_plan_info['show_in_search'] : 0;

            if($default_plan_duration > -1){

                $default_plan_expired = date('Y-m-d', mktime(0, 0, 0, date('m'), date('d') + $default_plan_duration, date('Y')));                    

            }else{

                $default_plan_expired = '0000-00-00';

            }

            

			// insert new user

			$sql = 'INSERT INTO '.TABLE_DOCTORS.'(
						first_name,
						middle_name,
						last_name,
						birth_date,
						gender,
						title,
						b_address,
						b_address_2,
						b_city,
						b_zipcode,
						b_country,
						b_state,
						phone,
						fax,
						work_phone,
						work_mobile_phone,
						email,
						user_name,
						user_password,
						business_name,
						preferred_language,
						date_created,
						registered_from_ip,
						last_logged_ip,
                        email_notifications,
                        membership_plan_id,
                        membership_images_count,
                        membership_addresses_count,
                        membership_show_in_search,
                        membership_expires,
						is_active,
						is_removed,
						comments,
						registration_code,
						list_title,
						list_address,
						list_category,
						list_mobile,
						list_website,
						list_twitter,
						list_facebook,
						list_google,
						list_desc,
						list_price,
						list_mon_open,
						list_mon_close,
						list_tue_open,
						list_tue_close,
						list_wed_open,
						list_wed_close,
						list_thur_open,
						list_thur_close,
						list_fri_open,
						list_fri_close,
						list_sat_open,
						list_sat_close,
						list_sun_open,
						list_sun_close			
						)
					VALUES(
						\''.encode_text($first_name).'\',
						\'\',
						\''.encode_text($last_name).'\',
						\'\',
						\'\',
						\'\',						
						\'\',
						\'\',
						\'\',
						\'\',
						\'\',
						\'\',
						\''.encode_text($phone).'\',
						\''.encode_text($fax).'\',
						\'\',
						\'\',						
						\''.encode_text($email).'\',
						\''.encode_text($user_name).'\',
						'.$user_password.',						
						\''.encode_text($business_name).'\',
						\''.Application::Get('lang').'\',

						\''.date('Y-m-d H:i:s').'\',

						\''.$user_ip.'\',

						\'\',

                        \''.$send_updates.'\',

                        \''.$default_plan_id.'\',

                        \''.$default_plan_images_count.'\',

                        \''.$default_plan_addresses_count.'\',

                        \''.$default_plan_show_in_search.'\',

                        \''.$default_plan_expired.'\',

						'.$is_active.',

						0,

						\'\',

						\''.$registration_code.'\',
						
						\''.encode_text($title).'\',
						
						\''.encode_text($address).'\',
						
						\''.encode_text($catg).'\',
						
						\''.encode_text($mobile).'\',
						
						\''.encode_text($website).'\',
						
						\''.encode_text($twitter_username).'\',
						
						\''.encode_text($facebook_url).'\',
						
						\''.encode_text($google_url).'\',
						
						\''.encode_text($list_desc).'\',
						
						\''.encode_text($price).'\',
						
						\''.encode_text($monOp).'\',
						
						\''.encode_text($monCl).'\',
						
						\''.encode_text($tueOp).'\',
						
						\''.encode_text($tueCl).'\',
						
						\''.encode_text($wedOp).'\',
						
						\''.encode_text($wedCl).'\',
						
						\''.encode_text($thurOp).'\',
						
						\''.encode_text($thurCl).'\',
						
						\''.encode_text($friOp).'\',
						
						\''.encode_text($friCl).'\',
						
						\''.encode_text($satOp).'\',
						
						\''.encode_text($satCl).'\',
						
						\''.encode_text($sunOp).'\',
						
						\''.encode_text($sunCl).'\'
						)';

				$response=database_void_query1($sql);	

			if( $response != 0){
			
					mysql_query("insert into meda_doctor_specialities values('','$response','$catg','0.00','1','1')");


					mysql_query("insert into meda_doctor_addresses values('','$response','$address','".$_POST['lat']."','".$_POST['long']."','public','1','1','1')");
					
					foreach($_POST['ammenties'] as $amm){
						mysql_query("insert into list_ammenties values('','$response','$amm')");
					}
					
					$num_files = count($_FILES['photos']['tmp_name']);
					for($x =0; $x< $num_files;$x++){
						$image = $_FILES['photos']['name'][$x];
						
					   move_uploaded_file($_FILES["photos"]["tmp_name"][$x],"/home3/srinione/public_html/sun/images/doctors/". $image);
					   
					   mysql_query("insert into meda_doctor_images values('','$response','$image','$image','',0,1)");
				 }
       
    		

		

				////////////////////////////////////////////////////////////

				if($reg_confirmation == 'by email'){

					$email_template = 'new_account_created_confirm_by_email';					

				}else if($reg_confirmation == 'by admin'){

					$email_template = 'new_account_created_confirm_by_admin';

				}else{

					$email_template = 'new_account_created';

				}

				send_email(

					$email,

					$objSettings->GetParameter('admin_email'),

					$email_template,

					array(

						'{FIRST NAME}'   => $first_name,

						'{LAST NAME}'    => $last_name,

						'{USER NAME}'    => $user_name,

						'{USER PASSWORD}' => $user_password1,

						'{WEB SITE}'     => $_SERVER['SERVER_NAME'],

						'{REGISTRATION CODE}' => $registration_code,

						'{BASE URL}'     => APPHP_BASE,

						'{YEAR}' 	     => date('Y'),

						'{ACCOUNT TYPE}' => 'doctor'

					)

				);



				if($admin_alert_new_registration == 'yes'){

					send_email(

						$objSettings->GetParameter('admin_email'),

						$objSettings->GetParameter('admin_email'),

						'new_account_created_notify_admin',

						array(

							'{ACCOUNT TYPE}' => _DOCTOR,

							'{FIRST NAME}' => $first_name,

							'{LAST NAME}'  => $last_name,

							'{USER NAME}'  => $user_name,

							'{USER EMAIL}' => $email,

							'{WEB SITE}'   => $_SERVER['SERVER_NAME'],

							'{BASE URL}'   => APPHP_BASE,

							'{YEAR}' 	   => date('Y'),

							'{ACCOUNT TYPE}' => 'doctor'

						)

					);

				}

				////////////////////////////////////////////////////////////

				

				if($reg_confirmation == 'by email'){

					$msg = draw_success_message(_ACCOUNT_CREATED_CONF_BY_EMAIL_MSG, false);

					$msg .= '<br />'.draw_message(str_replace('_ACCOUNT_', 'doctor', _ACCOUT_CREATED_CONF_LINK), false);				

				}else if($reg_confirmation == 'by admin'){

					$msg = draw_success_message(_ACCOUNT_CREATED_CONF_BY_ADMIN_MSG, false);

					$msg .= '<br />'.draw_message(str_replace('_ACCOUNT_', 'doctor', _ACCOUT_CREATED_CONF_LINK), false);

				}else{

					$msg = draw_success_message(_ACCOUNT_CREATED_NON_CONFIRM_MSG, false);

					$msg .= '<br />'.draw_message(str_replace('_ACCOUNT_', 'doctor', _ACCOUNT_CREATED_NON_CONFIRM_LINK), false);

				}

				

				$account_created = true;

			

			}else{

				///echo database_error();

				$msg = draw_important_message(_CREATING_ACCOUNT_ERROR, false);

			}                    		

		}		

	}

}



?>