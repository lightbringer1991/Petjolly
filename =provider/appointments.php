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

if($objLogin->IsLoggedInAsDoctor() && Modules::IsModuleInstalled('appointments')){	

	$action = MicroGrid::GetParameter('action');
	$rid    = MicroGrid::GetParameter('rid');
	$mode   = 'view';
	$msg    = '';
	
	$objAppointments = new Appointments();
	
	if($action=='add'){		
		$mode = 'add';
	}else if($action=='create'){
		$mode = 'view';
	}else if($action=='edit'){
		$mode = 'edit';
	}else if($action=='update'){
		if($objAppointments->UpdateRecord($rid)){
			$msg = draw_success_message(_UPDATING_OPERATION_COMPLETED, false);
			$mode = 'view';
		}else{
			$msg = draw_important_message($objAppointments->error, false);
			$mode = 'edit';
		}		
	}else if($action=='delete'){
		$mode = 'view';
	}else if($action=='details'){		
		$mode = 'details';		
	}else if($action=='cancel_add'){		
		$mode = 'view';		
	}else if($action=='cancel_edit'){				
		$mode = 'view';
    }else{
        $action = '';
    }

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
	draw_title_bar(_DOCTORS);
	draw_important_message(_NOT_AUTHORIZED);
}else{
	draw_title_bar(_DOCTORS);
	draw_message(str_replace('_ACCOUNT_', 'doctor', _MUST_BE_LOGGED));
}

?>