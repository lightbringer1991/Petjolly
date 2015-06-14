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



// Check if doctor is logged in

if(!$objLogin->IsLoggedIn() && ModulesSettings::Get('doctors', 'allow_login') == 'yes'){



    // Draw title bar

    draw_title_bar(prepare_breadcrumbs(array(_DOCTORS=>'', _LOGIN=>'')));



	if($objLogin->IsWrongLogin()) draw_important_message($objLogin->GetLoginError()).'<br />';

	else if($objLogin->IsIpAddressBlocked()) draw_important_message(_IP_ADDRESS_BLOCKED).'<br />';

	else if($objLogin->IsEmailBlocked()) draw_important_message(_EMAIL_BLOCKED).'<br />';

	else if($objSession->IsMessage('notice')) draw_message($objSession->GetMessage('notice'));



	$remember_me = isset($_POST['remember_me']) ? (int)$_POST['remember_me'] : '';

	

?>

<!--	<div class="pages_contents">-->

	<form class="login-form" action="index.php?doctor=login" method="post">
    <?php draw_hidden_field('submit_login', 'login'); ?>

		<?php draw_hidden_field('type', 'doctor'); ?>

		<?php draw_token_field(); ?>
		<h3 class="form-title">Sign In</h3>
		<div class="alert alert-danger display-hide">
			<button class="close" data-close="alert"></button>
			<span>
			Enter any username and password. </span>
		</div>
		<div class="form-group">
			<!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
			<label class="control-label visible-ie8 visible-ie9"><?php echo _USERNAME;?>:</label>
			<input class="form-control form-control-solid placeholder-no-fix" type="text" autocomplete="off" placeholder="<?php echo _USERNAME;?>:" name="user_name" id="txt_user_name"/>
		</div>
		<div class="form-group">
			<label class="control-label visible-ie8 visible-ie9"><?php echo _PASSWORD;?>:</label>
			<input class="form-control form-control-solid placeholder-no-fix" type="password" autocomplete="off" placeholder="Password" name="password"/>
		</div>
		<div class="form-actions">
			<button type="submit" name="submit" class="btn btn-success uppercase">Login</button>
			<label class="rememberme check">
            <?php
					echo '<input type="checkbox" name="remember_me" id="chk_remember_me_doc" '.($remember_me == '1' ? 'checked="checked"' : '').' value="1" /> Remember</label>';				

			?>
            <?php
			if(ModulesSettings::Get('doctors', 'allow_reset_passwords') == 'yes'){

						echo '<a href="index.php?doctor=password_forgotten" id="forget-password" class="forget-password">Forgot Password?</a>';

					}
			?>		
			
		</div>
		<div class="login-options">
			<h4>Or login with</h4>
			<ul class="social-icons">
				<li>
					<a class="social-icon-color facebook" data-original-title="facebook" href="#"></a>
				</li>
				<li>
					<a class="social-icon-color twitter" data-original-title="Twitter" href="#"></a>
				</li>
				<li>
					<a class="social-icon-color googleplus" data-original-title="Goole Plus" href="#"></a>
				</li>
				<li>
					<a class="social-icon-color linkedin" data-original-title="Linkedin" href="#"></a>
				</li>
			</ul>
		</div>
		<div class="create-account">
			<p>
				<a href="index.php?doctor=create_account" id="register-btn" class="uppercase">Create an account</a>
			</p>
		</div>
	</form>

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
