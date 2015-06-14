<?php
// *** Make sure the file isn't accessed directly
defined('APPHP_EXEC') or die('Restricted Access');
?>
<style type="text/css">
.fnameShow {
	color: blue;
	font-weight: bold;
}

thead th.c_table {
    background-color: #E45000;
    color: white;
}
</style>
<?php
if($objLogin->IsLoggedInAsDoctor()){
	$action = $_REQUEST['mode'];
	$id = isset($_REQUEST['id']) ? $_REQUEST['id'] : '';
	if ($action == "view") {

?>
<table class="table table-hover table-striped">
	<thead>
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
		$action =  "<a href='#' data-role='view_appointments' data-toggle='tooltip' data-placement='top' title='View Appointments'><img src='images/view.png' style='width: 25px; height: 25px;'/></a>
					<a href='#' data-role='view_pets' data-toggle='tooltip' data-placement='top' title='View Pets'><img src='images/pet.png' style='width: 25px; height: 25px;'/></a>
					<a href='index.php?provider=customers&id={$p['id']}&mode=edit' data-toggle='tooltip' data-placement='top' title='Edit'><img src='images/edit.png' style='width: 25px; height: 25px;'/></a>
					<a href='index.php?provider=customers&id={$p['id']}&mode=delete' data-toggle='tooltip' data-placement='top' title='Remove'><img src='images/remove.png' style='width: 25px; height: 25px;'/></a>";
		echo "<tr data-customer-id='{$p['id']}'>" . 
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
				<td class="col-md-12" colspan="2">
					<button type="submit" class="btn btn-success pull-right">Add Pet</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</div>
		<div class="row">
			<table class="table table-hover table-striped table-bordered" style="margin-top: 10px;">
				<thead>
					<th class="c_table">Pet name</th>
					<th class="c_table">Type</th>
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