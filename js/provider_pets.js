var petActions = {
	config: {
		table_pets: null,
		container_petList: null,
		container_petDetails: null,
		container_petForm: null,

		// there's no need to initialize below values
		selected_id: null,
		ajaxGetPetDetails: 'ajax/pets.ajax.php?action=getDetails',
		ajaxGetAppointmentHistory: 'ajax/pets.ajax.php?action=getAppointmentHistory',
		ajaxEditPetDetails: 'ajax/pets.ajax.php?action=editDetails',
		ajaxDeletePets: 'ajax/pets.ajax.php?action=deletePets',
		ajaxAddPet: 'ajax/pets.ajax.php?action=addPet',
		ajaxCustomerAutocomplete: 'ajax/pets.ajax.php?action=customerAutocomplete'
	},
	init: function(newSettings) {
		$.extend(petActions.config, newSettings);
		petActions.setup();
	},
	setup: function() {
		// define click on row behaviour
		petActions.config.container_petDetails.on('click', "#pet_details [data-role='btn-edit-pet']", function() {
			petActions.config.container_petDetails.find("#pet_details form").find("input").prop('disabled', false);
			petActions.config.container_petDetails.find("#pet_details form").find("textarea[name='pet_notes']").prop('disabled', false);
			petActions.config.container_petDetails.find("#pet_details form").find("[data-role='btn-submit-details']").show();
		});
		petActions.config.container_petDetails.on('click', "#pet_details [data-role='btn-submit-details']", petActions.submitDetails_handler);
		petActions.config.container_petDetails.on('click', "a[href='#pet_appointment_history']", petActions.getAppointmentHistory);
		petActions.config.table_pets.find('tbody').on('click', 'tr', petActions.selectPet_handler);
		petActions.config.container_petList.on('click', "button[data-role='btn-delete-pet']", petActions.deletePets_handler);
		petActions.config.container_petForm.find("input[name='customer_name']").autocomplete({
			source: petActions.config.ajaxCustomerAutocomplete,
			appendTo: petActions.config.container_petForm.find('form'),
			focus: function(event, ui) {
				// prevent autocomplete from updating the textbox
				event.preventDefault();
				return false;
			},
			select: function(event, ui) {
				// prevent autocomplete from updating the textbox
				event.preventDefault();
				// manually update the textbox and hidden field
				petActions.config.container_petForm.find("input[name='customer_id']").val(ui.item.value);
				petActions.config.container_petForm.find("input[name='customer_name']").val(ui.item.description);
				return false;
			},
			response: function(event, ui) {
				if (ui.content.length === 0) {
					petActions.config.container_petForm.find("input[name='customer_id']").val("");
				}
			}
		}).autocomplete("instance")._renderItem = function(ul, item) {
			$(ul).attr('style', 'list-style-type: none;');
			return $("<li>").append("<a>" + item.description + "</a>").appendTo(ul);
		};
		petActions.config.container_petForm.on('click', "button[data-role='btn-submitForm']", petActions.submitPet_handler);

		// initialize view
		petActions.config.table_pets.DataTable();
		petActions.config.container_petDetails.find("#pet_details form").find("input, textarea").prop('disabled', true);
		petActions.config.container_petDetails.find("#pet_details form").find("[data-role='btn-submit-details']").hide();
		petActions.config.table_pets.find('tr:first-child()').click();
	},
	selectPet_handler: function(event) {
		var trObj = $(event.currentTarget);
		petActions.config.selected_id = trObj.data('id');
		if ( trObj.hasClass('selected') ) {
			trObj.removeClass('selected');
		}
		else {
			petActions.config.table_pets.find('tr.selected').removeClass('selected');
			trObj.addClass('selected');
		}

		// disable the form
		petActions.config.container_petDetails.find("#pet_details form").find("input, textarea").prop('disabled', true);
		petActions.config.container_petDetails.find("#pet_details form").find("[data-role='btn-submit-details']").hide();


		// query information from server to display pet details
		$.ajax({
			type: 'POST',
			url: petActions.config.ajaxGetPetDetails,
			data: { 'id': petActions.config.selected_id },
			success: function(data) {
				var jsonData = JSON.parse(data);
				petActions.config.container_petDetails.find("input[name='pet_name']").val(jsonData.name);
				petActions.config.container_petDetails.find("input[name='customer_name']").val(jsonData.first_name + ' ' + jsonData.last_name);
				petActions.config.container_petDetails.find("input[name='customer_phone']").val(jsonData.phone);
				petActions.config.container_petDetails.find("input[name='customer_mobile']").val(jsonData.cellphone);
				petActions.config.container_petDetails.find("input[name='customer_email']").val(jsonData.email);
				petActions.config.container_petDetails.find("textarea[name='pet_notes']").val(jsonData.notes);
				petActions.config.container_petDetails.find("textarea[name='customer_notes']").val(jsonData.customer_notes);
			}
		});
		
		// also trigger the event on currently opening tab
		petActions.config.container_petDetails.find("li#active>a").click();
	},
	submitDetails_handler: function(event) {
		var form = $(event.currentTarget).closest('form');
		var formData = form.serializeArray();
		formData.push( { 'name': 'id', 'value': petActions.config.selected_id } );
		
		$.ajax({
			type: 'POST',
			url: petActions.config.ajaxEditPetDetails,
			data: formData,
			success: function(response) {
				alert(response);
			}
		});
	},
	getAppointmentHistory: function(event) {
		$.ajax({
			type: 'POST',
			url: petActions.config.ajaxGetAppointmentHistory,
			data: { 'id': petActions.config.selected_id },
			success: function(htmlCode) {
				petActions.config.container_petDetails.find("#pet_appointment_history").html(htmlCode);
			}
		});
	},
	deletePets_handler: function(event) {
		var ids = [];
		petActions.config.table_pets.find("input[type='checkbox']:checked").each(function() {
			ids.push($(this).closest('tr').data('id'));
		})
		$.ajax({
			type: 'POST',
			url: petActions.config.ajaxDeletePets,
			data: { 'id': ids },
			success: function() {
				location.reload();
			}
		});
	},
	submitPet_handler: function(event) {
		if (petActions.config.container_petForm.find("input[name='customer_id']").val() == '') {
			alert("Please choose a customer");
			return false;
		}

		var formData = petActions.config.container_petForm.find('form').serializeArray();
		$.ajax({
			type: 'POST',
			url: petActions.config.ajaxAddPet,
			data: formData,
			success: function() {
				location.reload();
			}
		});
	}
};
