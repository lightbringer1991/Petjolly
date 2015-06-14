

<link rel="stylesheet" href="/assets/frontend/layout/css/sceditor/default.min.css" type="text/css" media="all" />

    <div class="row smpl-step" style="border-bottom: 0; min-width: 500px;">
        <div class="col-xs-3 smpl-step-step smpl-step-step1">
            <div class="progress">
                <div class="progress-bar"></div>
            </div>
            <a class="smpl-step-icon"><i class="fa fa-user" style="font-size: 60px; padding-left: 12px; padding-top: 28px; color: black;"></i></a>
            <div class="smpl-step-info text-center">Address Information </div>
        </div>

        <div class="col-xs-3 smpl-step-step smpl-step-step2">           
            <div class="progress">
                <div class="progress-bar"></div>
            </div>
            <a class="smpl-step-icon"><i class="fa fa-dollar" style="font-size: 60px; padding-left: 18px; padding-top: 28px; color: black;"></i></a>
            <div class="smpl-step-info text-center">Social Information</div>
        </div>
        <div class="col-xs-3 smpl-step-step smpl-step-step3">          
            <div class="progress">
                <div class="progress-bar"></div>
            </div>
            <a class="smpl-step-icon"><i class="fa fa-download" style="font-size: 60px; padding-left: 8px; padding-top: 28px; color: black; opacity: 0.3;"></i></i></a>
            <div class="smpl-step-info text-center">Files Upload Information</div>
        </div>
		 <div class="col-xs-3 smpl-step-step smpl-step-step4">          
            <div class="progress">
                <div class="progress-bar"></div>
            </div>
            <a class="smpl-step-icon"><i class="fa fa-download" style="font-size: 60px; padding-left: 8px; padding-top: 28px; color: black; opacity: 0.3;"></i></i></a>
            <div class="smpl-step-info text-center">Confirmation Page</div>
        </div>
    </div>
<!--a class="fancybox" href="#inline1" title="Lorem ipsum dolor sit amet" ></a-->

<?php 
	$rid = $objLogin->GetLoggedID();
	$sql = 'SELECT * FROM meda_doctors WHERE id = \''.$rid.'\'';
	$result = mysql_query($sql);
	while($row = mysql_fetch_array($result)){
		$address = $row['b_address'];
		$list_mon_open = trim($row['list_mon_open']);
		$list_mon_close = trim($row['list_mon_close']);
		$list_tue_open = trim($row['list_tue_open']);
		$list_tue_close = trim($row['list_tue_close']);
		$list_wed_open = trim($row['list_wed_open']);
		$list_wed_close = trim($row['list_wed_close']);
		$list_thur_open = trim($row['list_thur_open']);
		$list_thur_close = trim($row['list_thur_close']);
		$list_fri_open = trim($row['list_fri_open']);
		$list_fri_close = trim($row['list_fri_close']);
		$list_sat_open = trim($row['list_sat_open']);
		$list_sat_close = trim($row['list_sat_close']);
		$list_sun_open = trim($row['list_sun_close']);
		$list_sun_close = trim($row['list_sun_close']);
		$list_website = trim($row['list_website']);
		$list_twitter = trim($row['list_twitter']);
		$list_facebook = trim($row['list_facebook']);
		$list_google = trim($row['list_google']);
		$list_desc = trim($row['list_desc']);
		$list_mobile = trim($row['list_mobile']);
		$list_fax = $row['fax'];
		$list_phone = $row['phone'];
		$storerfeatured = $row['storerfeatured'];
	} 
	
	$sql = 'SELECT * FROM meda_doctors WHERE id = \''.$rid.'\'';
	$result = mysql_query($sql);
	//$mflg =  $value->mapflg;
?>
<link href="templates/sun/css/listingSetup.css" rel="stylesheet">
<div id="inline1" <?PHP /* ?> style="width:500px;" <?php */ ?>>
        <!--start Step1-->       
		<div class="step1 steps" id="step1">
			 <!--div class="row">
				<legend>Title <span>*</span></legend>
				<input name="" type="text" placeholder="My Restaurant" name="title"/>
			</div-->
			<form action="#" method="get" name="step1-form" id="step1-form">
				<div class="row">
					<!--legend>Address<span>*</span></legend-->
				    <div class="form-group">
					
					<input title="Address"  id="address" class="placepicker form-control required-entry" name="address" value="<?php echo $address  ?>"   placeholder="Enter a location"/>
					<input title="Zip Code"  id="zip_code" class="required-entry" name="zip_code" value="<?php echo $address  ?>"   placeholder="Enter a Zip Code"/>
					</div>
				</div>
				<div class="row">
					<!--<a href="#"><img src="images/steps/find-map.jpg" /></a>
					<a href="#"><img src="images/steps/getfrom-map.jpg" /></a> -->
					<div class="map" id="map"></div>
					<!--input id="checkbox" name="" type="checkbox" value="" /><p style="float:left;">Enter address details Manually</p-->
				</div>
				<div class="row"> 
					<legend>Business Hours<span>*</span></legend>
					<div class="input_fields_wrap">
						<div class="business_hours">
							 <?php if($list_mon_open && $list_mon_close){  ?>
								<select class="weekday required-entry" name="business_hours[weekday][]" title="WeekDay">
										<option value="0" selected="selected">Mon</option>
										<option value="1">Tue</option>
										<option value="2">Wed</option>
										<option value="3">Thu</option>
										<option value="4">Fri</option>
										<option value="5">Sat</option>
										<option value="6">Sun</option>
								</select>
									<select class="hours-start required-entry"  name="business_hours[hours-start][]" title="Start Hours">
										<option value="9:00 am " <?php if($list_mon_open == '9:00 am'){ ?> selected="selected"<?php } ?>>9:00 am </option>
										<option value="9:30 am " <?php if($list_mon_open == '9:30 am'){ ?> selected="selected"<?php } ?>>9:30 am </option>
										<option value="10:00 am " <?php if($list_mon_open == '10:00 am'){ ?> selected="selected"<?php } ?>>10:00 am </option>
										<option value="10:30 am " <?php if($list_mon_open == '10:30 am'){ ?> selected="selected"<?php } ?>>10:30 am </option>
										<option value="11:00 am " <?php if($list_mon_open == '11:00 am'){ ?> selected="selected"<?php } ?>>11:00 am </option>			
										<option value="11:30 am " <?php if($list_mon_open == '11:30 am'){ ?> selected="selected"<?php } ?>>11:30 am </option>
										<option value="12:00 pm (noon)" <?php if($list_mon_open == '12:00 pm'){ ?> selected="selected"<?php } ?>>12:00 pm (noon)</option>
										<option value="12:30 pm " <?php if($list_mon_open == '12:30 pm'){ ?> selected="selected"<?php } ?>>12:30 pm </option>
										<option value="1:00 pm " <?php if($list_mon_open == '1:00 pm'){ ?> selected="selected"<?php } ?>>1:00 pm </option>
										<option value="1:30 pm " <?php if($list_mon_open == '1:30 pm'){ ?> selected="selected"<?php } ?>>1:30 pm </option>
										<option value="2:00 pm " <?php if($list_mon_open == '2:00 pm'){ ?> selected="selected"<?php } ?>>2:00 pm </option>			
										<option value="2:30 pm " <?php if($list_mon_open == '2:30 pm'){ ?> selected="selected"<?php } ?>>2:30 pm </option>
										<option value="3:00 pm " <?php if($list_mon_open == '3:00 pm'){ ?> selected="selected"<?php } ?>>3:00 pm </option>
										<option value="3:30 pm " <?php if($list_mon_open == '3:30 pm'){ ?> selected="selected"<?php } ?>>3:30 pm </option>
										<option value="4:00 pm " <?php if($list_mon_open == '4:00 pm'){ ?> selected="selected"<?php } ?>>4:00 pm </option>
										<option value="4:30 pm " <?php if($list_mon_open == '4:30 pm'){ ?> selected="selected"<?php } ?>>4:30 pm </option>
										<option value="5:00 pm " <?php if($list_mon_open == '5:00 pm'){ ?> selected="selected"<?php } ?>>5:00 pm </option>
										<option value="6:00 pm " <?php if($list_mon_open == '6:00 pm'){ ?> selected="selected"<?php } ?>>6:00 pm </option>
								</select>
								<select class="hours-end required-entry"  name="business_hours[hours-end][]" title="End Hours">
										<option value="" >Closed</option>
										<option value="9:00 am " <?php if($list_mon_close == '9:00 am'){ ?> selected="selected"<?php } ?>>9:00 am </option>
										<option value="9:30 am " <?php if($list_mon_close == '9:30 am'){ ?> selected="selected"<?php } ?>>9:30 am </option>
										<option value="10:00 am " <?php if($list_mon_close == '10:00 am'){ ?> selected="selected"<?php } ?>>10:00 am </option>
										<option value="10:30 am " <?php if($list_mon_close == '10:30 am'){ ?> selected="selected"<?php } ?>>10:30 am </option>
										<option value="11:00 am " <?php if($list_mon_close == '11:00 am'){ ?> selected="selected"<?php } ?>>11:00 am </option>			
										<option value="11:30 am " <?php if($list_mon_close == '11:30 am'){ ?> selected="selected"<?php } ?>>11:30 am </option>
										<option value="12:00 pm (noon)" <?php if($list_mon_close == '12:00 pm'){ ?> selected="selected"<?php } ?>>12:00 pm (noon)</option>
										<option value="12:30 pm " <?php if($list_mon_close == '12:30 pm'){ ?> selected="selected"<?php } ?>>12:30 pm </option>
										<option value="1:00 pm " <?php if($list_mon_close == '1:00 pm'){ ?> selected="selected"<?php } ?>>1:00 pm </option>
										<option value="1:30 pm " <?php if($list_mon_close == '1:30 pm'){ ?> selected="selected"<?php } ?>>1:30 pm </option>
										<option value="2:00 pm " <?php if($list_mon_close == '2:00 pm'){ ?> selected="selected"<?php } ?>>2:00 pm </option>			
										<option value="2:30 pm " <?php if($list_mon_close == '2:30 pm'){ ?> selected="selected"<?php } ?>>2:30 pm </option>
										<option value="3:00 pm " <?php if($list_mon_close == '3:00 pm'){ ?> selected="selected"<?php } ?>>3:00 pm </option>
										<option value="3:30 pm " <?php if($list_mon_close == '3:30 pm'){ ?> selected="selected"<?php } ?>>3:30 pm </option>
										<option value="4:00 pm " <?php if($list_mon_close == '4:00 pm'){ ?> selected="selected"<?php } ?>>4:00 pm </option>
										<option value="4:30 pm " <?php if($list_mon_close == '4:30 pm'){ ?> selected="selected"<?php } ?>>4:30 pm </option>
										<option value="5:00 pm " <?php if($list_mon_close == '5:00 pm'){ ?> selected="selected"<?php } ?>>5:00 pm </option>
										<option value="6:00 pm " <?php if($list_mon_close == '6:00 pm'){ ?> selected="selected"<?php } ?>>6:00 pm </option>
								</select>
							<?php } ?>
							 <?php if($list_tue_open && $list_tue_close){  ?>
							 <br />
							 <br />
								<select class="weekday required-entry" name="business_hours[weekday][]" title="WeekDay">
										<option value="0" >Mon</option>
										<option value="1" selected="selected">Tue</option>
										<option value="2">Wed</option>
										<option value="3">Thu</option>
										<option value="4">Fri</option>
										<option value="5">Sat</option>
										<option value="6">Sun</option>
								</select>
								<select class="hours-start required-entry"  name="business_hours[hours-start][]" title="Start Hours">		
										<option value="9:00 am " <?php if($list_tue_open == '9:00 am'){ ?> selected="selected"<?php } ?>>9:00 am </option>
										<option value="9:30 am " <?php if($list_tue_open == '9:30 am'){ ?> selected="selected"<?php } ?>>9:30 am </option>
										<option value="10:00 am " <?php if($list_tue_open == '10:00 am'){ ?> selected="selected"<?php } ?>>10:00 am </option>
										<option value="10:30 am " <?php if($list_tue_open == '10:30 am'){ ?> selected="selected"<?php } ?>>10:30 am </option>
										<option value="11:00 am " <?php if($list_tue_open == '11:00 am'){ ?> selected="selected"<?php } ?>>11:00 am </option>			
										<option value="11:30 am " <?php if($list_tue_open == '11:30 am'){ ?> selected="selected"<?php } ?>>11:30 am </option>
										<option value="12:00 pm (noon)" <?php if($list_tue_open == '12:00 pm'){ ?> selected="selected"<?php } ?>>12:00 pm (noon)</option>
										<option value="12:30 pm " <?php if($list_tue_open == '12:30 pm'){ ?> selected="selected"<?php } ?>>12:30 pm </option>
										<option value="1:00 pm " <?php if($list_tue_open == '1:00 pm'){ ?> selected="selected"<?php } ?>>1:00 pm </option>
										<option value="1:30 pm " <?php if($list_tue_open == '1:30 pm'){ ?> selected="selected"<?php } ?>>1:30 pm </option>
										<option value="2:00 pm " <?php if($list_tue_open == '2:00 pm'){ ?> selected="selected"<?php } ?>>2:00 pm </option>			
										<option value="2:30 pm " <?php if($list_tue_open == '2:30 pm'){ ?> selected="selected"<?php } ?>>2:30 pm </option>
										<option value="3:00 pm " <?php if($list_tue_open == '3:00 pm'){ ?> selected="selected"<?php } ?>>3:00 pm </option>
										<option value="3:30 pm " <?php if($list_tue_open == '3:30 pm'){ ?> selected="selected"<?php } ?>>3:30 pm </option>
										<option value="4:00 pm " <?php if($list_tue_open == '4:00 pm'){ ?> selected="selected"<?php } ?>>4:00 pm </option>
										<option value="4:30 pm " <?php if($list_tue_open == '4:30 pm'){ ?> selected="selected"<?php } ?>>4:30 pm </option>
										<option value="5:00 pm " <?php if($list_tue_open == '5:00 pm'){ ?> selected="selected"<?php } ?>>5:00 pm </option>
										<option value="6:00 pm " <?php if($list_tue_open == '6:00 pm'){ ?> selected="selected"<?php } ?>>6:00 pm </option>
								</select>
								<select class="hours-end required-entry"  name="business_hours[hours-end][]" title="End Hours">
																		<option value="" >Closed</option>
										<option value="9:00 am " <?php if($list_tue_close == '9:00 am'){ ?> selected="selected"<?php } ?>>9:00 am </option>
										<option value="9:30 am " <?php if($list_tue_close == '9:30 am'){ ?> selected="selected"<?php } ?>>9:30 am </option>
										<option value="10:00 am " <?php if($list_tue_close == '10:00 am'){ ?> selected="selected"<?php } ?>>10:00 am </option>
										<option value="10:30 am " <?php if($list_tue_close == '10:30 am'){ ?> selected="selected"<?php } ?>>10:30 am </option>
										<option value="11:00 am " <?php if($list_tue_close == '11:00 am'){ ?> selected="selected"<?php } ?>>11:00 am </option>			
										<option value="11:30 am " <?php if($list_tue_close == '11:30 am'){ ?> selected="selected"<?php } ?>>11:30 am </option>
										<option value="12:00 pm (noon)" <?php if($list_tue_close == '12:00 pm'){ ?> selected="selected"<?php } ?>>12:00 pm (noon)</option>
										<option value="12:30 pm " <?php if($list_tue_close == '12:30 pm'){ ?> selected="selected"<?php } ?>>12:30 pm </option>
										<option value="1:00 pm " <?php if($list_tue_close == '1:00 pm'){ ?> selected="selected"<?php } ?>>1:00 pm </option>
										<option value="1:30 pm " <?php if($list_tue_close == '1:30 pm'){ ?> selected="selected"<?php } ?>>1:30 pm </option>
										<option value="2:00 pm " <?php if($list_tue_close == '2:00 pm'){ ?> selected="selected"<?php } ?>>2:00 pm </option>			
										<option value="2:30 pm " <?php if($list_tue_close == '2:30 pm'){ ?> selected="selected"<?php } ?>>2:30 pm </option>
										<option value="3:00 pm " <?php if($list_tue_close == '3:00 pm'){ ?> selected="selected"<?php } ?>>3:00 pm </option>
										<option value="3:30 pm " <?php if($list_tue_close == '3:30 pm'){ ?> selected="selected"<?php } ?>>3:30 pm </option>
										<option value="4:00 pm " <?php if($list_tue_close == '4:00 pm'){ ?> selected="selected"<?php } ?>>4:00 pm </option>
										<option value="4:30 pm " <?php if($list_tue_close == '4:30 pm'){ ?> selected="selected"<?php } ?>>4:30 pm </option>
										<option value="5:00 pm " <?php if($list_tue_close == '5:00 pm'){ ?> selected="selected"<?php } ?>>5:00 pm </option>
										<option value="6:00 pm " <?php if($list_tue_close == '6:00 pm'){ ?> selected="selected"<?php } ?>>6:00 pm </option>
								</select>
							<?php } ?>
							 <?php if($list_wed_open && $list_wed_close){  ?>
 							 <br />
							 <br />
								<select class="weekday required-entry" name="business_hours[weekday][]" title="WeekDay">
										<option value="0" >Mon</option>
										<option value="1">Tue</option>
										<option value="2" selected="selected">Wed</option>
										<option value="3">Thu</option>
										<option value="4">Fri</option>
										<option value="5">Sat</option>
										<option value="6">Sun</option>
								</select>
									<select class="hours-start required-entry"  name="business_hours[hours-start][]" title="Start Hours">		
										<option value="9:00 am " <?php if($list_wed_open == '9:00 am'){ ?> selected="selected"<?php } ?>>9:00 am </option>
										<option value="9:30 am " <?php if($list_wed_open == '9:30 am'){ ?> selected="selected"<?php } ?>>9:30 am </option>
										<option value="10:00 am " <?php if($list_wed_open == '10:00 am'){ ?> selected="selected"<?php } ?>>10:00 am </option>
										<option value="10:30 am " <?php if($list_wed_open == '10:30 am'){ ?> selected="selected"<?php } ?>>10:30 am </option>
										<option value="11:00 am " <?php if($list_wed_open == '11:00 am'){ ?> selected="selected"<?php } ?>>11:00 am </option>			
										<option value="11:30 am " <?php if($list_wed_open == '11:30 am'){ ?> selected="selected"<?php } ?>>11:30 am </option>
										<option value="12:00 pm (noon)" <?php if($list_wed_open == '12:00 pm'){ ?> selected="selected"<?php } ?>>12:00 pm (noon)</option>
										<option value="12:30 pm " <?php if($list_wed_open == '12:30 pm'){ ?> selected="selected"<?php } ?>>12:30 pm </option>
										<option value="1:00 pm " <?php if($list_wed_open == '1:00 pm'){ ?> selected="selected"<?php } ?>>1:00 pm </option>
										<option value="1:30 pm " <?php if($list_wed_open == '1:30 pm'){ ?> selected="selected"<?php } ?>>1:30 pm </option>
										<option value="2:00 pm " <?php if($list_wed_open == '2:00 pm'){ ?> selected="selected"<?php } ?>>2:00 pm </option>			
										<option value="2:30 pm " <?php if($list_wed_open == '2:30 pm'){ ?> selected="selected"<?php } ?>>2:30 pm </option>
										<option value="3:00 pm " <?php if($list_wed_open == '3:00 pm'){ ?> selected="selected"<?php } ?>>3:00 pm </option>
										<option value="3:30 pm " <?php if($list_wed_open == '3:30 pm'){ ?> selected="selected"<?php } ?>>3:30 pm </option>
										<option value="4:00 pm " <?php if($list_wed_open == '4:00 pm'){ ?> selected="selected"<?php } ?>>4:00 pm </option>
										<option value="4:30 pm " <?php if($list_wed_open == '4:30 pm'){ ?> selected="selected"<?php } ?>>4:30 pm </option>
										<option value="5:00 pm " <?php if($list_wed_open == '5:00 pm'){ ?> selected="selected"<?php } ?>>5:00 pm </option>
										<option value="6:00 pm " <?php if($list_wed_open == '6:00 pm'){ ?> selected="selected"<?php } ?>>6:00 pm </option>
								</select>
								<select class="hours-end required-entry"  name="business_hours[hours-end][]" title="End Hours">		
																		<option value="" >Closed</option>
										<option value="9:00 am " <?php if($list_wed_close == '9:00 am'){ ?> selected="selected"<?php } ?>>9:00 am </option>
										<option value="9:30 am " <?php if($list_wed_close == '9:30 am'){ ?> selected="selected"<?php } ?>>9:30 am </option>
										<option value="10:00 am " <?php if($list_wed_close == '10:00 am'){ ?> selected="selected"<?php } ?>>10:00 am </option>
										<option value="10:30 am " <?php if($list_wed_close == '10:30 am'){ ?> selected="selected"<?php } ?>>10:30 am </option>
										<option value="11:00 am " <?php if($list_wed_close == '11:00 am'){ ?> selected="selected"<?php } ?>>11:00 am </option>			
										<option value="11:30 am " <?php if($list_wed_close == '11:30 am'){ ?> selected="selected"<?php } ?>>11:30 am </option>
										<option value="12:00 pm (noon)" <?php if($list_wed_close == '12:00 pm'){ ?> selected="selected"<?php } ?>>12:00 pm (noon)</option>
										<option value="12:30 pm " <?php if($list_wed_close == '12:30 pm'){ ?> selected="selected"<?php } ?>>12:30 pm </option>
										<option value="1:00 pm " <?php if($list_wed_close == '1:00 pm'){ ?> selected="selected"<?php } ?>>1:00 pm </option>
										<option value="1:30 pm " <?php if($list_wed_close == '1:30 pm'){ ?> selected="selected"<?php } ?>>1:30 pm </option>
										<option value="2:00 pm " <?php if($list_wed_close == '2:00 pm'){ ?> selected="selected"<?php } ?>>2:00 pm </option>			
										<option value="2:30 pm " <?php if($list_wed_close == '2:30 pm'){ ?> selected="selected"<?php } ?>>2:30 pm </option>
										<option value="3:00 pm " <?php if($list_wed_close == '3:00 pm'){ ?> selected="selected"<?php } ?>>3:00 pm </option>
										<option value="3:30 pm " <?php if($list_wed_close == '3:30 pm'){ ?> selected="selected"<?php } ?>>3:30 pm </option>
										<option value="4:00 pm " <?php if($list_wed_close == '4:00 pm'){ ?> selected="selected"<?php } ?>>4:00 pm </option>
										<option value="4:30 pm " <?php if($list_wed_close == '4:30 pm'){ ?> selected="selected"<?php } ?>>4:30 pm </option>
										<option value="5:00 pm " <?php if($list_wed_close == '5:00 pm'){ ?> selected="selected"<?php } ?>>5:00 pm </option>
										<option value="6:00 pm " <?php if($list_wen_close == '6:00 pm'){ ?> selected="selected"<?php } ?>>6:00 pm </option>
								</select>
							<?php } ?>
							 <?php if($list_thur_open && $list_thur_close){  ?>
							 <br />
							 <br />
								<select class="weekday required-entry" name="business_hours[weekday][]" title="WeekDay">
										<option value="0" >Mon</option>
										<option value="1">Tue</option>
										<option value="2">Wed</option>
										<option value="3" selected="selected">Thu</option>
										<option value="4">Fri</option>
										<option value="5">Sat</option>
										<option value="6">Sun</option>
								</select>
								<select class="hours-start required-entry"  name="business_hours[hours-start][]" title="Start Hours">		
										<option value="9:00 am " <?php if($list_thur_open == '9:00 am'){ ?> selected="selected"<?php } ?>>9:00 am </option>
										<option value="9:30 am " <?php if($list_thur_open == '9:30 am'){ ?> selected="selected"<?php } ?>>9:30 am </option>
										<option value="10:00 am " <?php if($list_thur_open == '10:00 am'){ ?> selected="selected"<?php } ?>>10:00 am </option>
										<option value="10:30 am " <?php if($list_thur_open == '10:30 am'){ ?> selected="selected"<?php } ?>>10:30 am </option>
										<option value="11:00 am " <?php if($list_thur_open == '11:00 am'){ ?> selected="selected"<?php } ?>>11:00 am </option>			
										<option value="11:30 am " <?php if($list_thur_open == '11:30 am'){ ?> selected="selected"<?php } ?>>11:30 am </option>
										<option value="12:00 pm (noon)" <?php if($list_thur_open == '12:00 pm'){ ?> selected="selected"<?php } ?>>12:00 pm (noon)</option>
										<option value="12:30 pm " <?php if($list_thur_open == '12:30 pm'){ ?> selected="selected"<?php } ?>>12:30 pm </option>
										<option value="1:00 pm " <?php if($list_thur_open == '1:00 pm'){ ?> selected="selected"<?php } ?>>1:00 pm </option>
										<option value="1:30 pm " <?php if($list_thur_open == '1:30 pm'){ ?> selected="selected"<?php } ?>>1:30 pm </option>
										<option value="2:00 pm " <?php if($list_thur_open == '2:00 pm'){ ?> selected="selected"<?php } ?>>2:00 pm </option>			
										<option value="2:30 pm " <?php if($list_thur_open == '2:30 pm'){ ?> selected="selected"<?php } ?>>2:30 pm </option>
										<option value="3:00 pm " <?php if($list_thur_open == '3:00 pm'){ ?> selected="selected"<?php } ?>>3:00 pm </option>
										<option value="3:30 pm " <?php if($list_thur_open == '3:30 pm'){ ?> selected="selected"<?php } ?>>3:30 pm </option>
										<option value="4:00 pm " <?php if($list_thur_open == '4:00 pm'){ ?> selected="selected"<?php } ?>>4:00 pm </option>
										<option value="4:30 pm " <?php if($list_thur_open == '4:30 pm'){ ?> selected="selected"<?php } ?>>4:30 pm </option>
										<option value="5:00 pm " <?php if($list_thur_open == '5:00 pm'){ ?> selected="selected"<?php } ?>>5:00 pm </option>
										<option value="6:00 pm " <?php if($list_thur_opne == '6:00 pm'){ ?> selected="selected"<?php } ?>>6:00 pm </option>
								</select>
								<select class="hours-end required-entry"  name="business_hours[hours-end][]" title="End Hours">
																		<option value="" >Closed</option>
										<option value="9:00 am " <?php if($list_thur_close == '9:00 am'){ ?> selected="selected"<?php } ?>>9:00 am </option>
										<option value="9:30 am " <?php if($list_thur_close == '9:30 am'){ ?> selected="selected"<?php } ?>>9:30 am </option>
										<option value="10:00 am " <?php if($list_thur_close == '10:00 am'){ ?> selected="selected"<?php } ?>>10:00 am </option>
										<option value="10:30 am " <?php if($list_thur_close == '10:30 am'){ ?> selected="selected"<?php } ?>>10:30 am </option>
										<option value="11:00 am " <?php if($list_thur_close == '11:00 am'){ ?> selected="selected"<?php } ?>>11:00 am </option>			
										<option value="11:30 am " <?php if($list_thur_close == '11:30 am'){ ?> selected="selected"<?php } ?>>11:30 am </option>
										<option value="12:00 pm (noon)" <?php if($list_thur_close == '12:00 pm'){ ?> selected="selected"<?php } ?>>12:00 pm (noon)</option>
										<option value="12:30 pm " <?php if($list_thur_close == '12:30 pm'){ ?> selected="selected"<?php } ?>>12:30 pm </option>
										<option value="1:00 pm " <?php if($list_thur_close == '1:00 pm'){ ?> selected="selected"<?php } ?>>1:00 pm </option>
										<option value="1:30 pm " <?php if($list_thur_close == '1:30 pm'){ ?> selected="selected"<?php } ?>>1:30 pm </option>
										<option value="2:00 pm " <?php if($list_thur_close == '2:00 pm'){ ?> selected="selected"<?php } ?>>2:00 pm </option>			
										<option value="2:30 pm " <?php if($list_thur_close == '2:30 pm'){ ?> selected="selected"<?php } ?>>2:30 pm </option>
										<option value="3:00 pm " <?php if($list_thur_close == '3:00 pm'){ ?> selected="selected"<?php } ?>>3:00 pm </option>
										<option value="3:30 pm " <?php if($list_thur_close == '3:30 pm'){ ?> selected="selected"<?php } ?>>3:30 pm </option>
										<option value="4:00 pm " <?php if($list_thur_close == '4:00 pm'){ ?> selected="selected"<?php } ?>>4:00 pm </option>
										<option value="4:30 pm " <?php if($list_thur_close == '4:30 pm'){ ?> selected="selected"<?php } ?>>4:30 pm </option>
										<option value="5:00 pm " <?php if($list_thur_close == '5:00 pm'){ ?> selected="selected"<?php } ?>>5:00 pm </option>
										<option value="6:00 pm " <?php if($list_thur_close == '6:00 pm'){ ?> selected="selected"<?php } ?>>6:00 pm </option>
								</select>
							<?php } ?>
							 <?php if($list_fri_open && $list_fri_close){  ?>
							 <br />
							 <br />
								<select class="weekday required-entry" name="business_hours[weekday][]" title="WeekDay">
										<option value="0" selected="selected">Mon</option>
										<option value="1">Tue</option>
										<option value="2">Wed</option>
										<option value="3">Thu</option>
										<option value="4"  selected="selected">Fri</option>
										<option value="5">Sat</option>
										<option value="6">Sun</option>
								</select>
								<select class="hours-start required-entry"  name="business_hours[hours-start][]" title="Start Hours">
										<option value="9:00 am " <?php if($list_fri_open == '9:00 am'){ ?> selected="selected"<?php } ?>>9:00 am </option>
										<option value="9:30 am " <?php if($list_fri_open == '9:30 am'){ ?> selected="selected"<?php } ?>>9:30 am </option>
										<option value="10:00 am " <?php if($list_fri_open == '10:00 am'){ ?> selected="selected"<?php } ?>>10:00 am </option>
										<option value="10:30 am " <?php if($list_fri_open == '10:30 am'){ ?> selected="selected"<?php } ?>>10:30 am </option>
										<option value="11:00 am " <?php if($list_fri_open == '11:00 am'){ ?> selected="selected"<?php } ?>>11:00 am </option>			
										<option value="11:30 am " <?php if($list_fri_open == '11:30 am'){ ?> selected="selected"<?php } ?>>11:30 am </option>
										<option value="12:00 pm (noon)" <?php if($list_fri_open == '12:00 pm'){ ?> selected="selected"<?php } ?>>12:00 pm (noon)</option>
										<option value="12:30 pm " <?php if($list_fri_open == '12:30 pm'){ ?> selected="selected"<?php } ?>>12:30 pm </option>
										<option value="1:00 pm " <?php if($list_fri_open == '1:00 pm'){ ?> selected="selected"<?php } ?>>1:00 pm </option>
										<option value="1:30 pm " <?php if($list_fri_open == '1:30 pm'){ ?> selected="selected"<?php } ?>>1:30 pm </option>
										<option value="2:00 pm " <?php if($list_fri_open == '2:00 pm'){ ?> selected="selected"<?php } ?>>2:00 pm </option>			
										<option value="2:30 pm " <?php if($list_fri_open == '2:30 pm'){ ?> selected="selected"<?php } ?>>2:30 pm </option>
										<option value="3:00 pm " <?php if($list_fri_open == '3:00 pm'){ ?> selected="selected"<?php } ?>>3:00 pm </option>
										<option value="3:30 pm " <?php if($list_fri_open == '3:30 pm'){ ?> selected="selected"<?php } ?>>3:30 pm </option>
										<option value="4:00 pm " <?php if($list_fri_open == '4:00 pm'){ ?> selected="selected"<?php } ?>>4:00 pm </option>
										<option value="4:30 pm " <?php if($list_fri_open == '4:30 pm'){ ?> selected="selected"<?php } ?>>4:30 pm </option>
										<option value="5:00 pm " <?php if($list_fri_open == '5:00 pm'){ ?> selected="selected"<?php } ?>>5:00 pm </option>
										<option value="6:00 pm " <?php if($list_fri_open == '6:00 pm'){ ?> selected="selected"<?php } ?>>6:00 pm </option>
								</select>
								<select class="hours-end required-entry"  name="business_hours[hours-end][]" title="End Hours">
																		<option value="" >Closed</option>
										<option value="9:00 am " <?php if($list_fri_close == '9:00 am'){ ?> selected="selected"<?php } ?>>9:00 am </option>
										<option value="9:30 am " <?php if($list_fri_close == '9:30 am'){ ?> selected="selected"<?php } ?>>9:30 am </option>
										<option value="10:00 am " <?php if($list_fri_close == '10:00 am'){ ?> selected="selected"<?php } ?>>10:00 am </option>
										<option value="10:30 am " <?php if($list_fri_close == '10:30 am'){ ?> selected="selected"<?php } ?>>10:30 am </option>
										<option value="11:00 am " <?php if($list_fri_close == '11:00 am'){ ?> selected="selected"<?php } ?>>11:00 am </option>			
										<option value="11:30 am " <?php if($list_fri_close == '11:30 am'){ ?> selected="selected"<?php } ?>>11:30 am </option>
										<option value="12:00 pm (noon)" <?php if($list_fri_close == '12:00 pm'){ ?> selected="selected"<?php } ?>>12:00 pm (noon)</option>
										<option value="12:30 pm " <?php if($list_fri_close == '12:30 pm'){ ?> selected="selected"<?php } ?>>12:30 pm </option>
										<option value="1:00 pm " <?php if($list_fri_close == '1:00 pm'){ ?> selected="selected"<?php } ?>>1:00 pm </option>
										<option value="1:30 pm " <?php if($list_fri_close == '1:30 pm'){ ?> selected="selected"<?php } ?>>1:30 pm </option>
										<option value="2:00 pm " <?php if($list_fri_close == '2:00 pm'){ ?> selected="selected"<?php } ?>>2:00 pm </option>			
										<option value="2:30 pm " <?php if($list_fri_close == '2:30 pm'){ ?> selected="selected"<?php } ?>>2:30 pm </option>
										<option value="3:00 pm " <?php if($list_fri_close == '3:00 pm'){ ?> selected="selected"<?php } ?>>3:00 pm </option>
										<option value="3:30 pm " <?php if($list_fri_close == '3:30 pm'){ ?> selected="selected"<?php } ?>>3:30 pm </option>
										<option value="4:00 pm " <?php if($list_fri_close == '4:00 pm'){ ?> selected="selected"<?php } ?>>4:00 pm </option>
										<option value="4:30 pm " <?php if($list_fri_close == '4:30 pm'){ ?> selected="selected"<?php } ?>>4:30 pm </option>
										<option value="5:00 pm " <?php if($list_fri_close == '5:00 pm'){ ?> selected="selected"<?php } ?>>5:00 pm </option>
										<option value="6:00 pm " <?php if($list_fri_close == '6:00 pm'){ ?> selected="selected"<?php } ?>>6:00 pm </option>
								</select>
							<?php } ?>
							 <?php if($list_sat_open && $list_sat_close){  ?>
							 <br />
							 <br />
								<select class="weekday required-entry" name="business_hours[weekday][]" title="WeekDay">
										<option value="0" selected="selected">Mon</option>
										<option value="1">Tue</option>
										<option value="2">Wed</option>
										<option value="3">Thu</option>
										<option value="4">Fri</option>
										<option value="5"  selected="selected">Sat</option>
										<option value="6">Sun</option>
								</select>
								<select class="hours-start required-entry"  name="business_hours[hours-start][]" title="Start Hours">
										<option value="9:00 am " <?php if($list_sat_open == '9:00 am'){ ?> selected="selected"<?php } ?>>9:00 am </option>
										<option value="9:30 am " <?php if($list_sat_open == '9:30 am'){ ?> selected="selected"<?php } ?>>9:30 am </option>
										<option value="10:00 am " <?php if($list_sat_open == '10:00 am'){ ?> selected="selected"<?php } ?>>10:00 am </option>
										<option value="10:30 am " <?php if($list_sat_open == '10:30 am'){ ?> selected="selected"<?php } ?>>10:30 am </option>
										<option value="11:00 am " <?php if($list_sat_open == '11:00 am'){ ?> selected="selected"<?php } ?>>11:00 am </option>			
										<option value="11:30 am " <?php if($list_sat_open == '11:30 am'){ ?> selected="selected"<?php } ?>>11:30 am </option>
										<option value="12:00 pm (noon)" <?php if($list_sat_open == '12:00 pm'){ ?> selected="selected"<?php } ?>>12:00 pm (noon)</option>
										<option value="12:30 pm " <?php if($list_sat_open == '12:30 pm'){ ?> selected="selected"<?php } ?>>12:30 pm </option>
										<option value="1:00 pm " <?php if($list_sat_open == '1:00 pm'){ ?> selected="selected"<?php } ?>>1:00 pm </option>
										<option value="1:30 pm " <?php if($list_sat_open == '1:30 pm'){ ?> selected="selected"<?php } ?>>1:30 pm </option>
										<option value="2:00 pm " <?php if($list_sat_open == '2:00 pm'){ ?> selected="selected"<?php } ?>>2:00 pm </option>			
										<option value="2:30 pm " <?php if($list_sat_open == '2:30 pm'){ ?> selected="selected"<?php } ?>>2:30 pm </option>
										<option value="3:00 pm " <?php if($list_sat_open == '3:00 pm'){ ?> selected="selected"<?php } ?>>3:00 pm </option>
										<option value="3:30 pm " <?php if($list_sat_open == '3:30 pm'){ ?> selected="selected"<?php } ?>>3:30 pm </option>
										<option value="4:00 pm " <?php if($list_sat_open == '4:00 pm'){ ?> selected="selected"<?php } ?>>4:00 pm </option>
										<option value="4:30 pm " <?php if($list_sat_open == '4:30 pm'){ ?> selected="selected"<?php } ?>>4:30 pm </option>
										<option value="5:00 pm " <?php if($list_sat_open == '5:00 pm'){ ?> selected="selected"<?php } ?>>5:00 pm </option>
										<option value="6:00 pm " <?php if($list_sat_open == '6:00 pm'){ ?> selected="selected"<?php } ?>>6:00 pm </option>
								</select>
								<select class="hours-end required-entry"  name="business_hours[hours-end][]" title="End Hours">
																		<option value="" >Closed</option>
										<option value="9:00 am " <?php if($list_sat_close == '9:00 am'){ ?> selected="selected"<?php } ?>>9:00 am </option>
										<option value="9:30 am " <?php if($list_sat_close == '9:30 am'){ ?> selected="selected"<?php } ?>>9:30 am </option>
										<option value="10:00 am " <?php if($list_sat_close == '10:00 am'){ ?> selected="selected"<?php } ?>>10:00 am </option>
										<option value="10:30 am " <?php if($list_sat_close == '10:30 am'){ ?> selected="selected"<?php } ?>>10:30 am </option>
										<option value="11:00 am " <?php if($list_sat_close == '11:00 am'){ ?> selected="selected"<?php } ?>>11:00 am </option>			
										<option value="11:30 am " <?php if($list_sat_close == '11:30 am'){ ?> selected="selected"<?php } ?>>11:30 am </option>
										<option value="12:00 pm (noon)" <?php if($list_sat_close == '12:00 pm'){ ?> selected="selected"<?php } ?>>12:00 pm (noon)</option>
										<option value="12:30 pm " <?php if($list_sat_close == '12:30 pm'){ ?> selected="selected"<?php } ?>>12:30 pm </option>
										<option value="1:00 pm " <?php if($list_sat_close == '1:00 pm'){ ?> selected="selected"<?php } ?>>1:00 pm </option>
										<option value="1:30 pm " <?php if($list_sat_close == '1:30 pm'){ ?> selected="selected"<?php } ?>>1:30 pm </option>
										<option value="2:00 pm " <?php if($list_sat_close == '2:00 pm'){ ?> selected="selected"<?php } ?>>2:00 pm </option>			
										<option value="2:30 pm " <?php if($list_sat_close == '2:30 pm'){ ?> selected="selected"<?php } ?>>2:30 pm </option>
										<option value="3:00 pm " <?php if($list_sat_close == '3:00 pm'){ ?> selected="selected"<?php } ?>>3:00 pm </option>
										<option value="3:30 pm " <?php if($list_sat_close == '3:30 pm'){ ?> selected="selected"<?php } ?>>3:30 pm </option>
										<option value="4:00 pm " <?php if($list_sat_close == '4:00 pm'){ ?> selected="selected"<?php } ?>>4:00 pm </option>
										<option value="4:30 pm " <?php if($list_sat_close == '4:30 pm'){ ?> selected="selected"<?php } ?>>4:30 pm </option>
										<option value="5:00 pm " <?php if($list_sat_close == '5:00 pm'){ ?> selected="selected"<?php } ?>>5:00 pm </option>
										<option value="6:00 pm " <?php if($list_sat_close == '6:00 pm'){ ?> selected="selected"<?php } ?>>6:00 pm </option>
								</select>
							<?php } ?>
							 <?php if($list_sun_open && $list_sun_close){  ?>
							 <br />
							 <br />
								<select class="weekday required-entry" name="business_hours[weekday][]" title="WeekDay">
										<option value="0" selected="selected">Mon</option>
										<option value="1">Tue</option>
										<option value="2">Wed</option>
										<option value="3">Thu</option>
										<option value="4">Fri</option>
										<option value="5">Sat</option>
										<option value="6"  selected="selected">Sun</option>
								</select>
									<select class="hours-start required-entry"  name="business_hours[hours-start][]" title="Start Hours">
										<option value="9:00 am " <?php if($list_sun_open == '9:00 am'){ ?> selected="selected"<?php } ?>>9:00 am </option>
										<option value="9:30 am " <?php if($list_sun_open == '9:30 am'){ ?> selected="selected"<?php } ?>>9:30 am </option>
										<option value="10:00 am " <?php if($list_sun_open == '10:00 am'){ ?> selected="selected"<?php } ?>>10:00 am </option>
										<option value="10:30 am " <?php if($list_sun_open == '10:30 am'){ ?> selected="selected"<?php } ?>>10:30 am </option>
										<option value="11:00 am " <?php if($list_sun_open == '11:00 am'){ ?> selected="selected"<?php } ?>>11:00 am </option>			
										<option value="11:30 am " <?php if($list_sun_open == '11:30 am'){ ?> selected="selected"<?php } ?>>11:30 am </option>
										<option value="12:00 pm (noon)" <?php if($list_sun_open == '12:00 pm'){ ?> selected="selected"<?php } ?>>12:00 pm (noon)</option>
										<option value="12:30 pm " <?php if($list_sun_open == '12:30 pm'){ ?> selected="selected"<?php } ?>>12:30 pm </option>
										<option value="1:00 pm " <?php if($list_sun_open == '1:00 pm'){ ?> selected="selected"<?php } ?>>1:00 pm </option>
										<option value="1:30 pm " <?php if($list_sun_open == '1:30 pm'){ ?> selected="selected"<?php } ?>>1:30 pm </option>
										<option value="2:00 pm " <?php if($list_sun_open == '2:00 pm'){ ?> selected="selected"<?php } ?>>2:00 pm </option>			
										<option value="2:30 pm " <?php if($list_sun_open == '2:30 pm'){ ?> selected="selected"<?php } ?>>2:30 pm </option>
										<option value="3:00 pm " <?php if($list_sun_open == '3:00 pm'){ ?> selected="selected"<?php } ?>>3:00 pm </option>
										<option value="3:30 pm " <?php if($list_sun_open == '3:30 pm'){ ?> selected="selected"<?php } ?>>3:30 pm </option>
										<option value="4:00 pm " <?php if($list_sun_open == '4:00 pm'){ ?> selected="selected"<?php } ?>>4:00 pm </option>
										<option value="4:30 pm " <?php if($list_sun_open == '4:30 pm'){ ?> selected="selected"<?php } ?>>4:30 pm </option>
										<option value="5:00 pm " <?php if($list_sun_open == '5:00 pm'){ ?> selected="selected"<?php } ?>>5:00 pm </option>
										<option value="6:00 pm " <?php if($list_sun_open == '6:00 pm'){ ?> selected="selected"<?php } ?>>6:00 pm </option>
								</select>
								<select class="hours-end required-entry"  name="business_hours[hours-end][]" title="End Hours">
																		<option value="" >Closed</option>
										<option value="9:00 am " <?php if($list_sun_close == '9:00 am'){ ?> selected="selected"<?php } ?>>9:00 am </option>
										<option value="9:30 am " <?php if($list_sun_close == '9:30 am'){ ?> selected="selected"<?php } ?>>9:30 am </option>
										<option value="10:00 am " <?php if($list_sun_close == '10:00 am'){ ?> selected="selected"<?php } ?>>10:00 am </option>
										<option value="10:30 am " <?php if($list_sun_close == '10:30 am'){ ?> selected="selected"<?php } ?>>10:30 am </option>
										<option value="11:00 am " <?php if($list_sun_close == '11:00 am'){ ?> selected="selected"<?php } ?>>11:00 am </option>			
										<option value="11:30 am " <?php if($list_sun_close == '11:30 am'){ ?> selected="selected"<?php } ?>>11:30 am </option>
										<option value="12:00 pm (noon)" <?php if($list_sun_close == '12:00 pm'){ ?> selected="selected"<?php } ?>>12:00 pm (noon)</option>
										<option value="12:30 pm " <?php if($list_sun_close == '12:30 pm'){ ?> selected="selected"<?php } ?>>12:30 pm </option>
										<option value="1:00 pm " <?php if($list_sun_close == '1:00 pm'){ ?> selected="selected"<?php } ?>>1:00 pm </option>
										<option value="1:30 pm " <?php if($list_sun_close == '1:30 pm'){ ?> selected="selected"<?php } ?>>1:30 pm </option>
										<option value="2:00 pm " <?php if($list_sun_close == '2:00 pm'){ ?> selected="selected"<?php } ?>>2:00 pm </option>			
										<option value="2:30 pm " <?php if($list_sun_close == '2:30 pm'){ ?> selected="selected"<?php } ?>>2:30 pm </option>
										<option value="3:00 pm " <?php if($list_sun_close == '3:00 pm'){ ?> selected="selected"<?php } ?>>3:00 pm </option>
										<option value="3:30 pm " <?php if($list_sun_close == '3:30 pm'){ ?> selected="selected"<?php } ?>>3:30 pm </option>
										<option value="4:00 pm " <?php if($list_sun_close == '4:00 pm'){ ?> selected="selected"<?php } ?>>4:00 pm </option>
										<option value="4:30 pm " <?php if($list_sun_close == '4:30 pm'){ ?> selected="selected"<?php } ?>>4:30 pm </option>
										<option value="5:00 pm " <?php if($list_sun_close == '5:00 pm'){ ?> selected="selected"<?php } ?>>5:00 pm </option>
										<option value="6:00 pm " <?php if($list_sun_close == '6:00 pm'){ ?> selected="selected"<?php } ?>>6:00 pm </option>
								</select>
							<?php } ?>
							
						</div>
						 <br />
						 <br />
						<button type="button " value="submit" class="ybtn ybtn-small add-hours ytype"><span>Add Hours</span></button>
					</div>
					<div class="row buttons "><a href="#"  class="button-next" onclick="nextStep('step1','step2')"><img src="images/steps/next.jpg" /></a></div>
				</div>
				<div class="add_new_business_hrs" style="display:none;">
					<select class="weekday required-entry" name="business_hours[weekday][99999]" title="WeekDay">
							<option value="0">Mon</option>
							<option value="1">Tue</option>
							<option value="2">Wed</option>
							<option value="3">Thu</option>
							<option value="4">Fri</option>
							<option value="5">Sat</option>
							<option value="6">Sun</option>
					</select>
					<select class="hours-start required-entry"  name="business_hours[hours-start][99999]" title="Start Hours">
							<option value="5:00 am ">5:00 am </option>
							<option value="5:30 am ">5:30 am </option>
							<option value="6:00 am ">6:00 am </option>
							<option value="6:30 am ">6:30 am </option>
							<option value="7:00 am ">7:00 am </option>				
							<option value="7:30 am ">7:30 am </option>
							<option value="8:00 am ">8:00 am </option>
							<option value="8:30 am ">8:30 am </option>				
							<option value="9:00 am " selected="">9:00 am </option>
							<option value="9:30 am ">9:30 am </option>
							<option value="10:00 am ">10:00 am </option>
							<option value="10:30 am ">10:30 am </option>
							<option value="11:00 am ">11:00 am </option>			
							<option value="11:30 am ">11:30 am </option>
							<option value="12:00 pm (noon)">12:00 pm (noon)</option>
							<option value="12:30 pm ">12:30 pm </option>
							<option value="1:00 pm ">1:00 pm </option>
							<option value="1:30 pm ">1:30 pm </option>
							<option value="2:00 pm ">2:00 pm </option>			
							<option value="2:30 pm ">2:30 pm </option>
							<option value="3:00 pm ">3:00 pm </option>
							<option value="3:30 pm ">3:30 pm </option>
							<option value="4:00 pm ">4:00 pm </option>
							<option value="4:30 pm ">4:30 pm </option>
							<option value="5:00 pm ">5:00 pm </option>
							<option value="5:30 pm ">5:30 pm </option>
							<option value="6:00 pm ">6:00 pm </option>
					</select>
					<select class="hours-end required-entry"  name="business_hours[hours-end][99999]" title="End Hours">
							<option value="0" selected="" >Closed</option>
							<option value="9:00 am " >9:00 am </option>
							<option value="9:30 am ">9:30 am </option>
							<option value="10:00 am ">10:00 am </option>
							<option value="10:30 am ">10:30 am </option>
							<option value="11:00 am ">11:00 am </option>			
							<option value="11:30 am ">11:30 am </option>
							<option value="12:00 pm (noon)">12:00 pm (noon)</option>
							<option value="12:30 pm ">12:30 pm </option>
							<option value="1:00 pm ">1:00 pm </option>
							<option value="1:30 pm ">1:30 pm </option>
							<option value="2:00 pm ">2:00 pm </option>			
							<option value="2:30 pm ">2:30 pm </option>
							<option value="3:00 pm ">3:00 pm </option>
							<option value="3:30 pm ">3:30 pm </option>
							<option value="4:00 pm ">4:00 pm </option>
							<option value="4:30 pm ">4:30 pm </option>
							<option value="5:00 pm ">5:00 pm </option>
							<option value="5:30 pm ">5:30 pm </option>
							<option value="6:00 pm ">6:00 pm </option>
					</select>
				</div>
			</form>
		</div>
        <!--End Step1-->   
		
	<!--start Step2-->       
		<div class="step2 steps"  id="step2" style="display:none">
			<form action="#" method="get" name="step2-form" id="step2-form">
			<!--Contact Info-->
				<div class="row">
					<!--legend>Contact Info</legend-->
				 <textarea name="popupdesc" ><?php echo $list_desc ?></textarea>
                <p>Description</p>
				<input  type="radio" name="storerfeatured" value="0" checked="checked" /> NO
				<input  type="radio" name="storerfeatured" value="1" " <?php if( $storerfeatured == 1 ){ ?>  checked="checked" <?php } ?>" /> Yes
				

                <p>Select stored will be featured </p>

					<input name="" type="text" placeholder="phone" value="<?php  echo $list_phone; ?>"/>
					<img src="images/steps/phone-ico.jpg" /><p>Phone Number</p>
					<input type="text" placeholder="" name="mobile_number" value="<?php  echo $list_mobile; ?>"/>
					<img src="images/steps/mobile-ico.jpg" /><p>Mobile Number</p>
					<input name="fax" type="text" placeholder="" value="<?php  echo $list_fax; ?>"/>
					<img src="images/steps/fax-ico.jpg" /><p>Fax Number</p>
					<!--input name="" type="text" placeholder=""/>
					<img src="images/steps/email-ico.jpg" /><p>E-mail</p-->
					<input name="list_website" type="text" placeholder="http://" value="<?php  echo $list_website; ?>"/>
					<img src="images/steps/website-ico.jpg" /><p>Website</p>
				</div>
			<!--End Contact Info-->
			
			<!--Social Accounts-->
				<div class="row">
				 <div class="row contact">
					<legend>Social Accounts</legend>
					<input name="list_twitter" type="text" placeholder="@username" value="<?php  echo $list_twitter; ?>"/>
					<img src="images/steps/twit.jpg" /><p>Twitter</p>
					<input name="list_facebook" type="text" placeholder="http://" value="<?php  echo $list_facebook; ?>"/>
					<img src="images/steps/fb.jpg" /><p>Facebook URL</p>
					<input name="list_google" type="text" placeholder="http://" value="<?php  echo $list_google; ?>"/>
					<img src="images/steps/google+.jpg" /><p>Google+ URL</p>
				</div>
				</div>
			</form>
			<div class="row buttons"><a href="#" class="button-next"  onclick="nextStep('step2','step3')"><img src="images/steps/next.jpg" /></a></div>
			<!--End Social Accounts-->
	</div>
	<div class="step3 steps"  id="step3" style="display:none">
		<!--start Step2-->   
		
			<!--Photos-->
		  <div class="row photos">
			<legend>Photos</legend>
			 <div id="mulitplefileuploader">Upload</div>
			 <div id="status"></div>
			</div>
			<div class="row buttons"><a href="#" class="button-next"  onclick="nextStep('step3','step4')"><img src="images/steps/next.jpg" /></a></div>
		</div>
	 <div class="step4 steps"  id="step4" style="display:none">
		  <div class="row final_steps">
		  	<label>Your lisitng has been add sucessfully . We will conact you soon..!</label><br />
		  	<label>if you have any questions ,please email at <a href="email:info@petdaddy.com" >info@petdaddy.com</a></label>
		</div>
		<div class="row buttons"><div><a href="index.php?provider=home" class="button_finish">Finish</a></div>
	</div>
</div>
  <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true&libraries=places"></script>

	<script type="text/javascript">
	 function nextStep(old_step,new_step){
	 	var form = 	jQuery('#'+old_step+'-form');
		var form_data = form.serialize();
		var is_validate = true;
		
		jQuery('#'+old_step + ' .required-entry').each(function(){
			if(jQuery(this).val() == ''){
				alert(jQuery(this).attr('title') + ' field must be fill')
				is_validate = false;
			}
		});
		
		if(old_step == 'step3'){
			jQuery('#'+old_step).hide();
	 		jQuery('#'+new_step).show();
			jQuery('.smpl-step-'+old_step+',.smpl-step-step4').addClass('complete');
			return true;
		}
		
		if(is_validate){
			jQuery.ajax({
				url: "index.php?provider=add_listing&lang=<?php echo $_GET['lang'] ?>&step="+old_step,
				type: "POST",
				data: form_data,
				success : function(result){
					if(result == '1'){
						jQuery('#'+old_step).hide();
				 		jQuery('#'+new_step).show();
						jQuery('.smpl-step-'+old_step).addClass('complete');
					}
				}
				
			});
		 	
		}
	 }
	 
	 	   function initialize() {
  var mapOptions = {
    center: new google.maps.LatLng(-33.8688, 151.2195),
    zoom: 13
  };
  var map = new google.maps.Map(document.getElementById('map'),
    mapOptions);

  var input = /** @type {HTMLInputElement} */(
      document.getElementById('address'));

//  var types = document.getElementById('type-selector');
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
 // map.controls[google.maps.ControlPosition.TOP_LEFT].push(types);

  var autocomplete = new google.maps.places.Autocomplete(input);
  autocomplete.bindTo('bounds', map);

  var infowindow = new google.maps.InfoWindow();
  var marker = new google.maps.Marker({
    map: map,
    anchorPoint: new google.maps.Point(0, -29)
  });

  google.maps.event.addListener(autocomplete, 'place_changed', function() {
    infowindow.close();
    marker.setVisible(false);
    var place = autocomplete.getPlace();
    if (!place.geometry) {
      return;
    }

    // If the place has a geometry, then present it on a map.
    if (place.geometry.viewport) {
      map.fitBounds(place.geometry.viewport);
    } else {
      map.setCenter(place.geometry.location);
      map.setZoom(17);  // Why 17? Because it looks good.
    }
    marker.setIcon(/** @type {google.maps.Icon} */({
      url: place.icon,
      size: new google.maps.Size(71, 71),
      origin: new google.maps.Point(0, 0),
      anchor: new google.maps.Point(17, 34),
      scaledSize: new google.maps.Size(35, 35)
    }));
    marker.setPosition(place.geometry.location);
    marker.setVisible(true);

    var address = '';
    if (place.address_components) {
      address = [
        (place.address_components[0] && place.address_components[0].short_name || ''),
        (place.address_components[1] && place.address_components[1].short_name || ''),
        (place.address_components[2] && place.address_components[2].short_name || '')
      ].join(' ');
    }

    infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
    infowindow.open(map, marker);
  });

  // Sets a listener on a radio button to change the filter type on Places
  // Autocomplete.
 /* function setupClickListener(id, types) {
    var radioButton = document.getElementById(id);
    google.maps.event.addDomListener(radioButton, 'click', function() {
      autocomplete.setTypes(types);
    });
  }*/

  setupClickListener('changetype-all', []);
  setupClickListener('changetype-address', ['address']);
  setupClickListener('changetype-establishment', ['establishment']);
  setupClickListener('changetype-geocode', ['geocode']);
}



google.maps.event.addDomListener(window, 'load', initialize);

	   jQuery(document).ready(function() {
	   
	   

	   
	   		/*var map = $("#map");
				var latlng = new google.maps.LatLng(38, -97);
			    var placepicker =  jQuery(".placepicker").placepicker({
			   		map : map,
					mapOptions: { zoom: 17 ,center: latlng }, 
			    }).data('placepicker');
	*/		   
		/*		jQuery('.fancybox').fancybox({
					helpers:  {
						title:  null
					},
				}).trigger('click'); 
		*/
				
				var max_fields      = 7; //maximum input boxes allowed
				var wrapper         = $(".business_hours"); //Fields wrapper
				var add_button      = $(".add-hours"); //Add button ID
				
				var x = 1; //initlal text box count
				$(add_button).click(function(e){ //on add input button click
					e.preventDefault();
					if(x < max_fields){ //max input box allowed
						x++; //text box increment
						$(wrapper).append('<div class="add_new_hrs">'+$('.add_new_business_hrs').html().replace(/99999/g,'',"")+'<a href="#" class="remove_field">Remove</a></div>'); //add input box
					}
				});
				
				$(wrapper).on("click",".remove_field", function(e){ //user click on remove text
					e.preventDefault(); $(this).parent('div').remove(); x--;
				});
				
			// start code for the upload multiple images 	
				var settings = {
					url: "index.php?provider=upload",
					method: "POST",
					allowedTypes:"jpg,png,gif,doc,pdf,zip",
					fileName: "myfile",
					multiple: true,
					onSuccess:function(files,data,xhr)
					{
						$("#status").html("<font color='green'>Upload is success</font>");
						},
						afterUploadAll:function()
						{
								alert("all images uploaded!!");
						},
					onError: function(files,status,errMsg)
					{		
						$("#status").html("<font color='red'>Upload is Failed</font>");
					}
				}
				$("#mulitplefileuploader").uploadFile(settings);

				//end code for the upload multiple images 	
				
				$(function() {
					// Replace all textarea's
					// with SCEditor
					$("textarea").sceditor({
						plugins: "bbcode",
						style : "/assets/frontend/layout/css/sceditor/jquery.sceditor.default.min.css",
					});
				});
			
	   });
	

	</script>