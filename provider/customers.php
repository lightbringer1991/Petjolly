<?php
// *** Make sure the file isn't accessed directly
defined('APPHP_EXEC') or die('Restricted Access');
?>
<style type="text/css">
.fnameShow {
	font-weight: bold;
}

thead th.c_table {

}

span.action_icon {
	font-size: 20px;
	padding: 0 10px 0 10px;
	color: #AE8500;
}

thead.center th, tr.center td {
	text-align: center;
}

.modal-body {
	white-space: nowrap !important;
}
</style>
<script type="text/javascript">
function ConfirmChoice()
{ 
var r = confirm("Are you Sure want to delete this customer ?");
if (r == true) {
   return true;
} else {
   return false;
} 
confirm("Are you Sure want to delete this customer ?");
return true;
}
</script>
<?php
if($objLogin->IsLoggedInAsDoctor()){
    draw_title_bar(prepare_breadcrumbs(array(_CUSTOMERS=>'')));

	$action = $_REQUEST['mode'];
	$id = isset($_REQUEST['id']) ? $_REQUEST['id'] : '';
	if ($action == "view") {

?>
<button class="btn btn-warning pull-right" style="margin-bottom: 7px;" type="button" data-role='btn-customer-create'>New Customer</button>
<table class="table table-hover table-striped table-bordered">
	<thead class="center">
		<th class="c_table">First name</th>
		<th class="c_table">Last name</th>
		<th class="c_table">Email</th>
		<th class="c_table">Phone</th>
		<th class="c_table">Action</th>
	</thead>
	<tbody>
<?php
	$patients = Patients::GetAllCustomersByProvider(Session::Get("session_account_id"));
	foreach ($patients[0] as $p) {
        $action =  "<a href='#' data-role='view_appointments' data-toggle='tooltip' data-placement='top' title='View Appointments'><img src='images/microgrid_icons/details.gif' /></a>
					<a href='index.php?provider=customers&id={$p['id']}&mode=edit' data-toggle='tooltip' data-placement='top' title='Edit'><img src='images/microgrid_icons/edit.gif' /></a>";
					
					//<a href='index.php?provider=customers&id={$p['id']}&mode=delete' data-toggle='tooltip' data-placement='top' title='Delete' onclick='ConfirmChoice();'><img src='images/microgrid_icons/delete.png' /></a>";
					
		echo "<tr class='center' data-customer-id='{$p['id']}'>" .
				"<td>{$p['first_name']}</td>" . 
				"<td class='fnameShow'>{$p['last_name']}</td>" .
				"<td>{$p['email']}</td>" . 
				"<td>{$p['phone']}</td>" . 
				"<td>$action</td>" . 
			 "</tr>";
	}
?>
	</tbody>
</table>

<div id="view_details">
	<div class="modal fade" role="dialog">
	<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<h4 class="modal-title">Modal title</h4>
		</div>
		<div class="modal-body">

		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		</div>
	</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
</div>

<div id="create-customer-container">
	<div class="modal fade" role="dialog">
	<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<h4 class="modal-title">Create new Customer</h4>
		</div>
		<div class="modal-body">
			<form id='form-customer'>
				<fieldset>
					<table class="mgrid_table" width="100%" cellspacing="0" cellpadding="0" border="0">
						<tbody>
							<tr>
								<td width="25%" align="left">
									<label for="fname">First Name <span class="required">*</span>:</label>
								</td>
								<td style="text-align:left;padding-left:6px;">
									<input name="fname" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:210px;">
								</td>
							</tr>
							<tr>
								<td width="25%" align="left">
									<label for="lname">Last Name <span class="required">*</span>:</label>
								</td>
								<td style="text-align:left;padding-left:6px;">
									<input name="lname" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:210px;">
								</td>
							</tr>
							<tr>
								<td width="25%" align="left">
									<label for="address">Address <span class="required">*</span>:</label>
								</td>
								<td style="text-align:left;padding-left:6px;">
									<input name="address" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:210px;">
								</td>
							</tr>
							<tr>
								<td width="25%" align="left">
									<label for="city">City <span class="required">*</span>:</label>
								</td>
								<td style="text-align:left;padding-left:6px;">
									<input name="city" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:210px;">
								</td>
							</tr>
							<tr>
								<td width="25%" align="left">
									<label for="state">State <span class="required">*</span>:</label>
								</td>
								<td style="text-align:left;padding-left:6px;">
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
								<td width="25%" align="left">
									<label for="zipcode">Zipcode <span class="required">*</span>:</label>
								</td>
								<td style="text-align:left;padding-left:6px;">
									<input name="zipcode" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:210px;">
								</td>
							</tr>
							<tr>
								<td width="25%" align="left">
									<label for="phone">Phone <span class="required">*</span>:</label>
								</td>
								<td style="text-align:left;padding-left:6px;">
									<input name="phone" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:210px;">
								</td>
							</tr>
							<tr>
								<td width="25%" align="left">
									<label for="email">Email <span class="required">*</span>:</label>
								</td>
								<td style="text-align:left;padding-left:6px;">
									<input name="email" class="mgrid_text" dir="ltr" maxlength="70" value='' style="width:210px;">
								</td>
							</tr>
						</tbody>
					</table>
				</fieldset>
			</form>

		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			<button type="button" class="btn btn-warning" data-role='customer-submit'>Submit</button>
		</div>
	</div>
	</div>
	</div>
</div>

<?php
	} elseif ($action == "edit") {
		$p = Patients::GetPatientInfo($id);
?>
<div class="row">
	<div class="col-md-6 col-sm-12">
		<form id="form-editCustomer">
		<table class="col-md-12">
			<tr>
				<td class="col-md-5">First Name:</td>
				<td class="col-md-7"><input type="text" name="fname" class="form-control" value="<?php echo $p['first_name']; ?>"/></td>
			</tr>
			<tr>
				<td class="col-md-5">Last Name:</td>
				<td class="col-md-7"><input type="text" name="lname" class="form-control" value="<?php echo $p['last_name']; ?>"/></td>
			</tr>
			<tr>
				<td class="col-md-5">Address 1:</td>
				<td class="col-md-7"><input type="text" name="address1" class="form-control" value="<?php echo $p['b_address']; ?>"/></td>
			</tr>
			<tr>
				<td class="col-md-5">Address 2:</td>
				<td class="col-md-7"><input type="text" name="address2" class="form-control" value="<?php echo $p['b_address_2']; ?>"/></td>
			</tr>
			<tr>
				<td class="col-md-5">City:</td>
				<td class="col-md-7"><input type="text" name="city" class="form-control" value="<?php echo $p['b_city']; ?>"/></td>
			</tr>
			<tr>
				<td class="col-md-5">State:</td>
				<td class="col-md-7"><input type="text" name="state" class="form-control" value="<?php echo $p['b_state']; ?>"/></td>
			</tr>
			<tr>
				<td class="col-md-5">Country:</td>
				<td class="col-md-7"><input type="text" name="country" class="form-control" value="<?php echo $p['b_country']; ?>"/></td>
			</tr>
			<tr>
				<td class="col-md-5">Zip code:</td>
				<td class="col-md-7"><input type="text" name="zipcode" class="form-control" value="<?php echo $p['b_zipcode']; ?>"/></td>
			</tr>
			<tr>
				<td class="col-md-5">Phone:</td>
				<td class="col-md-7"><input type="text" name="phone" class="form-control" value="<?php echo $p['phone']; ?>"/></td>
			</tr>
			<tr>
				<td class="col-md-5">Email:</td>
				<td class="col-md-7"><input type="text" name="email" class="form-control" value="<?php echo $p['email']; ?>"/></td>
			</tr>
			<tr>
				<td class="col-md-12" colspan="2">
					<button type="button" data-role="delete-customer" class="btn btn-danger">Delete</button>
					<button type="submit" class="btn btn-success pull-right">Update</button>
				</td>
			</tr>
		</table>
		</form>
	</div>
	<div class="col-md-6 col-sm-12">
		<div class="row">
		<div class="col-md-offset-2 col-md-10">
		<form id="form-addPet">
		<table class="col-md-12">
			<tr>
				<td class="col-md-5">Name:</td>
				<td class="col-md-7"><input type="text" name="pet_name" class="form-control" value=""/></td>
			</tr>
			<tr>
				<td class="col-md-5">Type:</td>
				<td class="col-md-7">
					<select class="form-control" name="type">
<?php
	$allTypes = PetTypes::getPetTypesByCondition();
	foreach ($allTypes as $t) {
		echo "<option value='" . $t -> getId() . "'>" . $t -> getName() . "</option>";
	}
?>
					</select>
				</td>
			</tr>
            <tr>
                <td class="col-md-5">Breed:</td>
                <td class="col-md-7"><input type="text" name="pet_breed" class="form-control" value=""/></td>
            </tr>
			<tr>
				<td class="col-md-12" colspan="2">
					<button type="submit" class="btn btn-success pull-right">Add Pet</button>
				</td>
			</tr>
		</table>
		 </form>
		</div>
		</div>
		<div class="row">
			<table id="pet_del" class="table table-hover table-striped table-bordered" style="margin-top: 10px;">
				<thead>
                    <th class="c_table">Pet name</th>
					<th class="c_table">Type</th>
                    <th class="c_table">Breed</th>
                    <th class="c_table">Action</th>
				</thead>
				<tbody>
<?php
	$allPets = Pets::getAllPetsByCondition('customer_id', $id);
	if (count($allPets) == 0) {
		echo "<tr><td colspan='2' style='text-align: center;'>No Pet registered with this customer</td></tr>";
	} else {
		foreach ($allPets as $p) {
			$type = PetTypes::getPetTypesByCondition('id', $p -> getTypeId());
			echo "<tr data-pet-id='" . $p -> getId() . "'>
					<td>" . $p -> getName() . "</td>
					<td>" . $type[0] -> getName() . "</td>
					<td>" . $p -> getBreed() . "</td>
					<td style='width:100px;'><button type='button' id='pet_del_btn' name=". $p -> getId() ." data-role='delete-customer' class='btn btn-danger'>Delete</button> </td>
					
				  </tr>";
		}
	}
?>
				</tbody>
			</table>
            
		</div>
	</div>
   
</div>
<?php
	} elseif ($action == "delete") {
		Patients::removeCustomer($id);

		echo "<div class='alert alert-success' role='alert'>Customer removed successful</div>";
		
		echo 	"<script language='javascript' type='text/javascript'>
					window.setTimeout(function() {
						window.location.href='index.php?provider=customers&mode=view';
					}, 2000);
				</script>";

	}
}
?>