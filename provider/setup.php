<?php
//include_once('templates/'.Application::Get('provider_template').'/default.php');
//include_once('provider/addListingPage.php');

// *** Make sure the file isn't accessed directly
defined('APPHP_EXEC') or die('Restricted Access');
if($objLogin->IsLoggedInAsDoctor()) {
    draw_title_bar(prepare_breadcrumbs(array(_BUSINESS_SETUP=>'')));

	$step = isset($_REQUEST['step']) ? $_REQUEST['step'] : 1;
	// determine progress bar width
	$width = array(0, 0, 0, 0);
	if ($step == 2) { $width[0] = 100; $width[1] = 50; }
	elseif ($step == 3) { $width[0] = 100; $width[1] = 100; $width[2] = 50;}
	elseif ($step == 4) { $width[0] = 100; $width[1] = 100; $width[2] = 100; $width[3] = 100; }
?>
<!--
<link rel="stylesheet" href="assets/frontend/layout/css/sceditor/default.min.css" type="text/css" media="all" />
<link href="templates/sun/css/listingSetup.css" rel="stylesheet" />
-->
<style>
.radio-class{width:32px;}

/*
span.stepIcon {
	font-size: 45px;
	padding-left: 13px;
	padding-top: 27px;
	color: black;
	opacity: 0.3;
}

span.stepIcon {
	font-size: 54px;
	padding-left: 19px;
	padding-top: 40px;
	color: black;
	opacity: 0.3;
}

span.stepIcon.current {
	opacity: 1;
}
*/
.smpl-step > .smpl-step-step .smpl-step-info {
    font-size: 20px;
    font-weight: bold;
    opacity: 0.3;
}

.smpl-step > .smpl-step-step .smpl-step-info.current {
    opacity: 1;
}

select.workingHour {
	width: 100px;
}

label.error {
	color: red;
}

input[type="checkbox"] {
	width: inherit;
}

.main {
	padding: 0%;
}

.buttons button {
    margin-right: 10px;
    margin-top: 10px;
}

</style>

<div class="row smpl-step" style="border-bottom: 0; min-width: 500px;">
	<div class="col-xs-3 smpl-step-step smpl-step-step1">
		<div class="smpl-step-info text-center current">Business Information </div>
	</div>
	
	<div class="col-xs-3 smpl-step-step smpl-step-step2">
		<div class="smpl-step-info text-center <?php if ($step >= 2) { echo "current"; } ?>">Services</div>
	</div>

	<div class="col-xs-3 smpl-step-step smpl-step-step3">          
		<div class="smpl-step-info text-center <?php if ($step >= 3) { echo "current"; } ?>">Social Information</div>
	</div>

	 <div class="col-xs-3 smpl-step-step smpl-step-step4">          
		<div class="smpl-step-info text-center <?php if ($step >= 4) { echo "current"; } ?>">Store Images</div>
	</div>
</div>
<div style="clear:both"></div>

<?php
	$doctorInfo = Doctors::GetDoctorInfoById($objLogin -> GetLoggedID());
	$address = DoctorAddresses::GetAddresses($objLogin -> GetLoggedID());
//	echo var_dump($doctorInfo);
//	echo var_dump($address);
//	echo var_dump($ammenties);
//  echo var_dump($specialities);
?>

<div class="row" style="margin-left: 0px;">
<?php
	if ($step == 1) { include_once "provider/setup_step1.php"; }
	elseif ($step == 2) { include_once "provider/setup_step2.php";}
	elseif ($step == 3) { include_once "provider/setup_step3.php";}
	elseif ($step == 4) { include_once "provider/setup_step4.php";}
?>
</div>

<?php
}
?>
