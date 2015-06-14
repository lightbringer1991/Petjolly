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
if(!$objLogin->IsLoggedIn() && ModulesSettings::Get('patients', 'allow_login') == 'yes'){
?>
      <?php   
      $appointment_details = array();   
             $task = isset($_POST['task']) ? prepare_input($_POST['task']) : '';

    $params = array();
    $params['docid']       = isset($_POST['docid']) ? (int)$_POST['docid'] : '';
    $params['schid']        = isset($_POST['schid']) ? (int)$_POST['schid'] : '';
    $params['daddid']        = isset($_POST['daddid']) ? (int)$_POST['daddid'] : '';
    $params['date']        = isset($_POST['date']) ? prepare_input($_POST['date']) : '';
    $params['start_time']  = isset($_POST['start_time']) ? prepare_input($_POST['start_time']) : '';
    $params['duration']    = isset($_POST['duration']) ? (int)$_POST['duration'] : '';
    $params['dspecid']     = isset($_POST['dspecid']) ? (int)$_POST['dspecid'] : '';
    $params['insid']       = isset($_POST['insid']) ? (int)$_POST['insid'] : '';
    $params['vrid']        = isset($_POST['vrid']) ? (int)$_POST['vrid'] : '';
    $params['for_whom']    = isset($_POST['for_whom']) ? prepare_input($_POST['for_whom']) : '';
    $params['first_visit'] = isset($_POST['first_visit']) ? prepare_input($_POST['first_visit']) : '';
    $params['patient_id']  = isset($_POST['patient_id']) ? prepare_input($_POST['patient_id']) : '';

    $appointment_details = &$_SESSION[INSTALLATION_KEY.'appointment_details'];
    if(empty($task)){
        if(!empty($appointment_details)){
            $task                    = 'verify_appointment';
            $params['docid']       = isset($appointment_details['docid']) ? (int)$appointment_details['docid'] : '';
            $params['schid']        = isset($appointment_details['schid']) ? (int)$appointment_details['schid'] : '';
            $params['daddid']        = isset($appointment_details['daddid']) ? (int)$appointment_details['daddid'] : '';
            $params['date']        = isset($appointment_details['date']) ? prepare_input($appointment_details['date']) : '';
            $params['start_time']  = isset($appointment_details['start_time']) ? prepare_input($appointment_details['start_time']) : '';
            $params['duration']    = isset($appointment_details['duration']) ? (int)$appointment_details['duration'] : '';
            $params['dspecid']     = isset($appointment_details['dspecid']) ? (int)$appointment_details['dspecid'] : '';
            $params['insid']       = isset($appointment_details['insid']) ? (int)$appointment_details['insid'] : '';
            $params['for_whom']    = isset($appointment_details['for_whom']) ? prepare_input($appointment_details['for_whom']) : '';
            $params['first_visit'] = isset($appointment_details['first_visit']) ? prepare_input($appointment_details['first_visit']) : '';
            $params['patient_id']  = isset($appointment_details['patient_id']) ? prepare_input($appointment_details['patient_id']) : '';
        }else{
            if($objLogin->IsLoggedInAsPatient()){
                redirect_to('index.php?member=home');
            }            
        }
    }
    
   
    
            draw_title_bar(_VERIFY_APPOINTMENT);
            draw_appointment_bar(3);  
            echo (($msg == '') ? $msg_default : $msg);
            //draw_message(_APPOINTMENT_GUEST_REGISTRATION_ALERT);
            Appointments::DrawVerifyAppointment($params);
            
    ?>
	<script type="text/javascript"> 
	function btnSubmitPD_OnClick(){
		frmEdit = document.getElementById("frmEditAccount");
		
		if(frmEdit.first_name.value == ""){ alert("<?php echo _FIRST_NAME_EMPTY_ALERT; ?>"); frmEdit.first_name.focus(); return false; }
		else if(frmEdit.last_name.value == ""){ alert("<?php echo _LAST_NAME_EMPTY_ALERT; ?>"); frmEdit.last_name.focus(); return false; }
		else if(frmEdit.email.value == ""){ alert("<?php echo _EMAIL_EMPTY_ALERT; ?>"); frmEdit.email.focus(); return false; }
		else if(!appIsEmail(frmEdit.email.value)){ alert("<?php echo _EMAIL_VALID_ALERT; ?>"); frmEdit.email.focus(); return false; }
		else if((frmEdit.user_password1.value != "")){ alert("<?php echo _CONF_PASSWORD_MATCH; ?>"); frmEdit.user_password2.focus(); return false; }
		return true;
	}
	</script>


	<script type="text/javascript">
        appSetFocus("<?php echo $focus_field;?>");
        appChangeCountry('<?php echo $patient_info['b_country'];?>','b_state','<?php echo decode_text($patient_info['b_state']);?>','<?php echo Application::Get('token');?>');
	</script>
    
<?php
}else{

	$objSession->SetMessage('notice','');

	draw_important_message(_NOT_AUTHORIZED);

}
?>