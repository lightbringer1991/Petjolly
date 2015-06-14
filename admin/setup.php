<?php
//include_once('templates/'.Application::Get('provider_template').'/default.php');
//include_once('provider/addListingPage.php');

// *** Make sure the file isn't accessed directly
defined('APPHP_EXEC') or die('Restricted Access');
if($objLogin->IsLoggedInAsAdmin()) {
	$step = isset($_REQUEST['step']) ? $_REQUEST['step'] : 1;
	// determine progress bar width
	$width = array(0, 0, 0, 0);
	if ($step == 2) { $width[0] = 100; $width[1] = 50; }
	elseif ($step == 3) { $width[0] = 100; $width[1] = 100; $width[2] = 50;}
	elseif ($step == 4) { $width[0] = 100; $width[1] = 100; $width[2] = 100; $width[3] = 100; }
?>
<link rel="stylesheet" href="assets/frontend/layout/css/sceditor/default.min.css" type="text/css" media="all" />
<link href="templates/sun/css/listingSetup.css" rel="stylesheet" />

<style>
.radio-class{width:32px;}

<!--
span.stepIcon {
	font-size: 45px;
	padding-left: 13px;
	padding-top: 27px;
	color: black;
	opacity: 0.3;
}
-->
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

</style>

<div class="row smpl-step" style="border-bottom: 0; min-width: 500px;">
	<div class="col-xs-3 smpl-step-step smpl-step-step1">
		<div class="progress">
			<div class="progress-bar" role="progress-bar" <?php echo "style='width: {$width[0]}%'"; ?>></div>
		</div>
		<a class="smpl-step-icon">
			<!-- <span class="glyphicon glyphicon-user stepIcon current" aria-hidden="true"></span> -->
			<span class="stepIcon current">1</span>
		</a>
		<div class="smpl-step-info text-center">Business Information </div>
	</div>
	
	<div class="col-xs-3 smpl-step-step smpl-step-step2">           
		<div class="progress">
			<div class="progress-bar" role="progress-bar" <?php echo "style='width: {$width[1]}%'"; ?>></div>
		</div>
		<a class="smpl-step-icon">
<!--			<span class="glyphicon glyphicon-glass stepIcon <?php //if ($step >= 2) { echo "current"; } ?>" aria-hidden="true"></span>	-->
			<span class="stepIcon <?php if ($step >= 2) { echo "current"; } ?>">2</span>
		</a>
		<div class="smpl-step-info text-center">Social Information</div>
	</div>

	<div class="col-xs-3 smpl-step-step smpl-step-step3">          
		<div class="progress">
			<div class="progress-bar" role="progress-bar" <?php echo "style='width: {$width[2]}%'"; ?>></div>
		</div>
		<a class="smpl-step-icon">
<!--			<span class="glyphicon glyphicon-download-alt stepIcon <?php //if ($step >= 3) { echo "current"; } ?>" aria-hidden="true"></span>	-->
			<span class="stepIcon <?php if ($step >= 3) { echo "current"; } ?>">3</span>
		</a>
		<div class="smpl-step-info text-center">Images Upload</div>
	</div>

	 <div class="col-xs-3 smpl-step-step smpl-step-step4">          
		<div class="progress">
			<div class="progress-bar" role="progress-bar" <?php echo "style='width: {$width[3]}%'"; ?>></div>
		</div>
		<a class="smpl-step-icon">
<!--			<span class="glyphicon glyphicon-ok stepIcon <?php //if ($step >= 4) { echo "current"; } ?>" aria-hidden="true"></span>	-->
			<span class="stepIcon <?php if ($step >= 4) { echo "current"; } ?>">4</span>
		</a>
		<div class="smpl-step-info text-center">Confirmation Page</div>
	</div>
</div>
<div style="clear:both"></div>

<?php
	$doctorInfo = Doctors::GetDoctorInfoById($objLogin -> GetLoggedID());
	$address = DoctorAddresses::GetAddresses($objLogin -> GetLoggedID());
	$ammenties = Ammenties::GetAmmenties($objLogin -> GetLoggedID());
//	echo var_dump($doctorInfo);
//	echo var_dump($address);
//	echo var_dump($ammenties);
?>

<div class="row">
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
