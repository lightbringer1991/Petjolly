// ---------------------- services ----------------------------------------
$("form#form-service").validate({
	rules: {
		service_name: "required",
		service_duration: {
			required: true,
			digits: true
		},
		service_price: {
			required: true,
			number: true
		}
	},
	messages: {
		service_name: "Service name cannot be blank",
		service_duration: {
			required: "Duration cannot be blank",
			digits: "Duration have to be an integer"
		},
		service_price: {
			required: "Price cannot be blank",
			number: "Price must be a number"
		}
	}
});

// click on edit icon
$(document).on('click', "a[data-role='edit_service']", function() {
	// get service information
	var serviceRow = $(this).closest('tr');
	var id = $(serviceRow).attr('id');
	var name = $(serviceRow).find('td:nth-child(1)').html();
	var description = $(serviceRow).find('td:nth-child(2)').html();
	var duration = $(serviceRow).find('td:nth-child(3)').html();
	var price = $(serviceRow).find('td:nth-child(4)').html();
    var active = $(serviceRow).find('td:nth-child(5)').html();
    if (active == "Yes") { active = 1; }
    else { active = 0; }

	// insert data into service form
	$("h3[data-role='service-form-header']").html("Edit Service");
	$("form#form-service").find("input[name='service_id']").val(id);
	$("form#form-service").find("input[name='service_name']").val(name);
	$("form#form-service").find("textarea[name='service_description']").val(description);
	$("form#form-service").find("input[name='service_duration']").val(duration);
	$("form#form-service").find("input[name='service_price']").val(price);
    $("form#form-service").find("input[name='service_active']").prop('checked', active);
});

// click on delete icon
$(document).on('click', "a[data-role='delete_service']", function() {
	var serviceRow = $(this).closest('tr');
	var id = $(serviceRow).attr('id');
	var name = $(serviceRow).find('td:nth-child(1)').html();
	if (!confirm("Do you want to delete service " + name + "?")) { return false; }
	$.ajax({
		type: 'POST',
		url: 'ajax/services.ajax.php',
		data: { 'category': 'service', 'type': 'delete', 'id': id },
		success: function() {
			window.location.href = "index.php?provider=services&category=service";
		}
	});
});

// click on cancel button
$(document).on('click', "button[data-role='btn-service-cancel']", function() {
	$("h3[data-role='service-form-header']").html("Create new Service");
	$("form#form-service").find("input").val('');
	$("form#form-service").find("textarea").val('');
});

$(document).on('submit', 'form#form-service', function(e) {
	e.preventDefault();
	var data = $(this).serialize();

	$.ajax({
		type: 'POST',
		url: 'ajax/services.ajax.php',
		data: data + "&category=service",
		success: function() {
			window.location.href = "index.php?provider=services&category=service";
		}
	});
});

// ---------------------- packages ----------------------------------------
jQuery.validator.addMethod("needsSelection", function(value, element) {
	return $(element).multiselect("getChecked").length > 0;
});

$("form#form-package").validate({
	rules: {
		package_name: "required",
		'package_services[]': "required needsSelection",
		package_duration: {
			required: true,
			digits: true
		},
		package_price: {
			required: true,
			number: true
		}
	},
	ignore: ":hidden:not(\"select[name='package_services[]']\")",
	messages: {
		package_name: "Package name cannot be blank",
		"package_services[]": "Package needs at least 1 service",
		package_duration: {
			required: "Duration cannot be blank",
			digits: "Duration have to be an integer"
		},
		package_price: {
			required: "Price cannot be blank",
			number: "Price must be a number"
		}
	},
	errorPlacement: function(error, element) {
		if ($(element).attr('name') == 'package_services[]') {
			var parentTD = $(element).closest('td');
			error.insertAfter($(parentTD).find('button'));
		}
		else { element.after(error); }
	}
});
// click on delete icon
$(document).on('click', "a[data-role='delete_package']", function() {
	var packageRow = $(this).closest('tr');
	var id = $(packageRow).attr('id');
	var name = $(packageRow).find('td:nth-child(1)').html();
	if (!confirm("Do you want to delete service " + name + "?")) { return false; }
	$.ajax({
		type: 'POST',
		url: 'ajax/services.ajax.php',
		data: { 'category': 'package', 'type': 'delete', 'id': id },
		success: function() {
			window.location.href = "index.php?provider=services&category=package";
		}
	});
});

// click on edit icon
$(document).on('click', "a[data-role='edit_package']", function() {
	// get package information
	var packageRow = $(this).closest('tr');
	var id = $(packageRow).attr('id');
	var name = $(packageRow).find('td:nth-child(1)').html();
	var description = $(packageRow).find('td:nth-child(2)').html();
	var serviceList = $(packageRow).find('td:nth-child(3) ul li');
	var duration = $(packageRow).find('td:nth-child(4)').html();
	var price = $(packageRow).find('td:nth-child(5)').html();
    var active = $(packageRow).find('td:nth-child(6)').html();
    if (active == "Yes") { active = 1; }
    else { active = 0; }

	
	// insert data into package form
	var form = $("form#form-package");
	$(form).find("input[name='package_id']").val(id);
	$(form).find("input[name='package_name']").val(name);
	$(form).find("textarea[name='package_description']").val(description);
	$(form).find("input[name='package_duration']").val(duration);
	$(form).find("input[name='package_price']").val(price);
	serviceList.each(function() {
		var sid = $(this).attr('id');
		$("form#form-package").find("select[name='package_services[]']").multiselect('widget').find(":checkbox[value='" + sid + "']").click();
	});
    $("form#form-package").find("input[name='package_active']").prop('checked', active);

	// display modal form
	var modalDiv = $("div#package-form-container div.modal");
	$(modalDiv).find("h4.modal-title").html("Edit package " + name);
	$(modalDiv).modal('show');

});

// click on create button
$(document).on('click', "button[data-role='btn-package-create']", function() {
	$("form#form-package").find("select[name='package_services[]']").multiselect('uncheckAll');
	$("form#form-package").find("input").val('');
	$("form#form-package").find("textarea").val('');
	
	var modalDiv = $("div#package-form-container div.modal");
	$(modalDiv).find("h4.modal-title").html("Create new package");
	$(modalDiv).modal('show');
});

$(document).on('click', "button[data-role='submit']", function() {
	if ($("form#form-package").valid()) {
		var data = $("form#form-package").serialize();
		$.ajax({
			type: 'POST',
			url: 'ajax/services.ajax.php',
			data: data + "&category=package",
			success: function() {
				window.location.href = "index.php?provider=services&category=package";
			}
		});
	}
});