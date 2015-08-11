<style type="text/css">
img.icon {
	margin: 0px 5px 0px 0px;
	width: 15px;
	height: 15px;
}
</style>

<div class="steps"  id="setup_step2">
	<form action="#" method="POST" id="form-setupServices">
		<fieldset style="padding:5px;margin-left:5px;margin-right:10px;">
			<legend>Amenities</legend>
			<table class="mgrid_table" width="100%" cellspacing="0" cellpadding="2" border="0">
				<tbody>
					<tr>
						<td width="25%" align="left" style="border-right: 0px dotted rgb(204, 204, 204);">
							<label for="amenities">Amenities</label>
							<span class="required">*</span>
							:
						</td>
						<td style="text-align:left;padding-left:6px;">
							<input type="text" name="amenities" class="mgrid_text" value="<?php echo $doctorInfo[0]['amenities']; ?>" dir="ltr" maxlength="70" style="width:300px;" />
						</td>
					</tr>
				</tbody>
			</table>
		</fieldset>

		<fieldset style="padding:5px;margin-left:5px;margin-right:10px;">
			<legend>Specialties</legend>
			<table class="mgrid_table" width="100%" cellspacing="0" cellpadding="2" border="0">
				<tbody>
					<tr>
                        <td width="25%" align="left" style="border-right: 0px dotted rgb(204, 204, 204);">
                            <label for="specialties">Specialties</label>
                            <span class="required">*</span>
                            :
                        </td>
						</td>
						<td style="text-align:left;padding-left:6px;">
							<input type="text" name="specialties" class="mgrid_text" value="<?php echo $doctorInfo[0]['specialties']; ?>" dir="ltr" maxlength="70" style="width:300px;" />
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
//	var setupForm = $("form#form-setupSocial");
//	$(setupForm).find("input[name='storerfeatured'][value='<?php //echo $doctorInfo[0]['storerfeatured']; ?>']").prop('checked', true);
});
</script>