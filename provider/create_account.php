<script>
$(document).ready(function(){
   $('input#first_name').keypress(function(){
        $('.form_error').hide();
    });
	$('input#last_name').keypress(function(){
        $('.form_error1').hide();
    });
	$('input#business_name').keypress(function(){
        $('.form_error2').hide();
    });
	$('input#phone').keypress(function(){
        $('.form_error3').hide();
    });
	$('input#email').keypress(function(){
        $('.form_error4').hide();
    });
	$('input#frmReg_user_name').keypress(function(){
        $('.form_error5').hide();
    });
	$('input#frmReg_user_password1').keypress(function(){
        $('.form_error6').hide();
    });
	$('input#frmReg_user_password2').keypress(function(){
        $('.form_error7').hide();
    });
}); 
</script>
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

if(!$objLogin->IsLoggedIn() && (ModulesSettings::Get('doctors', 'allow_registration') == 'yes')){

	//draw_title_bar(prepare_breadcrumbs(array(Providers=>'', _CREATING_NEW_ACCOUNT=>'')));
?>

<?php if($account_created){ ?>

	<div class='pages_contents'>
		<?php echo (($msg == '') ? $msg_default : $msg); ?>
	</div>

<?php }else{ ?>

	<script type="text/javascript">
	function btnSubmitPD_OnClick(){
		var flag="true";
		frmReg = document.getElementById("frmRegistration");
		
		if(frmReg.first_name.value == "")          { $('.form_error').html('<p><?php echo _FIRST_NAME_EMPTY_ALERT; ?></p>'); flag="false";   
		}if(frmReg.last_name.value == "")     {$('.form_error1').html('<p><?php echo _LAST_NAME_EMPTY_ALERT; ?></p>');flag="false"; 
		
		}if(frmReg.business_name.value == "")     { $('.form_error2').html('<p>Business Name cannot be empty</p>'); flag="false";
		        
		}
		if(frmReg.phone.value == "")     { $('.form_error3').html('<p>Please enter phone no.</p>'); flag="false";        
		}
		if(frmReg.email.value == "")         {$('.form_error4').html('<p><?php echo _EMAIL_EMPTY_ALERT; ?></p>');  flag="false";      
		}
		
		else if(!appIsEmail(frmReg.email.value))  { $('.form_error8').html('<p><?php echo _EMAIL_VALID_ALERT; ?></p>'); flag="false";         
		}if(frmReg.user_name.value == "")     { $('.form_error5').html('<p><?php echo _USERNAME_EMPTY_ALERT; ?></p>'); flag="false";        
		}if(frmReg.user_password1.value == ""){ $('.form_error6').html('<p><?php echo _PASSWORD_IS_EMPTY; ?></p>'); flag="false";
		}if(frmReg.user_password2.value == ""){ $('.form_error7').html('<p><?php echo _CONF_PASSWORD_IS_EMPTY; ?></p>');  flag="false";
		}else if(frmReg.user_password1.value != frmReg.user_password2.value){ $('.form_error9').html('<p>"<?php echo _CONF_PASSWORD_MATCH; ?></p>'); flag="false";
		}if(!frmReg.agree.checked)            { $('.form_error10').html('<p><?php echo _CONFIRM_TERMS_CONDITIONS; ?></p>');  flag="false";}

		if(flag=="false") {
		return false;
		}
		else {
		return true;
		}
		
	}
	</script>


	<?php echo $msg; ?>        
	<div class='pages_contents'>
		
		<?php /*?><p style='padding-left:3px; text-align:center'>
			<?php echo _ALERT_REQUIRED_FILEDS; ?>
		</p><?php */?>		
				
	<div class="top_text"><h1>Sign up for a free account</h1> <br>
                          <p>Get listed and join thousands of businesses already on PetJolly</p>
    </div>
            
            
            
			<div class="reg_form_main">
		
					<article id="article" class="reg_form">
                    <div class="left_form">
	
				<form action="index.php?provider=create_account" method="post" name="frmRegistration" class="form" id="frmRegistration">
			<?php draw_hidden_field("act", "create"); ?>
			<?php draw_token_field(); ?>
						<fieldset>
							<!--<h4>Personal Details</h4>-->
							
							<!-- Labels are dafault placed on to, to place its inline, you must add the class "inner_labels" to the div class="row". Instead of main label you can use span class="label" -->
							<!-- example: 
								<div class="row inner_labels"> 
									<span class="label">New label:</span>
									..
							-->
							
							
							<div class="row collapseItem">
								<div class="item">
									<label for="FirstName">First name:<em>*</em></label>
									<input type="text" id="first_name" name="first_name" size="32" maxlength="32" value="<?php echo decode_text($first_name);?>" autocomplete="off" />            <div class="form_error"></div>
									<!-- To mark the incorrectly filled input, you must add the class "error" to the input -->
									<!-- example: <input type="text" id="FirstName" class="error" value="" /> -->
								</div>
								<div class="item last">
									<label for="LastName">Last name:<em>*</em></label>
									<input type="text" id="last_name" name="last_name" size="32" maxlength="32" value="<?php echo decode_text($last_name);?>" autocomplete="off"  /> <div class="form_error1"></div>
								</div>
							</div>
							
                            
                            <div class="row">
								<div class="item">
									<label for="FirstName">Business Name<em>*</em></label>
									<input type="text" id="business_name" name="business_name" size="32" maxlength="32" value="<?php echo decode_text($business_name);?>" autocomplete="off"  /><div class="form_error2"></div>
									<!-- To mark the incorrectly filled input, you must add the class "error" to the input -->
									<!-- example: <input type="text" id="FirstName" class="error" value="" /> -->
								</div>
								<div class="item last">
									<label for="LastName">Phone:<em>*</em></label>
									<input type="text" id="phone" name="phone" size="32" maxlength="32" value="<?php echo decode_text($phone);?>" autocomplete="off" /><div class="form_error3"></div>
								</div>
							</div>
                            
                            <div class="row">
								<div class="item">
									<label for="FirstName">E-mail address<em>*</em></label>
									<input type="text" id="email" name="email" size="32" maxlength="70" value="<?php echo decode_text($email);?>" autocomplete="off" /><div class="form_error4"></div><div class="form_error8"></div>
									<!-- To mark the incorrectly filled input, you must add the class "error" to the input -->
									<!-- example: <input type="text" id="FirstName" class="error" value="" /> -->
								</div>
								<div class="item last">
									<label for="LastName">Username:<em>*</em></label>
									<input type="text" id="frmReg_user_name" name="user_name" size="32" maxlength="32" value="<?php echo decode_text($user_name);?>" autocomplete="off" /><div class="form_error5"></div>
								</div>
							</div>
                            
                            <div class="row collapseItem">
								<div class="item">
									<label for="FirstName">Password<em>*</em></label>
									<input type="password" id="frmReg_user_password1" name="user_password1" size="32" maxlength="20" value="<?php echo decode_text($user_password1);?>" autocomplete="off" /><div class="form_error6"></div>
									<!-- To mark the incorrectly filled input, you must add the class "error" to the input -->
									<!-- example: <input type="text" id="FirstName" class="error" value="" /> -->
								</div>
								<div class="item last">
									<label for="LastName">Confirm Password<em>*</em></label>
									<input type="password" id="frmReg_user_password2" name="user_password2" size="32" maxlength="20" value="<?php echo decode_text($user_password2);?>" autocomplete="off" /><div class="form_error7"></div><div class="form_error9"></div>
								</div>
							</div>
                            
                            
<?php /*?>                            <div class="row inner_labels">
								<input type="checkbox" name="send_updates" id="send_updates" <?php echo (($send_updates == '1') ? 'checked="checked"' : '');?> value="1">
								<label class="term" for="Terms" style="font-size:14px">Please send me information related to my health care, health insurance or site updates!</label>
							</div><?php */?>
                            <div class="row inner_labels term_text">
								
								<input type="checkbox" name="agree" id="agree" value="1" <?php echo ($agree == '1') ? 'checked="checked"' : ''; ?>></label>
                                <?php							
							$temp_page = new Pages('terms_and_conditions', true);
                            $page_text = $temp_page->DrawText(false);
                            if(!empty($page_text)){
                                echo '<a href="javascript:appPopupWindow(\'terms_and_conditions.html\',\'div_terms_and_conditions\')">'._AGREE_CONF_TEXT.'</a>';
                                echo '<div id="div_terms_and_conditions" style="display:none;">';
                                echo  $page_text;
                                echo '</div>';								
                            }else{
                                echo _AGREE_CONF_TEXT;
                            }
                        ?>
                        <div class="form_error10"></div>
							</div>
                            <div class="submit">
								<input type="submit" class="form_button" name="btnSubmitPD" id="btnSubmitPD" value="<?php echo _SUBMIT; ?>" onclick="return btnSubmitPD_OnClick()">
							</div>
                            </fieldset>
                            </form>
                            </div>
                            
                  
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            </article>
				 <div class="marketing-copy">
      <!--   <span class="info-banner">Important</span>  -->                 
<h1>A bit about us</h1>


<ol>
<li>We're the world's fastest growing online PetGrooming marketplace
</li>
<li>Getting listed improves your web presence, making your business easier to find
</li>
<li>Our free online booking system makes managing your business simple and gives you the option to sell through PetJolly.com
</li>
<!--<li>Pay just 20% plus  VAT commission on sales we send you and receive payment within 15 days
</li>-->
<li>Any data you share with us belongs to you and we promise to keep it secure</li></ol>
                        </div>         
	
    
    </div>
	</div>	





	<script type="text/javascript">
		appSetFocus('<?php echo $focus_field; ?>');
        appChangeCountry(jQuery("#b_country").val(),'b_state','<?php echo decode_text($b_state);?>','<?php echo Application::Get('token');?>');        
	</script>	
<?php
	}	
}else{
	draw_title_bar(_DOCTORS);
	draw_important_message(_NOT_AUTHORIZED);
}
?>