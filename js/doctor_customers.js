// check if phone exists in the database
jQuery.validator.addMethod("phoneExist", function(value, element) {
	var result = false;
	$.ajax({
		type: 'POST',
		url: 'ajax/customers.ajax.php',
		async: false,
		data: { 'option': 'validatePhone', 'value': value },
		success: function(data) {
			if (data == 1) { result = true; }
		}
	});
	return result;
}, "Phone number already exists");

// check if email exists in the database
jQuery.validator.addMethod("emailExist", function(value, element) {
	var result = false;
	$.ajax({
		type: 'POST',
		url: 'ajax/customers.ajax.php',
		async: false,
		data: { 'option': 'validateEmail', 'value': value },
		success: function(data) {
			if (data == 1) { result = true; }
		}
	});
	return result;
}, "Email already exists");

$("form#form-customer").validate({
	rules: {
		fname: "required",
		lname: "required",
		/*address: "address",
		city: "required",
		state: "required",
		zipcode: "zipcode",*/
		phone: {
			required: true,
			phoneUS: true,
			phoneExist: true
		},
/*
		email: {
			required: true,
			email: true,
			emailExist: true
		}
*/
	},
	messages: {
		fname: "First name cannot be blank",
		lname: "Last name cannot be blank",
		/*address: "Please enter a valid address",
		city: "Please enter a valid city",
		state: "Please enter a valid state",
		zipcode: "Please enter a valid zipcode",*/
		phone: {
			required: "You must provide a US phone number",
			phoneUS: "Please enter a valid US phone number",
			phoneExist: "Phone number already exists"
		},
/*
		email: {
			required: "You must provide an email address",
			phoneUS: "Please enter a valid email address",
			emailExist: "Email already exists"
		}
*/
	}
});

// events to view appointment history of a customer
$(document).on('click', "a[data-role='view_appointments']", function() {
	var id = $(this).closest('tr').data('customer-id');
	var firstname = $(this).closest('tr').find('td:nth-child(1)').html();
	var lastname = $(this).closest('tr').find('td:nth-child(2)').html();
	var modalDiv = $("div#view_details div.modal");
	$(modalDiv).find("h4.modal-title").html("Appointment history of " + firstname + " " + lastname);

	$.ajax({
		type: 'POST',
		url: 'ajax/appointments.ajax.php',
		async: false,
		data: { 'option': 'getAllAppByCustomer', 'id': id },
		success: function(data) {
			var jsonData = JSON.parse(data);
			var output = "<table class='table table-hover table-striped table-bordered'>" + 
							"<thead>" + 
								"<th class='c_table'>Appointment Number</th>" + 
								"<th class='c_table'>Date/Time</th>" + 
								"<th class='c_table'>Duration (minutes)</th>" + 
								"<th class='c_table'>Status</th>" + 
							"</thead>" + 
							"<tbody>";
			if (jsonData.length == 0) {
				output += 	"<tr>" + 
							"<td colspan='4'>No appointment recorded</td>" + 
							"</tr>";
			}
			else {
				for(var i = 0; i < jsonData.length; i++) {
					if (jsonData[i].status == 0) { jsonData[i].status = '<span class="label label-info">reserved</span>'; }
					else if (jsonData[i].status == 1) { jsonData[i].status = '<span class="label label-success">verified</span>'; }
					else if (jsonData[i].status == 2) { jsonData[i].status = '<span class="label label-danger">canceled</span>'; }

					output += 	"<tr data-id='" + jsonData[i].id + "'>" + 
									"<td>" + jsonData[i].appointment_number + "</td>" + 
									"<td>" + jsonData[i].appointment_date + " " + jsonData[i].appointment_time + "</td>" + 
									"<td>" + jsonData[i].visit_duration + "</td>" + 
									"<td>" + jsonData[i].status + "</td>" + 
								"</tr>";
				}				
			}
			output += "</tbody></table>";
			$(modalDiv).find("div.modal-body").html(output);
			$(modalDiv).modal('show');
		}
	});
});

// click on create customer button
$(document).on('click', "button[data-role='btn-customer-create']", function() {
	var modalDiv = $("div#create-customer-container div.modal");
	$(modalDiv).modal('show');
});

// click on submit button in create customer modal
$(document).on('click', "button[data-role='customer-submit']",function() {
	if ($("form#form-customer").valid()) {
		$("div[data-role='loading-popup']").show();
		var form = $("form#form-customer");
		setTimeout(function() {	
			var data = $(form).serialize() + "&option=addCustomer";
			$.ajax({
				type: "POST",
				url: 'ajax/customers.ajax.php',
				data: data,
				success: function() {
					$("div[data-role='loading-popup']").hide();
					window.location.href = "index.php?provider=customers&mode=view";
				}
			});
		}, 2000);
	}
});

// events to view all pets registered with a customer
$(document).on('click', "a[data-role='view_pets']", function() {
	var id = $(this).closest('tr').data('customer-id');
	var firstname = $(this).closest('tr').find('td:nth-child(1)').html();
	var lastname = $(this).closest('tr').find('td:nth-child(2)').html();
	var modalDiv = $("div#view_details div.modal");
	$(modalDiv).find("h4.modal-title").html("Pets registered with " + firstname + " " + lastname);
	
	$.ajax({
		type: 'POST',
		url: 'ajax/customers.ajax.php',
		async: false,
		data: { 'option': 'getAllPetsByCustomer', 'id': id },
		success: function(data) {
			var jsonData = JSON.parse(data);
			var output = "<table class='table table-hover table-striped table-bordered'>" + 
							"<thead>" + 
								"<th class='c_table'>Pet Name</th>" + 
								"<th class='c_table'>Pet Type</th>" + 
							"</thead>" + 
							"<tbody>";
			if (jsonData.length == 0) {
				output += 	"<tr>" + 
							"<td colspan='2'>No pet registered with this customer</td>" + 
							"</tr>";
			}
			else {
				for(var i = 0; i < jsonData.length; i++) {
					output += 	"<tr data-id='" + jsonData[i].id + "'>" + 
									"<td>" + jsonData[i].name + "</td>" + 
									"<td>" + jsonData[i].type + "</td>" + 
								"</tr>";
				}				
			}
			output += "</tbody></table>";
			$(modalDiv).find("div.modal-body").html(output);
			$(modalDiv).modal('show');
		}
	});
});

// edit customer form submit
$(document).on('submit', 'form#form-editCustomer', function(event) {
	event.preventDefault();
	var urlParams = parseURLParams(document.URL);
	var id = urlParams['id'][0];
	
	var updateData = $(this).serialize() + "&option=update&id=" + id;
	$.ajax({
		type: 'POST',
		url: 'ajax/customers.ajax.php',
		data: updateData,
		success: function() {
			location.reload();
		}
	});
});

// add pet form submit
$(document).on('submit', 'form#form-addPet', function(event) {
	event.preventDefault();
	var urlParams = parseURLParams(document.URL);
	var id = urlParams['id'][0];
	var addData = $(this).serialize() + "&option=addPet&id=" + id;
	$.ajax({
		type: 'POST',
		url: 'ajax/customers.ajax.php',
		data: addData,
		success: function() {
		window.location.href = "index.php?provider=customers&id="+id+"&mode=edit";
		}
	});
});

$(document).on('click', "form#form-editCustomer :button[data-role='delete-customer']", function(e) {
	e.preventDefault();
	if (confirm('Do you want to delete this customer?')) {
		var urlParams = parseURLParams(document.URL);
		var id = urlParams['id'][0];
		$.ajax({
			type: 'POST',
			url: 'ajax/customers.ajax.php',
			data: { 'option': 'deleteCustomer', 'id': id },
			success: function() {
				window.location.href = "index.php?provider=customers&mode=view";
			}
		});
	}
});

// Delete pet 
$(document).on('click', "button#pet_del_btn", function(e) {
	e.preventDefault();
	if (confirm('Do you want to delete this Pet?')) {
		var urlParams = parseURLParams(document.URL);
		var petId=$(this).attr("name");
		
		var id = urlParams['id'][0];
		
		$.ajax({
			type: 'POST',
			url: 'ajax/customers.ajax.php',
			data: { 'option': 'deletePets', 'id': id,'petId':petId },
			success: function() {
				//window.location.href = "index.php?provider=customers&mode=view";
				window.location.href = "index.php?provider=customers&id="+id+"&mode=edit";
			}
		});
	}
});


// toggle bootstrap 3 tooltip of the buttons
$(document).find("[data-toggle='tooltip']").tooltip();