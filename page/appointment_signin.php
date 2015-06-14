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

$prm = isset($_GET['prm']) ? base64_decode($_GET['prm']) : '';

$get = array();

parse_str($prm, $get);



$params = array();

$params['docid']      = isset($_REQUEST['docid']) ? (int)$_REQUEST['docid'] : '';

$params['dspecid']      = isset($_REQUEST['dspecid']) ? (int)$_REQUEST['dspecid'] : '';

$params['insid']      = isset($_REQUEST['insid']) ? (int)$_REQUEST['insid'] : '';

$params['vrid']          = isset($_REQUEST['vrid']) ? (int)$_REQUEST['vrid'] : '';

$params['schid']       = isset($_REQUEST['schid']) ? (int)$_REQUEST['schid'] : '';

$params['daddid']       = isset($_REQUEST['daddid']) ? (int)$_REQUEST['daddid'] : '';

$params['date']       = isset($_REQUEST['date']) ? prepare_input($_REQUEST['date']) : '';

$params['start_time'] = isset($_REQUEST['start_time']) ? prepare_input($_REQUEST['start_time']) : '';

$params['duration']   = isset($_REQUEST['duration']) ? (int)$_REQUEST['duration'] : '';


if(Modules::IsModuleInstalled('appointments') && ModulesSettings::Get('appointments', 'is_active') == 'yes'){
$u_type	  = isset($_REQUEST['user_type']) ? $_REQUEST['user_type'] : ''; 
 
draw_title_bar(_SIGN_IN);
draw_appointment_bar(2);

if(Appointments::VerifyAppointment($params)){
    Appointments::DrawAppointmentDetailsForGuest($params); ?>
    <script type="text/javascript">
                    function display_GuestAction(action){
                        if(action == '0'){
                            jQuery('#guest_register').show();
                            jQuery('#guest_login').hide();
                        } else {
                            jQuery('#guest_register').hide();
                            jQuery('#guest_login').show();
                        }

                    }
                    
                </script>    
<?php
}else{
    draw_important_message(Appointments::GetStaticError());
}
?>
<?php }else{
	draw_title_bar(_APPOINTMENTS);
	draw_important_message(_NOT_AUTHORIZED);
}

	

?>