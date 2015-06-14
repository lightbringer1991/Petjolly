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

if($objLogin->IsLoggedInAsPatient() && Modules::IsModuleInstalled('appointments')){	

	// Start main content
	draw_title_bar(
	    prepare_breadcrumbs(array(_MY_ACCOUNT=>'',_APPOINTMENTS_MANAGEMENT=>'',ucfirst($action)=>'')),
   		(($mode == 'edit' || $mode == 'details') ? '<a href="javascript:void(\'print\')" onclick="javascript:window.print();"><img src="images/printer.png" alt="print" /> '._PRINT.'</a>' : '')
	);

	//if($objSession->IsMessage('notice')) echo $objSession->GetMessage('notice');
	echo $msg;
	
	//draw_content_start();
	echo '<div class="pages_contents">';
	if($mode == 'view'){		
	
		$objAppointments->DrawViewMode();	
	}else if($mode == 'add'){	

		$objAppointments->DrawAddMode();		
	}else if($mode == 'edit'){	

		$objAppointments->DrawEditMode($rid);		
	}else if($mode == 'details'){

		$objAppointments->DrawDetailsMode($rid);		
	}
	//draw_content_end();
	echo '</div>';
}else if($objLogin->IsLoggedIn()){
    draw_title_bar(_PATIENTS);
    draw_important_message(_NOT_AUTHORIZED);
}else{
    draw_title_bar(_PATIENTS);
	draw_important_message(str_replace('_ACCOUNT_', 'member', _MUST_BE_LOGGED));
}

?>