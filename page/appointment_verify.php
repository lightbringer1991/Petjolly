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

if(($objLogin->IsLoggedInAsPatient() || $objLogin->IsLoggedInAs('owner','mainadmin')) &&
    Modules::IsModuleInstalled('appointments') &&
	ModulesSettings::Get('appointments', 'is_active') == 'yes'){
	$params = Array ( 'docid' => 3 , 'dspecid' => 103, 'insid' =>'', 'vrid' =>'', 'schid' => 8, 'daddid' => 6, 'date' => '2015-01-05', 'start_time' => '10-20', 'duration' => '20' );
	draw_title_bar(_VERIFY_APPOINTMENT);
	draw_appointment_bar(3);
    draw_content_start();	
	if($task == 'verify_appointment' && Appointments::VerifyAppointment($params)){
		Appointments::DrawVerifyAppointment($params);	    
	}else{
		draw_important_message(Appointments::GetStaticError());
	}
    draw_content_end();
}else{

	draw_title_bar(_APPOINTMENTS);
	draw_important_message(_NOT_AUTHORIZED);
}
	
?>