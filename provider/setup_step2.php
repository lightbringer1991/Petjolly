<style type="text/css">
img.icon {
	margin: 0px 5px 0px 0px;
	width: 15px;
	height: 15px;
}
</style>

<div class="steps"  id="setup_step2">
	<form action="#" method="POST" id="form-setupSocial">
		<fieldset style="padding:5px;margin-left:5px;margin-right:10px;">
			<legend>Contact Information</legend>
			<table class="mgrid_table" width="100%" cellspacing="0" cellpadding="2" border="0">
				<tbody>
					<tr>
						<td width="25%" align="left" style="border-right: 0px dotted rgb(204, 204, 204);">
							<label for="storerfeatured">Select store will be featured</label>
							<span class="required">*</span>
							:
						</td>
						<td style="text-align:left;padding-left:6px;">
							<input type="radio" name="storerfeatured" value="1" class="radio-class"  /> Yes
							<input type="radio" name="storerfeatured" value="0" class="radio-class" checked="true" /> NO
						</td>
					</tr>
					<tr>
						<td width="25%" align="left" style="border-right: 0px dotted rgb(204, 204, 204);">
							<label for="phone">
								<span class="glyphicon glyphicon-phone-alt"></span>
								Phone Number
							</label>
							<span class="required">*</span>
							:
						</td>
						<td style="text-align:left;padding-left:6px;">
							<input type="text" name="phone" placeholder="0000000000" class="mgrid_text" dir="ltr" maxlength="70" value="<?php echo $doctorInfo[0]['phone']; ?>" style="width:210px;" />
						</td>
					</tr>
					<tr>
						<td width="25%" align="left" style="border-right: 0px dotted rgb(204, 204, 204);">
							<label for="mobile">
								<span class="glyphicon glyphicon-phone"></span>
								Mobile Number
							</label>
							<span class="required">*</span>
							:
						</td>
						<td style="text-align:left;padding-left:6px;">
							<input type="text" name="mobile" placeholder="0000000000" class="mgrid_text" dir="ltr" maxlength="70" value="<?php  echo $doctorInfo[0]['list_mobile']; ?>" style="width:210px;" />
						</td>
					</tr>
					<tr>
						<td width="25%" align="left" style="border-right: 0px dotted rgb(204, 204, 204);">
							<label for="fax">
								<span class="glyphicon glyphicon-print"></span>
								Fax Number
							</label>
							:
						</td>
						<td style="text-align:left;padding-left:6px;">
							<input type="text" name="fax" placeholder="0000000000" class="mgrid_text" dir="ltr" maxlength="70" value="<?php  echo $doctorInfo[0]['fax']; ?>" style="width:210px;" />
						</td>
					</tr>
					<tr>
						<td width="25%" align="left" style="border-right: 0px dotted rgb(204, 204, 204);">
							<label for="list_website">
								<span class="glyphicon glyphicon-globe"></span>
								Website
							</label>
							:
						</td>
						<td style="text-align:left;padding-left:6px;">
							<input type="text" name="list_website" placeholder="http://" class="mgrid_text" dir="ltr" maxlength="70" value="<?php  echo $doctorInfo[0]['list_website']; ?>" style="width:210px;" />
						</td>
					</tr>
				</tbody>
			</table>
		</fieldset>

		<fieldset style="padding:5px;margin-left:5px;margin-right:10px;">
			<legend>Social Accounts</legend>
			<table class="mgrid_table" width="100%" cellspacing="0" cellpadding="2" border="0">
				<tbody>
					<tr>
						<td width="25%" align="left" style="border-right: 0px dotted rgb(204, 204, 204);">
							<label for="list_twitter" style="vertical-align: middle;">
								<img class="icon" src="images/steps/twit.jpg" />
								Twitter	
							</label>
							:
						</td>
						<td style="text-align:left;padding-left:6px;">
							<input type="text" name="list_twitter" placeholder="@username" class="mgrid_text" dir="ltr" maxlength="70" value="<?php  echo $doctorInfo[0]['list_twitter']; ?>" style="width:300px;" />
						</td>
					</tr>
					<tr>
						<td width="25%" align="left" style="border-right: 0px dotted rgb(204, 204, 204);">
							<label for="list_facebook" style="vertical-align: middle;">
								<img class="icon" src="images/steps/fb.jpg" />
								Facebook URL
							</label>
							:
						</td>
						<td style="text-align:left;padding-left:6px;">
							<input type="text" name="list_facebook" placeholder="http://" class="mgrid_text" dir="ltr" maxlength="70" value="<?php  echo $doctorInfo[0]['list_facebook']; ?>" style="width:300px;" />
						</td>
					</tr>
					<tr>
						<td width="25%" align="left" style="border-right: 0px dotted rgb(204, 204, 204);">
							<label for="list_google" style="vertical-align: middle;">
								<img class="icon" src="images/steps/google+.jpg" />
								Google+ URL
							</label>
							:
						</td>
						<td style="text-align:left;padding-left:6px;">
							<input type="text" name="list_google" placeholder="http://" class="mgrid_text" dir="ltr" maxlength="70" value="<?php  echo $doctorInfo[0]['list_google']; ?>" style="width:300px;" />
						</td>
					</tr>
				</tbody>
			</table>
		</fieldset>
		
		<div class="row buttons pull-right">
			<button class="btn btn-info" data-role="btn-previous" data-step="1">Previous</button>
			<button class="btn btn-warning" type="submit">Next</button>
		</div>
	</form>
</div>

<script type="text/javascript">
$(document).ready(function() {
	var setupForm = $("form#form-setupSocial");
	$(setupForm).find("input[name='storerfeatured'][value='<?php echo $doctorInfo[0]['storerfeatured']; ?>']").prop('checked', true);
});
</script>