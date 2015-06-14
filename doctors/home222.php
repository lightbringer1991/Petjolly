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

if($objLogin->IsLoggedInAsDoctor()){

	$task = isset($_GET['task']) ? prepare_input($_GET['task']) : '';
	$alert_state = Session::Get('doctor_alert_state');
    $dashboard_state = Session::Get('doctor_dashboard_state');
	$actions_msg = array();
	
	if($task == 'close_alert'){
	    $alert_state = 'hidden';
		Session::Set('doctor_alert_state', 'hidden');
	}else if($task == 'open_alert'){
		$alert_state = '';
		Session::Set('doctor_alert_state', '');
	}else if($task == 'close_dashboard'){
        $dashboard_state = 'hidden';
        Session::Set('doctor_dashboard_state', 'hidden');
	}else if($task == 'open_dashboard'){
		$dashboard_state = '';
		Session::Set('doctor_dashboard_state', '');
    }
	
	$appointments_count = Appointments::AwaitingApprovalCount($objLogin->GetLoggedID());
	if($appointments_count > 0){
		$appointments_msg = str_replace('_COUNT_', $appointments_count, _APPOINTMENTS_AWAITING_APPROVAL_ALERT);
		$appointments_msg = str_replace('_HREF_', 'index.php?provider=appointments', $appointments_msg);
		$actions_msg[] = $appointments_msg;
	}

	$specialities_count = DoctorSpecialities::SpecialitiesCount($objLogin->GetLoggedID());
    if(!$specialities_count){
        $actions_msg[] = str_replace('_HREF_', 'index.php?provider=my_specialities', _DOCTOR_MISSING_SPECIALITIES_ALERT);
    }
    
	draw_title_bar(prepare_breadcrumbs(array(_DOCTOR=>'',_ACCOUNT_PANEL=>'')));
    
	if(count($actions_msg) > 0){        
		if($alert_state == ''){
			$msg = '<div id="divAlertMessages">
				<img src="images/close.png" alt="close" style="cursor:pointer;float:'.Application::Get('defined_right').';" title="'._HIDE.'" onclick="javascript:appGoTo(\'doctor=home\',\'&task=close_alert\')" />
				<img src="images/action_required.png" alt="action" style="margin-bottom:-3px;" />&nbsp;&nbsp;<b>'._ACTION_REQUIRED.'</b>: 
				<ul style="margin-top:7px;margin-bottom:7px;">';
				foreach($actions_msg as $single_msg){
					$msg .= '<li>'.$single_msg.'</li>';
				}
			$msg .= '</ul></div>';
			draw_important_message($msg, true, false);        
		}else{
			echo '<div id="divAlertRequired"><a href="javascript:void(0);" onclick="javascript:appGoTo(\'doctor=home\',\'&task=open_alert\')">'._SHOW_ALERT_WINDOW.'</a></div>';
            echo '<div style="clear:both"></div>';
		}
    }
    
?>
	<?php	
        if($dashboard_state == ''){
            $msgD = '';
            $msgD .= '<img id="divDashboardMessagesImg" src="images/close.png" alt="close" title="'._HIDE.'" onclick="javascript:appGoTo(\'doctor=home\',\'&task=close_dashboard\')" />';
            
            $msgD .= '<br>'; 
            $welcome_text = _WELCOME_DOCTOR_TEXT;
            $welcome_text = str_replace('_FIRST_NAME_', $objLogin->GetLoggedFirstName(), $welcome_text);
            $welcome_text = str_replace('_LAST_NAME_', $objLogin->GetLoggedLastName(), $welcome_text);
            $welcome_text = str_replace('_TODAY_', _TODAY.': <b>'.format_datetime(@date('Y-m-d H:i:s'), '', '', true).'</b>', $welcome_text);
            $welcome_text = str_replace('_LAST_LOGIN_', _LAST_LOGIN.': <b>'.format_datetime($objLogin->GetLastLoginTime(), '', _NEVER, true).'</b>', $welcome_text);
            $msgD .= $welcome_text;
            

            Login::SetMembershipInfo();
            $doctor_images = DoctorImages::GetImagesForDoctor($objLogin->GetLoggedID());
            $doctor_addresses = DoctorAddresses::GetAddresses($objLogin->GetLoggedID());			
            
            $msgM .= '<p><b>'._MEMBERSHIP_INFO.'</b>:</p>'; 
            $msgM .= '<p><b>&#8226;</b> '._NAME.': <b>'.(($objLogin->GetMembershipInfo('plan_name') != '') ? $objLogin->GetMembershipInfo('plan_name') : '--').'</b></p>'; 
            $msgM .= '<p><b>&#8226;</b> '._MEMBERSHIP_EXPIRES.': <b>'.(($objLogin->GetMembershipInfo('plan_name') != '') ? format_date($objLogin->GetMembershipInfo('expires'), '', _NEVER, true) : '--').'</b></p>';          
            
            $msgM .= '<p><b>&#8226;</b> '._IMAGES_COUNT.': <b>'.$doctor_images[1].' / '.$objLogin->GetMembershipInfo('images_count').'</b></p>'; 
            if($objLogin->GetMembershipInfo('images_count') > 0 && $doctor_images[1] == 0) $msg .= '<p class="membership-alert">'.str_replace('_HREF_', 'index.php?provider=my_images_upload', _DOCTOR_ADD_IMAGES_ALERT).'</p>';
            
            $msgM .= '<p><b>&#8226;</b> '._ADDRESSES_COUNT.': <b>'.$doctor_addresses[1].' / '.$objLogin->GetMembershipInfo('addresses_count').'</b></p>'; 
            if($objLogin->GetMembershipInfo('addresses_count') > 0 && $doctor_addresses[1] == 0) $msg .= '<p class="membership-alert">'.str_replace('_HREF_', 'index.php?provider=my_addresses', _DOCTOR_ADD_ADDRESSES_ALERT).'</p>';
            
            $msgM .= '<p><b>&#8226;</b> '._SHOW_IN_SEARCH.': <b>'.($objLogin->GetMembershipInfo('show_in_search') == '1' ? _YES : _NO).'</b></p>';            
            if(Modules::IsModuleInstalled('payments') && ModulesSettings::Get('payments', 'is_active') == 'yes'){
                if(!$objLogin->GetMembershipInfo('show_in_search')) $msg .= '<p class="membership-alert">'.str_replace('_HREF_', 'index.php?provider=membership_plans', _DOCTOR_UPGRADE_MEMBERSHIP_ALERT).'</p>';
            }

            
           
			//echo $msgM;		
            //draw_message($msg);		
        }else{
            echo '<div id="divDashboardRequired"><a href="javascript:void(0);" onclick="javascript:appGoTo(\'doctor=home\',\'&task=open_dashboard\')">'._SHOW_DASHBOARD.'</a></div>';
            echo '<div style="clear:both"></div>';
        }
	?>

   



<div style="clear:both"></div>

				<div class="row margin-top-10">
					<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
						<div class="dashboard-stat2">
							<div class="display">
								<div class="number">
									<h3 class="font-green-sharp">7800<small class="font-green-sharp">$</small></h3>
									<small>TOTAL PROFIT</small>
								</div>
								<div class="icon">
									<i class="icon-pie-chart"></i>
								</div>
							</div>
							<div class="progress-info">
								<div class="progress">
									<span style="width: 76%;" class="progress-bar progress-bar-success green-sharp">
									<span class="sr-only">76% progress</span>
									</span>
								</div>
								<div class="status">
									<div class="status-title">progress</div>
									<div class="status-number">76%</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
						<div class="dashboard-stat2">
							<div class="display">
								<div class="number">
									<h3 class="font-red-haze">1349</h3>
									<small>NEW FEEDBACKS</small>
								</div>
								<div class="icon">
									<i class="icon-like"></i>
								</div>
							</div>
							<div class="progress-info">
								<div class="progress">
									<span style="width: 85%;" class="progress-bar progress-bar-success red-haze">
									<span class="sr-only">85% change</span>
									</span>
								</div>
								<div class="status">
									<div class="status-title">change</div>
									<div class="status-number">85%</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
						<div class="dashboard-stat2">
							<div class="display">
								<div class="number">
									<h3 class="font-blue-sharp">567</h3>
									<small>NEW ORDERS</small>
								</div>
								<div class="icon">
									<i class="icon-basket"></i>
								</div>
							</div>
							<div class="progress-info">
								<div class="progress">
									<span style="width: 45%;" class="progress-bar progress-bar-success blue-sharp">
									<span class="sr-only">45% grow</span>
									</span>
								</div>
								<div class="status">
									<div class="status-title">grow</div>
									<div class="status-number">45%</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
						<div class="dashboard-stat2">
							<div class="display">
								<div class="number">
									<h3 class="font-purple-soft">276</h3>
									<small>NEW USERS</small>
								</div>
								<div class="icon">
									<i class="icon-user"></i>
								</div>
							</div>
							<div class="progress-info">
								<div class="progress">
									<span style="width: 57%;" class="progress-bar progress-bar-success purple-soft">
									<span class="sr-only">56% change</span>
									</span>
								</div>
								<div class="status">
									<div class="status-title">change</div>
									<div class="status-number">57%</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6 col-sm-12">
						<!-- BEGIN PORTLET-->
						<div class="portlet light ">
							<div class="portlet-title">
								<div class="caption caption-md">
									<i class="icon-bar-chart theme-font-color hide"></i>
									<span class="caption-subject theme-font-color bold uppercase">Sales Summary</span>
									<span class="caption-helper hide">weekly stats...</span>
								</div>
								<div class="actions">
									<div class="btn-group btn-group-devided" data-toggle="buttons">
										<label class="btn btn-transparent grey-salsa btn-circle btn-sm active">
										<input type="radio" name="options" class="toggle" id="option1">Today</label>
										<label class="btn btn-transparent grey-salsa btn-circle btn-sm">
										<input type="radio" name="options" class="toggle" id="option2">Week</label>
										<label class="btn btn-transparent grey-salsa btn-circle btn-sm">
										<input type="radio" name="options" class="toggle" id="option2">Month</label>
									</div>
								</div>
							</div>
							<div class="portlet-body">
								<div class="row list-separated">
									<div class="col-md-3 col-sm-3 col-xs-6">
										<div class="font-grey-mint font-sm">
											Total Sales
										</div>
										<div class="uppercase font-hg font-red-flamingo">
											13,760 <span class="font-lg font-grey-mint">$</span>
										</div>
									</div>
									<div class="col-md-3 col-sm-3 col-xs-6">
										<div class="font-grey-mint font-sm">
											Revenue
										</div>
										<div class="uppercase font-hg theme-font-color">
											4,760 <span class="font-lg font-grey-mint">$</span>
										</div>
									</div>
									<div class="col-md-3 col-sm-3 col-xs-6">
										<div class="font-grey-mint font-sm">
											Expenses
										</div>
										<div class="uppercase font-hg font-purple">
											11,760 <span class="font-lg font-grey-mint">$</span>
										</div>
									</div>
									<div class="col-md-3 col-sm-3 col-xs-6">
										<div class="font-grey-mint font-sm">
											Growth
										</div>
										<div class="uppercase font-hg font-blue-sharp">
											9,760 <span class="font-lg font-grey-mint">$</span>
										</div>
									</div>
								</div>
								<ul class="list-separated list-inline-xs hide">
									<li>
										<div class="font-grey-mint font-sm">
											Total Sales
										</div>
										<div class="uppercase font-hg font-red-flamingo">
											13,760 <span class="font-lg font-grey-mint">$</span>
										</div>
									</li>
									<li>
									</li>
									<li class="border">
										<div class="font-grey-mint font-sm">
											Revenue
										</div>
										<div class="uppercase font-hg theme-font-color">
											4,760 <span class="font-lg font-grey-mint">$</span>
										</div>
									</li>
									<li class="divider">
									</li>
									<li>
										<div class="font-grey-mint font-sm">
											Expenses
										</div>
										<div class="uppercase font-hg font-purple">
											11,760 <span class="font-lg font-grey-mint">$</span>
										</div>
									</li>
									<li class="divider">
									</li>
									<li>
										<div class="font-grey-mint font-sm">
											Growth
										</div>
										<div class="uppercase font-hg font-blue-sharp">
											9,760 <span class="font-lg font-grey-mint">$</span>
										</div>
									</li>
								</ul>
								<div id="sales_statistics" class="portlet-body-morris-fit morris-chart" style="height: 260px">
								</div>
							</div>
						</div>
						<!-- END PORTLET-->
					</div>
					<div class="col-md-6 col-sm-12">
						<!-- BEGIN PORTLET-->
						<div class="portlet light ">
							<div class="portlet-title">
								<div class="caption caption-md">
									<i class="icon-bar-chart theme-font-color hide"></i>
									<span class="caption-subject theme-font-color bold uppercase">Member Activity</span>
									<span class="caption-helper hide"></span>
								</div>
								<div class="actions">
									<!--div class="btn-group btn-group-devided" data-toggle="buttons">
										<label class="btn btn-transparent grey-salsa btn-circle btn-sm active">
										<input type="radio" name="options" class="toggle" id="option1">Today</label>
										<label class="btn btn-transparent grey-salsa btn-circle btn-sm">
										<input type="radio" name="options" class="toggle" id="option2">Week</label>
										<label class="btn btn-transparent grey-salsa btn-circle btn-sm">
										<input type="radio" name="options" class="toggle" id="option2">Month</label>
									</div>-->
								</div>
							</div>
							<div class="portlet-body">
								<div class="row number-stats margin-bottom-30">
									<div class="col-md-6 col-sm-6 col-xs-6">
										<div class="stat-left">
											<div class="stat-chart">
												<!-- do not line break "sparkline_bar" div. sparkline chart has an issue when the container div has line break -->
												<div id="sparkline_bar"></div>
											</div>
											<div class="stat-number">
												<div class="title">
													Total
												</div>
												<div class="number">
													2460
												</div>
											</div>
										</div>
									</div>
									<div class="col-md-6 col-sm-6 col-xs-6">
										<div class="stat-right">
											<div class="stat-chart">
												<!-- do not line break "sparkline_bar" div. sparkline chart has an issue when the container div has line break -->
												<div id="sparkline_bar2"></div>
											</div>
											<div class="stat-number">
												<div class="title">
													New
												</div>
												<div class="number">
													719
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="table-scrollable table-scrollable-borderless">
									
                                    <?php echo $msgM; ?>
                                    <br />
                                    <br />
                                     <br />
								</div>
							</div>
						</div>
						<!-- END PORTLET-->
					</div>
				</div>
				<div class="row">
					<div class="col-md-6 col-sm-12">
						<!-- BEGIN PORTLET-->
						<div class="portlet light tasks-widget">
							<div class="portlet-title">
								<div class="caption caption-md">
									<i class="icon-bar-chart theme-font-color hide"></i>
									<span class="caption-subject theme-font-color bold uppercase">TASKS</span>
									<span class="caption-helper"></span>
								</div>
								<div class="inputs">
									<div class="portlet-input input-small input-inline">
										<div class="input-icon right">
											<i class="icon-magnifier"></i>
											
										</div>
									</div>
								</div>
							</div>
							<div class="portlet-body">
								<div class="task-content">
									<div class="scroller" style="height: 282px;" data-always-visible="1" data-rail-visible1="0" data-handle-color="#D7DCE2">
										<!-- START TASK LIST -->
										<?php echo $msgD; ?>
										<!-- END START TASK LIST -->
									</div>
								</div>
								<div class="task-footer">
									<div class="btn-arrow-link pull-right">
										<!--<a href="javascript:;">See All Tasks</a>-->
									</div>
								</div>
							</div>
						</div>
						<!-- END PORTLET-->
					</div>
					<div class="col-md-6 col-sm-12">
						<!-- BEGIN PORTLET-->
						<div class="portlet light">
							<div class="portlet-title">
								<div class="caption caption-md">
									<i class="icon-bar-chart theme-font-color hide"></i>
									<span class="caption-subject theme-font-color bold uppercase"><?php echo _TODAY_APPOINTMENTS; ?></span>
									<span class="caption-helper"></span>
								</div>
								<div class="inputs">
									<div class="portlet-input input-inline input-small ">
										<div class="input-icon right">
											<i class="icon-magnifier"></i>
											
										</div>
									</div>
								</div>
							</div>
							<div class="portlet-body">
								<div class="scroller" style="height: 305px;" data-always-visible="1" data-rail-visible1="0" data-handle-color="#D7DCE2">
									<div class="general-item-list">
										<div class="item">
											
											<div class="item-body">
												<a style="float:<?php echo Application::Get('defined_right'); ?>" href="javascript:void('print')" onclick="javascript:window.print();"><img src="images/printer.png" alt="print" /> <?php echo _PRINT; ?></a>
      
        <?php Appointments::DrawAppointmentsByDate(date('Y-m-d'), $objLogin->GetLoggedID(), 'doctor'); ?>	
											</div>
										</div>
										
										
										
										
										
										
									</div>
								</div>
							</div>
						</div>
						<!-- END PORTLET-->
					</div>
				</div>
				
                <?php
}else if($objLogin->IsLoggedIn()){
    draw_title_bar(prepare_breadcrumbs(array(_DOCTOR=>'')));
    draw_important_message(_NOT_AUTHORIZED);
}else{
    draw_title_bar(prepare_breadcrumbs(array(_DOCTOR=>'')));
    draw_message(str_replace('_ACCOUNT_', 'doctor', _MUST_BE_LOGGED));
}
?>