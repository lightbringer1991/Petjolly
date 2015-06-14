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

function generateAppointmentTables($data) {
    echo "<table class='table table-hover table-striped table-bordered'>
                        <thead>
                            <th>Time</th>
                            <th>Customer</th>
                            <th>Services</th>
                            <th>Action</th>
                        </thead>
                        <tbody>";
    // no appointment found
    if ($data[1] == 0) {
        echo "<tr><td colspan='4' align='center'>No Appointment scheduled</td></tr>";
        echo "    </tbody>
            </table>";
        return;
    }

    $action = "<a href='#' data-role='view_appointment_invoice'><span class='glyphicon glyphicon-eye-open'></span></a>";
    foreach ($data[0] as $ta) {
        // being service listing
        $serviceTD = "<ul>
                        <li>Services
                            <ul>";
        $services = explode(',', $ta['service_list']);
        foreach ($services as $s) {
            if ($s == '') { break; }
            $aService = Services::getServiceById($s);
            $serviceTD .= "<li id='{$aService -> getId()}'>{$aService -> getName()}</li>";
        }
        // end service listing, begin package listing
        $serviceTD .= "    </ul>
                        </li>
                        <li>Packages</li>
                            <ul>";
        $packages = explode(',', $ta['package_list']);
        foreach ($packages as $p) {
            if ($p == '') { break; }
            $aPackage = Packages::getPackageById($p);
            if ($aPackage != null) {
                $serviceTD .= "<li id='{$aPackage -> getId()}'>{$aPackage -> getName()}</li>";
            }
        }
        $serviceTD .= "     </ul>
                        </li>
                        </ul>";


        echo "<tr id='" . $ta['id'] . "'>
                <td>" . $ta['appointment_date'] . " " . $ta['appointment_time'] . "</td>
                <td>" . $ta['first_name'] . " " . $ta['last_name'] . "</td>
                <td>$serviceTD</td>
                <td align='center'>$action</td>
             </tr>";
    }
    echo "    </tbody>
            </table>";
}

if($objLogin->IsLoggedInAsDoctor()){
    $provider_id = $objLogin -> getLoggedID();
    $today_appointments = Appointments::getAllTodaysAppointmentByProvider($provider_id);
    $upcoming_appointments = Appointments::getAllUpcomingAppointmentsInMonthByProvider($provider_id);

    draw_title_bar(prepare_breadcrumbs(array(_DASHBOARD=>'')));

   /* $rid = $objLogin->GetLoggedID();
    $sql = 'SELECT mapflg FROM meda_doctors WHERE id = \''.$rid.'\'';
    $result = mysql_query($sql);
    $value = mysql_fetch_object($result);
    $mflg =  $value->mapflg;

    $referel_url = parse_url($_SERVER['HTTP_REFERER']);
    $open_popup = false;
    if($referel_url['query'] == 'provider=login' && $mflg == 0){
        $open_popup = true;
        include_once('doctor/addListingPage.php');
     }    
    */
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
/*
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
				<img src="images/close.png" alt="close" style="cursor:pointer;float:'.Application::Get('defined_right').';" title="'._HIDE.'" onclick="javascript:appGoTo(\'provider=home\',\'&task=close_alert\')" />
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
*/
    
?>
<style type="text/css">
h3, h4 {
	vertical-align: middle;
}

h3>.badge {
	vertical-align: middle;
	margin-top: 0.2em;
}

.square {
    background: #000;
    width: 10px;
    height: 10px;
	float: left;
	margin: 0 10px 0 0;
}

h3>.square {
	vertical-align: middle;
	margin-top: 0.5em;
}

.list-group-item-text {
	vertical-align: middle;
}

.list-group-item-text>.label {
	vertical-align: middle;
	margin-top: -0.2em;
}

.calendar_date {
	width: 100%;
}

.jqx-calendar-cell-specialDate {
	font-weight: bold;
}

</style>
	
	<div class="row">
	<div class="col-md-6 col-sm-12">
        <div class="col-md-offset-1">
        <div class="row">
	<?php
        if($dashboard_state == '') {
            $msg = '<div id="divDashboardMessages">';
            $msg .= '<img id="divDashboardMessagesImg" src="images/close.png" alt="close" title="'._HIDE.'" onclick="javascript:appGoTo(\'doctor=home\',\'&task=close_dashboard\')" />';
            
            $msg .= '<br>'; 
            $welcome_text = _WELCOME_DOCTOR_TEXT;
            $welcome_text = str_replace('_FIRST_NAME_', $objLogin->GetLoggedFirstName(), $welcome_text);
            $welcome_text = str_replace('_LAST_NAME_', $objLogin->GetLoggedLastName(), $welcome_text);
            $welcome_text = str_replace('_TODAY_', _TODAY.': <b>'.format_datetime(@date('Y-m-d H:i:s'), '', '', true).'</b>', $welcome_text);
            $welcome_text = str_replace('_LAST_LOGIN_', _LAST_LOGIN.': <b>'.format_datetime($objLogin->GetLastLoginTime(), '', _NEVER, true).'</b>', $welcome_text);
            $msg .= $welcome_text;
            $msg .= '<br>'; 
            $msg .= '</div>';
            draw_message($msg);

        }else{
            echo '<div id="divDashboardRequired"><a href="javascript:void(0);" onclick="javascript:appGoTo(\'doctor=home\',\'&task=open_dashboard\')">'._SHOW_DASHBOARD.'</a></div>';
            echo '<div style="clear:both"></div>';
        }
	?>

    <br>

        </div>  <!-- end row  -->
        <div class="row">
            <div id="homeChart_container"></div>
        </div>
        </div>  <!-- end col-offset -->
    </div>  <!-- end col  -->
	<div class="col-md-6 col-sm-12">
        <div class="col-md-offset-1">
        <div class="row" align="center">
            <h3>Appointments</h3>
        </div>
        <div class="row">
            <ul class="nav nav-tabs">
                <li class='active'><a data-toggle="tab" href="#today_appointments">Today</a></li>
                <li><a data-toggle="tab" href="#upcoming_appointments">Upcoming</a></li>
            </ul>
            <div class="tab-content">
                <div id="today_appointments" class="tab-pane fade in active">
<?php generateAppointmentTables($today_appointments); ?>
                </div>
                <div id="upcoming_appointments" class="tab-pane fade">
<?php generateAppointmentTables($upcoming_appointments); ?>
                </div>
            </div>
        </div>  <!-- end row -->
        </div>
	</div>
	</div> <!-- end row -->

<div id="invoice_container">
    <div class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Invoice</h4>
                </div>
                <div class="modal-body">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</div>
	
<script type="text/javascript">
$(document).ready(function() {
    renderHomeChart($("div#homeChart_container"));

/*
	$('p.calendar_date').find('.datepickerSelected a').click();
	
	$("div[data-toggle='popover']").popover({
		placement: 'left',
		html: true
	});
*/
});
</script>
<?php
}else if($objLogin->IsLoggedIn()){
    draw_title_bar(prepare_breadcrumbs(array(_DOCTOR=>'')));
    draw_important_message(_NOT_AUTHORIZED);
}else{
    draw_title_bar(prepare_breadcrumbs(array(_DOCTOR=>'')));
    draw_message(str_replace('_ACCOUNT_', 'doctor', _MUST_BE_LOGGED));
}
?>