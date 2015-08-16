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

 //   draw_title_bar(prepare_breadcrumbs(array(Providers=>'', _LOGIN=>'')));



	if($objLogin->IsWrongLogin()) draw_important_message($objLogin->GetLoginError()).'<br />';

	else if($objLogin->IsIpAddressBlocked()) draw_important_message(_IP_ADDRESS_BLOCKED).'<br />';

	else if($objLogin->IsEmailBlocked()) draw_important_message(_EMAIL_BLOCKED).'<br />';

	else if($objSession->IsMessage('notice')) draw_message($objSession->GetMessage('notice'));



	$remember_me = isset($_POST['remember_me']) ? (int)$_POST['remember_me'] : '';

	

?>


<!--	<div class="pages_contents">-->
	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<div class="main" id="login_main">
		<div class="box">
			<h2>Login to petjolly</h2>            
			<h3>Please enter your name and password to log in.</h3>
			<form class="form" action="index.php?provider=login" method="post" autocomplete="off">
            <?php draw_hidden_field('submit_login', 'login'); ?>

		<?php draw_hidden_field('type', 'doctor'); ?>

		<?php draw_token_field(); ?>
        <!--	<h5 style="text-align:right; font-size:14px;"> <a href="index.php?provider=create_account">Doctor Registeration</a> </h5> -->
        
				<fieldset>
					<div class="row">
		<input type="text" class="login" name="user_name" placeholder="Username" id="txt_user_name" maxlength="32" value="" autocomplete="off" />
						<!-- To mark the incorrectly filled input, you must add the class "error" to the input -->
						<!-- example: <input type="text" class="login error" name="login" value="Username" /> -->
					</div>
					<div class="row">
						<input type="password" class="password" name="password" placeholder="Password" maxlength="20" value="" autocomplete="off" />
                        <?php
						if(ModulesSettings::Get('doctors', 'allow_reset_passwords') == 'yes'){

						echo prepare_permanent_link('index.php?provider=password_forgotten', 'I forgot my password');

					}
					?>
					</div>	
					<div class="row">
               <?php

				if(ModulesSettings::Get('doctors', 'remember_me_allow') == 'yes'){

					echo '<input type="checkbox" class="remember" name="remember_me" id="chk_remember_me_doc" '.($remember_me == '1' ? 'checked="checked"' : '').' value="1" /> <label for="chk_remember_me_doc" style="width:279px;">Keep me signed in</label>';				

				}else{

					echo '<td></td>';

				}

			?>		
						
						<input type="submit" value="Sign in" />
					</div>
				</fieldset>
			</form>		
		</div>
        
     
	<div id="login_google">
        
 <div class="separator-bar"></div>
<h2 class="separator-text">or</h2>
<div class="separator-bar"></div>

<a href="#"><div class="facebook_btn"><img src="images/fb.png"> <span>Facbook Connect</span> </div></a>
<a href="api/examples/step_google.php"><div class="google_btn"><img src="images/google_plus.png"><span>Google Connect</span> </div></a>

<div class="login_bottom_text">Not a member yet ? <a href="index.php?provider=create_account">Register Now</a> - its quick and easy!</div>
       
	</div>
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