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

// check if doctor is logged in
if(!$objLogin->IsLoggedIn() && (ModulesSettings::Get('doctors', 'allow_reset_passwords') == 'yes')){	

	$act 		    = isset($_POST['act']) ? prepare_input($_POST['act']) : '';
	$email 			= isset($_POST['email']) ? prepare_input($_POST['email']) : '';
	$msg 			= '';
	
	if($act == 'send'){
		if(!check_email_address($email)){
			$msg = draw_important_message(_EMAIL_IS_WRONG, false);					
		}else{
			if(!(bool)Session::Get('password_sent')){
				if(Doctors::SendPassword($email)){
					$msg = draw_success_message(_PASSWORD_SUCCESSFULLY_SENT, false);
					Session::Set('password_sent', true);
				}else{
					$msg = draw_important_message(Doctors::GetStaticError(), false);					
				}
			}else{
				$msg = draw_message(_PASSWORD_ALREADY_SENT, false);
			}
		}
	}	
	
	// draw title bar
	//draw_title_bar(prepare_breadcrumbs(array(_DOCTORS=>'',_PASSWORD_FORGOTTEN=>'')));

	echo $msg;
?>
<div class="main" id="login_main" style="margin-top:90px;">

            
		

		<div class="box">
        <h2>Forgot Password</h2>  
        <?php echo '<h3>'._PASSWORD_RECOVERY_MSG.'</h3>'; ?>
	<form class="form" action="index.php?provider=password_forgotten" method="post">
		<?php draw_hidden_field('act', 'send'); ?>
		<?php draw_hidden_field('type', 'doctor'); ?>
		<?php draw_token_field(); ?>
		
		
			
		
        <fieldset>
					<div class="row">
                    <input class="login" type="text" name="email" id="forgotten_email" size="20" maxlength="70" autocomplete="off" placeholder="Enter Email Address" style="margin-top:12px;"/>
                    </div>
                    <div class="row">
                    <input class="form_button" type="submit" name="btnSend" value="<?php echo _SEND;?>">
                    </div>
                   
                    </fieldset>
			
			<?php /*?>	<?php
					if(ModulesSettings::Get('doctors', 'allow_login') == 'yes'){
						echo prepare_permanent_link('index.php?provider=login', _DOCTOR_LOGIN);	
					}
				?><?php */?>
		
	</form>
    </div>
    </div>
	<script type="text/javascript">
		appSetFocus("forgotten_email");
	</script>	
<?php
}else{
	draw_title_bar(_DOCTORS);
    draw_important_message(_NOT_AUTHORIZED);
}

?>