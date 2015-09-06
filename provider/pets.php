<?php
defined('APPHP_EXEC') or die('Restricted Access');

if ($objLogin -> IsLoggedInAsDoctor()) {
	$allPets = Pets::getAllPetsByProviderId(Session::Get("session_account_id"));
?>

<div class="row">
	<div class="col-md-5 col-xs-12 col-lg-5">
		<div class="row">
			<div class="col-md-12 col-xs-12 col-lg-12">
				<button class="btn btn-warning pull-right" style="margin-bottom: 7px;" type="button" data-role='btn-add-pet'>Add</button>
			</div>
		</div>
		<table data-id="pet_table" class="table table-bordered display">
			<thead class="center">
				<th>Owner</th>
				<th>Name</th>
				<th>Breed</th>
				<th>Action</th>
			</thead>
			<tbody>
<?php
	foreach ($allPets as $p) {
		$customer = Patients::getPatientDataById($p -> getCustomerId());
		echo "	<tr>
					<td>{$customer[0]['first_name']} {$customer[0]['last_name']}</td>
					<td>" . $p -> getName() . "</td>
					<td>" . $p -> getBreed() . "</td>
					<td><input type='checkbox' name='cb_pet' /></td>
				</tr>";
	}
?>
			</tbody>
		</table>
		<div class="row">
			<div class="col-md-12 col-xs-12 col-lg-12">
				<button class="btn btn-info" style="margin-bottom: 7px;" type="button" data-role='btn-add-pet'>Delete</button>
			</div>
		</div>
	</div>
	<div class="col-md-7 col-xs-12 col-lg 7" data-role="container-petDetails">
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" class="active"><a href="#pet_details" role="tab" data-toggle="tab">Pet Details</a></li>
			<li role="presentation"><a href="#pet_appointment_history" role="tab" data-toggle="tab">Appointment Details</a></li>
			<li role="presentation"><a href="#pet_payment_history" role="tab" data-toggle="tab">Payment History</a></li>
			<li role="presentation"><a href="#pet_message_history" role="tab" data-toggle="tab">Message History</a></li>
		</ul>

		<div class="tab-content">
			<div role="tabpanel" class="tab-pane active" id="pet_details">
				<form>
					<table class="mgrid_table" width="100%" cellspacing="0" cellpadding="0" border="0">
						<tbody>
							<tr>
								<td colspan='2'><button class="btn btn-warning" style="margin-bottom: 7px;" type="button" data-role='btn-edit-pet'>Edit Details</button></td>
							</tr>
							<tr>
								<td width="25%" align="left">
									<label for="pet_name">Name</label>
								</td>
								<td style="text-align:left;padding-left:6px;">
									<input name="pet_name" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:210px;">
								</td>
							</tr>
							<tr>
								<td width="25%" align="left">
									<label for="customer_name">Customer Name</label>
								</td>
								<td style="text-align:left;padding-left:6px;">
									<input name="customer_name" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:210px;">
								</td>
							</tr>
							<tr>
								<td width="25%" align="left">
									<label for="customer_phone">Customer Phone</label>
								</td>
								<td style="text-align:left;padding-left:6px;">
									<input name="customer_phone" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:210px;">
								</td>
							</tr>
							<tr>
								<td width="25%" align="left">
									<label for="customer_mobile">Customer Mobile</label>
								</td>
								<td style="text-align:left;padding-left:6px;">
									<input name="customer_mobile" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:210px;">
								</td>
							</tr>
							<tr>
								<td width="25%" align="left">
									<label for="customer_email">Customer Email</label>
								</td>
								<td style="text-align:left;padding-left:6px;">
									<input name="customer_email" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:210px;">
								</td>
							</tr>
							<tr>
								<td width="25%" align="left">
									<label for="pet_notes">Pet Notes</label>
								</td>
								<td style="text-align:left;padding-left:6px;">
									<textarea name="pet_notes" class="mgrid_text" style="width:210px;"></textarea>
								</td>
							</tr>
							<tr>
								<td width="25%" align="left">
									<label for="customer_notes">Latest Customer Notes</label>
								</td>
								<td style="text-align:left;padding-left:6px;">
									<textarea name="customer_notes" class="mgrid_text" style="width:210px;"></textarea>
								</td>
							</tr>
							<tr>
								<td width="25%" align="left">
									<button class="btn btn-info" style="margin-bottom: 7px;" type="button" data-role='btn-edit-pet'>Edit</button>
								</td>
								<td></td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
			<div role="tabpanel" class="tab-pane" id="pet_appointment_history">
				Pet Appointments
			</div>
			<div role="tabpanel" class="tab-pane" id="pet_payment_history">
				Payment history
			</div>
			<div role="tabpanel" class="tab-pane" id="pet_message_history">
				Message History
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(document).ready(function() {
	var table = $("[data-id='pet_table']").DataTable();

	// perform display pet details
    $("[data-id='pet_table'] tbody").on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }
        else {
            table.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    } );

    // delete from table
	$('#button').click( function () {
		table.row('.selected').remove().draw( false );
	} );
});
</script>

<?php
}
?>