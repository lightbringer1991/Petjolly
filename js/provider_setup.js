function setValueDropdown(obj, value, defaultValue) {
	if ($(obj).find("option[value='" + value + "']").length == 0) {
		$(obj).val(defaultValue);
	} else {
		$(obj).val(value);
	}
}

$("form#form-setupAddress").validate({
	rules: {
		business_name: "required",
		description: "required",
		address: "address",
		city: "required",
		state: "required",
		zipcode: "zipcode",
	},
	messages: {
		business_name: "Business name cannot be blank",
		description: "Description cannot be blank",
		address: "Please enter a valid address",
		city: "Please enter a valid city",
		state: "Please enter a valid state",
		zipcode: "Please enter a valid zipcode",	
	}
});

$("form#form-setupSocial").validate({
	rules: {
		phone: {
			required: true,
			phoneUS: true
		},
		mobile: {
			required: true,
			phoneUS: true
		},
		fax: "phoneUS",
		list_website: "url",
	},
	messages: {
		phone: "Please enter a valid US phone number",
		mobile: "Please enter a valid US phone number",
		fax: "Please enter a valid US fax number",
		list_website: "Please enter a valid website",	
	}
});

$("form#form-setupAddress").on('submit', function(e) {
	$("div[data-role='loading-popup']").show();
	e.preventDefault();
	var form = $(this);
	setTimeout(function() {	
		if ($(form).valid()) {
			var data = $(form).serialize() + "&step=1";
			$.ajax({
				type: "POST",
				url: 'ajax/setup.ajax.php',
				data: data,
				success: function() {
					$("div[data-role='loading-popup']").hide();
					window.location.href = "index.php?provider=setup&step=2";
				}
			});
		}
		$("div[data-role='loading-popup']").hide();
	}, 4000);
});

$("form#form-setupServices").on('submit', function(e) {
	e.preventDefault();
	var data = $(this).serialize() + "&step=2";
	$.ajax({
		type: 'POST',
		url: 'ajax/setup.ajax.php',
		data: data,
		success: function() {
			window.location.href = "index.php?provider=setup&step=3";
		}
	});
});

$("form#form-setupSocial").on('submit', function(e) {
	e.preventDefault();
	var data = $(this).serialize() + "&step=3";
    if ($(this).valid()) {
        $.ajax({
            type: "POST",
            url: 'ajax/setup.ajax.php',
            data: data,
            success: function() {
                window.location.href = "index.php?provider=setup&step=4";
            }
        });
    }
});

$(document).on('click', "button[data-role='uploadImage']", function(e) {
	e.preventDefault();
	var formData = new FormData($("form#form-uploadPhoto")[0]);
	
	$.ajax({
		url: "ajax/setup.ajax.php", // Url to which the request is send
		type: "POST",             // Type of request to be send, called as method
		data: formData, // Data sent to server, a set of key/value pairs (i.e. form fields and values)
		contentType: false,       // The content type used when sending data to the server.
		cache: false,             // To unable request pages to be cached
		processData:false,        // To send DOMDocument or non processed data file it is set to false
		success: function(data) {
			if (data == 1) {
				window.location.href = "index.php?provider=setup&step=3";
			} else {
				$("form#form-uploadPhoto").find("div[data-role='alert-fileUpload']").addClass("alert alert-danger").html("Error uploading file");
			}
			
		}
	});
});

$(document).on('click', "button[data-role='btn-previous']", function(e) {
	e.preventDefault();
	var step = $(this).data('step');
	window.location.href = "index.php?provider=setup&step=" + step;
});

$(document).on('click', "button[data-role='delete-image']", function(e) {
	e.preventDefault();
	if(confirm('Do you want to delete this image?')) {
		var imgId = $(this).closest("div").data("id");
		$.ajax({
			type: "POST",
			url: "ajax/setup.ajax.php",
			data: { 'imgId': imgId, 'action': 'deleteImg' },
			success: function() {
				window.location.href = "index.php?provider=setup&step=3";
			}
		});
	}
});

// only used for step 3 Next button
$(document).on('click', "button[data-role='btn-next']", function(e) {
	window.location.href = "index.php?provider=setup&step=4";
});