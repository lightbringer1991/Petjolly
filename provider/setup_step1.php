<?php
	$hours = array ('Closed', '6:00 AM', '6:30 AM', '7:00 AM', '7:30 AM', '8:00 AM', '8:30 AM', '9:00 AM',
					'9:30 AM', '10:00 AM', '10:30 AM', '11:00 AM', '11:30 AM', '12:00 PM', '12:30 PM', '1:00 PM',
					'1:30 PM', '2:00 PM', '2:30 PM', '3:00 PM', '3:30 PM', '4:00 PM', '4:30 PM', '5:00 PM',
					'6:00 PM', '6:30 PM', '7:00 PM', '7:30 PM', '8:00 PM', '8:30 PM', '9:00 PM', '10:00 PM',
					'10:30 PM', '11:00 PM');
	$hourOptions = "";
	foreach ($hours as $h) {
		$hourOptions .= "<option value='$h'>$h</option>";
	}
	
?>

<div id="setup_step1" class="steps">
	<form action="#" method="POST" id="form-setupAddress">
		<fieldset style="padding:5px;margin-left:5px;margin-right:10px;">
			<legend>Business</legend>
			<table class="mgrid_table" width="100%" cellspacing="0" cellpadding="2" border="0">
				<tbody>
					<tr>
						<td width="25%" align="left" style="border-right: 0px dotted rgb(204, 204, 204);">
							<label for="business_name">Business Name</label>
							<span class="required">*</span>
							:
						</td>
						<td style="text-align:left;padding-left:6px;">
							<input name="business_name" class="mgrid_text" dir="ltr" maxlength="70" value="<?php echo $doctorInfo[0]['business_name']; ?>" style="width:210px;">
						</td>
					</tr>
					<tr>
						<td width="25%" align="left" style="border-right: 0px dotted rgb(204, 204, 204);">
							<label for="description">Description</label>
							<span class="required">*</span>
							:
						</td>
						<td style="text-align:left;padding-left:6px;">
							<textarea name="description" class="mgrid_text" style="width:210px;"><?php echo $doctorInfo[0]['popupdesc']; ?></textarea>
						</td>
					</tr>
				</tbody>
			</table>
		</fieldset>
		
		<fieldset style="padding:5px;margin-left:5px;margin-right:10px;">
			<legend>Address</legend>
			<table class="mgrid_table" width="100%" cellspacing="0" cellpadding="2" border="0">
				<tbody>
					<tr>
						<td width="25%" align="left" style="border-right: 0px dotted rgb(204, 204, 204);">
							<label for="address">Address</label>
							<span class="required">*</span>
							:
						</td>
						<td style="text-align:left;padding-left:6px;">
							<input name="address" class="mgrid_text" dir="ltr" maxlength="70" value="<?php echo $doctorInfo[0]['b_address'] . " " . $doctorInfo[0]['b_address_2']; ?>" style="width:210px;" data-address='' data-validated=''>
							<input type="hidden" name="latitude" value="" />
							<input type="hidden" name="longitude" value="" />
						</td>
					</tr>
					<tr>
						<td width="25%" align="left" style="border-right: 0px dotted rgb(204, 204, 204);">
							<label for="address">City</label>
							<span class="required">*</span>
							:
						</td>
						<td style="text-align:left;padding-left:6px;">
							<input name="city" class="mgrid_text" dir="ltr" maxlength="70" value="<?php echo $doctorInfo[0]['b_city']; ?>" style="width:210px;">
						</td>
					</tr>
					<tr>
						<td width="25%" align="left" style="border-right: 0px dotted rgb(204, 204, 204);">
							<label for="address">State</label>
							<span class="required">*</span>
							:
						</td>
						<td style="text-align:left; padding-left:6px;" >
							<select name="state" style="width:210px;">
								<option value="AL">Alabama</option>
								<option value="AK">Alaska</option>
								<option value="AZ">Arizona</option>
								<option value="AR">Arkansas</option>
								<option value="CA">California</option>
								<option value="CO">Colorado</option>
								<option value="CT">Connecticut</option>
								<option value="DE">Delaware</option>
								<option value="DC">District Of Columbia</option>
								<option value="FL">Florida</option>
								<option value="GA">Georgia</option>
								<option value="HI">Hawaii</option>
								<option value="ID">Idaho</option>
								<option value="IL">Illinois</option>
								<option value="IN">Indiana</option>
								<option value="IA">Iowa</option>
								<option value="KS">Kansas</option>
								<option value="KY">Kentucky</option>
								<option value="LA">Louisiana</option>
								<option value="ME">Maine</option>
								<option value="MD">Maryland</option>
								<option value="MA">Massachusetts</option>
								<option value="MI">Michigan</option>
								<option value="MN">Minnesota</option>
								<option value="MS">Mississippi</option>
								<option value="MO">Missouri</option>
								<option value="MT">Montana</option>
								<option value="NE">Nebraska</option>
								<option value="NV">Nevada</option>
								<option value="NH">New Hampshire</option>
								<option value="NJ">New Jersey</option>
								<option value="NM">New Mexico</option>
								<option value="NY">New York</option>
								<option value="NC">North Carolina</option>
								<option value="ND">North Dakota</option>
								<option value="OH">Ohio</option>
								<option value="OK">Oklahoma</option>
								<option value="OR">Oregon</option>
								<option value="PA">Pennsylvania</option>
								<option value="RI">Rhode Island</option>
								<option value="SC">South Carolina</option>
								<option value="SD">South Dakota</option>
								<option value="TN">Tennessee</option>
								<option value="TX">Texas</option>
								<option value="UT">Utah</option>
								<option value="VT">Vermont</option>
								<option value="VA">Virginia</option>
								<option value="WA">Washington</option>
								<option value="WV">West Virginia</option>
								<option value="WI">Wisconsin</option>
								<option value="WY">Wyoming</option>
							</select>
						</td>
					</tr>
					<tr>
						<td width="25%" align="left" style="border-right: 0px dotted rgb(204, 204, 204);">
							<label for="address">Zipcode</label>
							<span class="required">*</span>
							:
						</td>
						<td style="text-align:left;padding-left:6px;">
							<input name="zipcode" class="mgrid_text" dir="ltr" maxlength="70" value="<?php echo $doctorInfo[0]['b_zipcode']; ?>" style="width:210px;">
						</td>
					</tr>
				</tbody>
			</table>
		</fieldset>
		<fieldset style="padding:5px;margin-left:5px;margin-right:10px;">
			<legend>Business Hours<span>*</span></legend>
			<table class="col-md-6">
				<thead>
					<th class="col-md-3" style="text-align: center;">Day of Week</th>
					<th class="col-md-3" style="text-align: center;">Start time</th>
					<th class="col-md-3" style="text-align: center;">End time</th>
				</thead>
				<tbody>
				<tr>
					<td style="text-align: center;">Monday</td>
					<td>
						<select name="monday_start" class="col-md-6 col-md-offset-3">
							<?php echo $hourOptions; ?>
						</select>
					</td>
					<td>
						<select name="monday_end" class="col-md-6 col-md-offset-3">
							<?php echo $hourOptions; ?>
						</select>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">Tuesday</td>
					<td>
						<select name="tuesday_start" class="col-md-6 col-md-offset-3">
							<?php echo $hourOptions; ?>
						</select>
					</td>
					<td>
						<select name="tuesday_end" class="col-md-6 col-md-offset-3">
							<?php echo $hourOptions; ?>
						</select>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">Wednesday</td>
					<td>
						<select name="wednesday_start" class="col-md-6 col-md-offset-3">
							<?php echo $hourOptions; ?>
						</select>
					</td>
					<td>
						<select name="wednesday_end" class="col-md-6 col-md-offset-3">
							<?php echo $hourOptions; ?>
						</select>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">Thursday</td>
					<td>
						<select name="thursday_start" class="col-md-6 col-md-offset-3">
							<?php echo $hourOptions; ?>
						</select>
					</td>
					<td>
						<select name="thursday_end" class="col-md-6 col-md-offset-3">
							<?php echo $hourOptions; ?>
						</select>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">Friday</td>
					<td>
						<select name="friday_start" class="col-md-6 col-md-offset-3">
							<?php echo $hourOptions; ?>
						</select>
					</td>
					<td>
						<select name="friday_end" class="col-md-6 col-md-offset-3">
							<?php echo $hourOptions; ?>
						</select>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">Saturday</td>
					<td>
						<select name="saturday_start" class="col-md-6 col-md-offset-3">
							<?php echo $hourOptions; ?>
						</select>
					</td>
					<td>
						<select name="saturday_end" class="col-md-6 col-md-offset-3">
							<?php echo $hourOptions; ?>
						</select>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">Sunday</td>
					<td>
						<select name="sunday_start" class="col-md-6 col-md-offset-3">
							<?php echo $hourOptions; ?>
						</select>
					</td>
					<td>
						<select name="sunday_end" class="col-md-6 col-md-offset-3">
							<?php echo $hourOptions; ?>
						</select>
					</td>
				</tr>
				</tbody>
			</table>
		</fieldset>
			<div class="row buttons pull-right">
				<button class="btn btn-warning" type="submit">Next</button>
			</div>
	</form>
</div>

<script type="text/javascript">
$(document).ready(function() {
	var setupForm = $("form#form-setupAddress");
	setValueDropdown($(setupForm).find("select[name='state']"), "<?php echo $doctorInfo[0]['b_state']; ?>", "AL");
	setValueDropdown($(setupForm).find("select[name='monday_start']"), "<?php echo $doctorInfo[0]['list_mon_open']; ?>", "8:00 AM");
	setValueDropdown($(setupForm).find("select[name='monday_end']"), "<?php echo $doctorInfo[0]['list_mon_close']; ?>", "6:00 PM");
	setValueDropdown($(setupForm).find("select[name='tuesday_start']"), "<?php echo $doctorInfo[0]['list_tue_open']; ?>", "8:00 AM");
	setValueDropdown($(setupForm).find("select[name='tuesday_end']"), "<?php echo $doctorInfo[0]['list_tue_close']; ?>", "6:00 PM");
	setValueDropdown($(setupForm).find("select[name='wednesday_start']"), "<?php echo $doctorInfo[0]['list_wed_open']; ?>", "8:00 AM");
	setValueDropdown($(setupForm).find("select[name='wednesday_end']"), "<?php echo $doctorInfo[0]['list_wed_close']; ?>", "6:00 PM");
	setValueDropdown($(setupForm).find("select[name='thursday_start']"), "<?php echo $doctorInfo[0]['list_thur_open']; ?>", "8:00 AM");
	setValueDropdown($(setupForm).find("select[name='thursday_end']"), "<?php echo $doctorInfo[0]['list_thur_close']; ?>", "6:00 PM");
	setValueDropdown($(setupForm).find("select[name='friday_start']"), "<?php echo $doctorInfo[0]['list_fri_open']; ?>", "8:00 AM");
	setValueDropdown($(setupForm).find("select[name='friday_end']"), "<?php echo $doctorInfo[0]['list_fri_close']; ?>", "6:00 PM");
	setValueDropdown($(setupForm).find("select[name='saturday_start']"), "<?php echo $doctorInfo[0]['list_sat_open']; ?>", "8:00 AM");
	setValueDropdown($(setupForm).find("select[name='saturday_end']"), "<?php echo $doctorInfo[0]['list_sat_close']; ?>", "6:00 PM");
	setValueDropdown($(setupForm).find("select[name='sunday_start']"), "<?php echo $doctorInfo[0]['list_sun_open']; ?>", "8:00 AM");
	setValueDropdown($(setupForm).find("select[name='sunday_end']"), "<?php echo $doctorInfo[0]['list_sun_close']; ?>", "6:00 PM");
	
	// initiate multiselect and select the ones that has been selected
	$(setupForm).find("select[name='ammenties[]']").multiselect();
    $(setupForm).find("select[name='specialities[]']").multiselect();
<?php
	foreach ($amenities as $a) {
?>
	$(setupForm).find("select[name='ammenties[]']").multiselect('widget').find(":checkbox[value='<?php echo $a -> getId(); ?>']").click();
<?php
	}

	foreach ($specialities[0] as $s) {
?>
    $(setupForm).find("select[name='specialities[]']").multiselect('widget').find(":checkbox[value='<?php echo $s['speciality_id']; ?>']").click();
<?php
	}
?>
});
</script>