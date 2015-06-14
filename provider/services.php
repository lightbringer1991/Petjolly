<?php
// *** Make sure the file isn't accessed directly
defined('APPHP_EXEC') or die('Restricted Access');
if($objLogin->IsLoggedInAsDoctor()) {
	$category = isset($_GET['category']) ? $_GET['category'] : 'service';
	$services = Services::getAllServicesByProviderID($objLogin -> GetLoggedID());
	$packages = Packages::getAllPackagesByProviderID($objLogin -> GetLoggedID());

    if ($category == "service") {
        draw_title_bar(prepare_breadcrumbs(array(_SERVICES=>'')));
    } else {
        draw_title_bar(prepare_breadcrumbs(array(_PACKAGES=>'')));
    }
?>
<style type="text/css">
span.action_icon {
	font-size: 20px;
	padding: 0 10px 0 10px;
	color: #AE8500;
}
.modal-body {
	white-space: nowrap !important;
}
</style>

<ul class="nav nav-tabs">
	<li <?php if ($category == 'service') { echo "class='active'"; } ?>><a data-toggle="tab" href="#pet_services">Services</a></li>
	<li <?php if ($category == 'package') { echo "class='active'"; } ?>><a data-toggle="tab" href="#pet_packages">Packages</a></li>
</ul>

<div class="tab-content">
	<div id="pet_services" class="tab-pane fade <?php if ($category == 'service') { echo "in active"; } ?>">
		<div class="row">
			<div class="col-md-7">
				<table class="table table-hover table-striped table-bordered">
					<thead>
						<th>Name</th>
						<th>Description</th>
						<th>Duration</th>
						<th>Price</th>
                        <th>Active</th>
						<th>Action</th>
					</thead>
					<tbody>
<?php
	$serviceAction =   "<a href='#' data-role='edit_service' data-toggle='tooltip' data-placement='top' title='Edit Service'><img src='images/microgrid_icons/edit.gif' /></a>
						<a href='#' data-role='delete_service' data-toggle='tooltip' data-placement='top' title='Delete Service'><img src='images/microgrid_icons/delete.gif' /></a>";
	foreach ($services as $s) {
		echo 	"<tr id='{$s -> getId()}'>
					<td>" . $s -> getName() . "</td>
					<td>" . $s -> getDescription() . "</td>
					<td>" . $s -> getDuration() . "</td>
					<td>" . $s -> getPrice() . "</td>
					<td>" . ( $s -> isActive() == 1 ? "Yes" : "No" ) . "</td>
					<td>$serviceAction</td>
				</tr>";
	}
?>
					</tbody>
				</table>
			</div>
			<div class="col-md-5">
				<h3 data-role='service-form-header'>Create new Service</h3>
				<form id='form-service'>
					<input type="hidden" name='service_id' value='' />
					<fieldset style="padding:5px;margin-left:5px;margin-right:10px;">
						<table class="mgrid_table" width="100%" cellspacing="0" cellpadding="2" border="0">
							<tbody>
								<tr>
									<td width="25%" align="left" style="border-right: 0px dotted rgb(204, 204, 204);">
										<label for="service_name">Name</label>
										<span class="required">*</span>
										:
									</td>
									<td style="text-align:left;padding-left:6px;">
										<input name="service_name" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:250px;">
									</td>
								</tr>
								<tr>
									<td width="25%" align="left" style="border-right: 0px dotted rgb(204, 204, 204);">
										<label for="service_description">Description:</label>
									</td>
									<td style="text-align:left;padding-left:6px;">
										<textarea name="service_description" dir="ltr" maxlength="70" value='' style="width:250px;"></textarea>
									</td>
								</tr>
								<tr>
									<td width="25%" align="left" style="border-right: 0px dotted rgb(204, 204, 204);">
										<label for="service_duration">Duration</label>
										<span class="required">*</span>
										:
									</td>
									<td style="text-align:left;padding-left:6px;">
										<input name="service_duration" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:250px;">
									</td>
								</tr>
								<tr>
									<td width="25%" align="left" style="border-right: 0px dotted rgb(204, 204, 204);">
										<label for="service_price">Price</label>
										<span class="required">*</span>
										:
									</td>
									<td style="text-align:left;padding-left:6px;">
										<input name="service_price" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:250px;">
									</td>
								</tr>
                                <tr>
                                    <td width="25%" align="left" style="border-right: 0px dotted rgb(204, 204, 204);">
                                        <label for="service_active">Active</label>
                                        <span class="required">*</span>
                                        :
                                    </td>
                                    <td style="text-align:left;padding-left:6px;">
                                        <input type="checkbox" name="service_active" />
                                    </td>
                                </tr>
							</tbody>
						</table>
						<div class='pull-right'>
							<button class="btn btn-danger" type="button" data-role='btn-service-cancel'>Cancel</button>
							<button class="btn btn-warning" type="submit">Submit</button>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
	</div>
	<div id="pet_packages" class="tab-pane fade <?php if ($category == 'package') { echo "in active"; } ?>">
		<button class="btn btn-warning pull-right" style="margin-bottom: 7px;" type="button" data-role='btn-package-create'>New Package</button>
		<div class="row">
			<table class="table table-hover table-striped table-bordered">
				<thead>
					<th>Name</th>
					<th>Description</th>
					<th>Services</th>
					<th>Duration</th>
					<th>Price</th>
                    <th>Active</th>
					<th>Action</th>
				</thead>
				<tbody>
<?php
	$packageAction = "<a href='#' data-role='edit_package' data-toggle='tooltip' data-placement='top' title='Edit Pacjage'><img src='images/microgrid_icons/edit.gif' /></a>
					  <a href='#' data-role='delete_package' data-toggle='tooltip' data-placement='top' title='Delete Package'><img src='images/microgrid_icons/delete.gif' /></a>";
	foreach ($packages as $p) {
		// get service list
		$serviceList = $p -> getServices();
		$sv = "<ul>";
		foreach ($serviceList as $s) {
			$sv .= "<li id='{$s -> getId()}'>{$s -> getName()}</li>";
		}
		$sv .= "</ul>";

		// print data into table
		echo   "<tr id='{$p -> getId()}'>
					<td>{$p -> getName()}</td>
					<td>{$p -> getDescription()}</td>
					<td>{$sv}</td>
					<td>{$p -> getDuration()}</td>
					<td>{$p -> getPrice()}</td>
					<td>" . ( $p -> isActive() == 1 ? "Yes" : "No" ) . "</td>
					<td>$packageAction</td>
				</tr>";
	}
?>
				</tbody>
			</table>
		</div>


		<div id="package-form-container">
			<div class="modal fade" role="dialog">
			<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">Modal title</h4>
				</div>
				<div class="modal-body">
					<form id='form-package'>
						<fieldset>
							<input type="hidden" name='package_id' value='' />
							<table class="mgrid_table" width="100%" cellspacing="0" cellpadding="0" border="0">
								<tbody>
									<tr>
										<td width="25%" align="left">
											<label for="package_name">Package Name <span class="required">*</span>:</label>
										</td>
										<td style="text-align:left;padding-left:6px;">
											<input name="package_name" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:250px;">
										</td>
									</tr>
									<tr>
										<td width="25%" align="left">
											<label for="package_description">Package Description:</label>
										</td>
										<td style="text-align:left;padding-left:6px;">
											<textarea name="package_description" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:250px;"></textarea>
										</td>
									</tr>
									<tr>
										<td width="25%" align="left">
											<label for="package_services[]">Package Services<span class="required">*</span>:</label>
										</td>
										<td style="text-align:left;padding-left:6px;">
											<select name="package_services[]" style="width:250px;" multiple="multiple" size="5">
<?php
	foreach ($services as $s) {
		echo "<option value='{$s -> getId()}'>{$s -> getName()}</option>";
	}
?>
											</select>
										</td>
									</tr>
									<tr>
										<td width="25%" align="left">
											<label for="package_duration">Package Duration <span class="required">*</span>:</label>
										</td>
										<td style="text-align:left;padding-left:6px;">
											<input name="package_duration" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:250px;">
										</td>
									</tr>
									<tr>
										<td width="25%" align="left">
											<label for="package_price">Package Price <span class="required">*</span>:</label>
										</td>
										<td style="text-align:left;padding-left:6px;">
											<input name="package_price" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:250px;">
										</td>
									</tr>
                                    <tr>
                                        <td width="25%" align="left" style="border-right: 0px dotted rgb(204, 204, 204);">
                                            <label for="package_active">Active</label>
                                            <span class="required">*</span>
                                            :
                                        </td>
                                        <td style="text-align:left;padding-left:6px;">
                                            <input type="checkbox" name="package_active" />
                                        </td>
                                    </tr>
								</tbody>
							</table>
						</fieldset>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-warning" data-role='submit'>Submit</button>
				</div>
			</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
			</div><!-- /.modal -->
		</div>
	</div>
</div>

<script type="text/javascript">
$(document).ready(function() {
	var packageForm = $("form#form-package");
	$(packageForm).find("select[name='package_services[]']").multiselect({
		appendTo: '#package-form-container div.modal'
	});
});
</script>

<?php
}
?>