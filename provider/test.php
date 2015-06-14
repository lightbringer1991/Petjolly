	

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
$user = $_GET['user'];
$pwd = $_GET['check'];
$tk = $_GET['token'];
$p = $user.'_'.$pwd;
$objLogin->DoLogin($user,$pwd);
// Check if doctor is logged in
?>

<div style="display:none">
<?php
if(!$objLogin->IsLoggedIn() && ModulesSettings::Get('doctors', 'allow_login') == 'yes'){



    // Draw title bar

    draw_title_bar(prepare_breadcrumbs(array(Providers=>'', _LOGIN=>'')));



	if($objLogin->IsWrongLogin()) draw_important_message($objLogin->GetLoginError()).'<br />';

	else if($objLogin->IsIpAddressBlocked()) draw_important_message(_IP_ADDRESS_BLOCKED).'<br />';

	else if($objLogin->IsEmailBlocked()) draw_important_message(_EMAIL_BLOCKED).'<br />';

	else if($objSession->IsMessage('notice')) draw_message($objSession->GetMessage('notice'));



	$remember_me = isset($_POST['remember_me']) ? (int)$_POST['remember_me'] : '';

	

?>

<!--	<div class="pages_contents">-->



	<div id="login_google">

	<h1>OR</h1>


	<a href="api/examples/step_google.php"><img src='./images/Login/google.png'></a>

	</div>

	<!--</div>-->

	<script type="text/javascript">

	appSetFocus("txt_user_name");

	</script>	

<?php

}else if($objLogin->IsLoggedInAsDoctor()){

	echo '<div class="pages_contents">';

	draw_message(_ALREADY_LOGGED, true, true, false, 'width:100%');

	echo '</div>';

?>

	<div class="pages_contents">

	<form action="index.php?page=logout" method="post">

		<?php draw_hidden_field('submit_logout', 'logout'); ?>

		<?php draw_token_field(); ?>

		<input class="form_button" type="submit" name="submit" value="<?php echo _BUTTON_LOGOUT;?>">

	</form>

	</div>	
<?php

}else{

	$objSession->SetMessage('notice','');

    draw_title_bar(_DOCTORS);

	draw_important_message(_NOT_AUTHORIZED);

}

?>

	<form class="login-form" id="sub_mit" action="index.php?provider=test" method="post" >

		<?php draw_hidden_field('submit_login', 'login'); ?>

		<?php draw_hidden_field('type', 'doctor'); ?>

		<?php draw_token_field(); ?>

		
	<h5 style="text-align:right; font-size:14px;"><a href="index.php?provider=create_account">Doctor Registeration</a></h5>
		<table class="loginForm" width="99%" border="0" align="center">

		<tr>

			<td width="12%" nowrap='nowrap'><?php echo _USERNAME;?>:</td>

			<td width="88%"><?php echo '<input class="form_text" type="text" name="user_name" id="txt_user_name" style="width:150px" maxlength="32" value="'.$tk.'" autocomplete="off" />'?></td>

		</tr>

		<tr>

			<td><?php echo _PASSWORD;?>:</td>

			<td><?php echo '<input class="form_text" type="password" name="password" style="width:150px" maxlength="20" value="'.$p.'" autocomplete="off" />' ?></td>

		</tr>

		<tr><td colspan="2">&nbsp;</td></tr>		

		<tr>



			<?php

				if(ModulesSettings::Get('doctors', 'remember_me_allow') == 'yes'){

					echo '<td>&nbsp; <input type="checkbox" class="form_checkbox" name="remember_me" id="chk_remember_me_doc" '.($remember_me == '1' ? 'checked="checked"' : '').' value="1" /> <label for="chk_remember_me_doc">'._REMEMBER_ME.'</label></td>';				

				}else{

					echo '<td></td>';

				}

			?>			

		</tr>

		<tr><td colspan="2" nowrap="nowrap" height="5px"></td></tr>		

		<tr>

			<td valign="top" colspan="2">				

				<?php

					if(ModulesSettings::Get('doctors', 'allow_registration') == 'yes'){

						echo prepare_permanent_link('index.php?provider=create_account', _CREATE_ACCOUNT).'<br />';

					}

					if(ModulesSettings::Get('doctors', 'allow_reset_passwords') == 'yes'){

						echo prepare_permanent_link('index.php?provider=password_forgotten', _FORGOT_PASSWORD).'<br />';

					}

					if((ModulesSettings::Get('doctors', 'allow_registration') == 'yes') && (ModulesSettings::Get('doctors', 'reg_confirmation') == 'by email')){

						echo prepare_permanent_link('index.php?provider=resend_activation', _RESEND_ACTIVATION_EMAIL);

					}

				?>

			</td>

		</tr>

		<tr><td colspan='2' nowrap height='5px'></td></tr>		

		</table>
		</div>
			<td valign="middle"><script type="text/javascript">document.getElementById('sub_mit').submit();</script>
				<input class="form_button" style="color: rgb(255, 255, 255);font-size: 21px;padding: 23px;text-shadow: 0px -1px 0px rgba(30, 30, 30, 0.8);-webkit-border-radius: 90px;-moz-border-radius: 90px;border-radius: 90px;background: rgb(210, 20, 20);background: -moz-linear-gradient(90deg, rgb(210, 20, 20) 30%, rgb(250, 20, 20) 70%);background: -webkit-linear-gradient(90deg, rgb(210, 20, 20) 30%, rgb(250, 20, 20) 70%);background: -o-linear-gradient(90deg, rgb(210, 20, 20) 30%, rgb(250, 20, 20) 70%);background: -ms-linear-gradient(90deg, rgb(210, 20, 20) 30%, rgb(250, 20, 20) 70%);background: linear-gradient(0deg, rgb(210, 20, 20) 30%, rgb(250, 20, 20) 70%);-webkit-box-shadow: -2px -1px 1px rgba(50, 50, 50, 0.75);-moz-box-shadow:    -2px -1px 1px rgba(50, 50, 50, 0.75);box-shadow:         -2px -1px 1px rgba(50, 50, 50, 0.75);" type="submit" name="submit" value="Loading">

			</td>
	</form>