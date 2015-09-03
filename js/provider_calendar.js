/*
 *	jQuery FullCalendar Extendable Plugin
 *	An Ajax (PHP - Mysql - jquery) script that extends the functionalities of the fullcalendar plugin
 *  Dependencies: 
 *   - jquery
 *   - jquery Ui
 * 	 - jquery spectrum (since 2.0)
 *   - jquery timepicker (since 1.6.4)
 *   - jquery Fullcalendar
 *   - Twitter Bootstrap
 *  Author: Paulo Regina
 *  Website: www.pauloreg.com
 *  Contributions: Patrik Iden, Jan-Paul Kleemans, Bob Mulder
 *	Version 2.0, January - 2015 
 *  Fullcalendar 2.2.6
 *	Released Under Envato Regular or Extended Licenses
 */
function clearEventForm(form) {
	$(form).find('button[type="submit"]').html("Add Event");
	$(form).find('input[type="text"]').val('');
    $(form).find('input[type="hidden"]').val('');
	$(form).find("input[name='form_type']").val('add');
	$(form).find("input[name='color']").spectrum('set', '#0000FF');
	
	$(form).find("textarea").val("");
    $(form).find('select[multiple="multiple"]').multiselect('uncheckAll');
}

function getTimeOff(url, start, end) {
    var result = null;
    $.ajax({
        type: 'POST',
        url: url,
        data: { 'start': start, 'end': end },
        async: false,
        success: function(data) {
            result = JSON.parse(data);
        }
    });
    return $result;
}

var createAppointmentAction = {
    config: {
        calendarSelector: null,
        formCreate: null,
        formCreateCustomer: null,

        // no change in this section
        ajaxRetrieveHistory: 'ajax/appointments.ajax.php',
        ajaxPetAutocomplete: 'ajax/calendar.ajax.php?option=petAutocomplete',
        ajaxEventSave: 'ajax/calendar.ajax.php?option=createEvent',
        ajaxEventEdit: 'ajax/calendar.ajax.php?option=editEvent',
        ajaxRetrieveDescription: 'ajax/calendar.ajax.php?option=eventDescription',
        ajaxAddCustomer: 'ajax/calendar.ajax.php?option=createCustomer',
        ajaxRetrievePetDetails: 'ajax/calendar.ajax.php?option=petDetails'
    },
    init: function(newSettings) {
        $.extend(createAppointmentAction.config, newSettings);
        createAppointmentAction.setup();
    },
    setup: function() {
        // initialize display
        createAppointmentAction.config.formCreate.find("[data-role='step1_2']").hide();
        createAppointmentAction.config.formCreate.find("[data-role*='step2']").hide();
        createAppointmentAction.config.formCreate.find("form").validate(createAppointmentAction.validateCreate);

        // ----- step 1 event handlers
        // action taken if user click on Next button
        createAppointmentAction.config.formCreate.on('click', "button[data-role='next_step']", createAppointmentAction.displayStep2);
        createAppointmentAction.config.formCreate.on('change', "input[name='pet_id']", function() {
            createAppointmentAction.config.formCreate.find("[data-role='step1_2']").show(1000);
        });
        createAppointmentAction.config.formCreate.on('click', "button[data-role='previous_step']", createAppointmentAction.displayStep1);
        // autocomplete
        createAppointmentAction.config.formCreate.find("input[name='pet_name']")
            .autocomplete({
                source: createAppointmentAction.config.ajaxPetAutocomplete,
                appendTo: createAppointmentAction.config.formCreate,
                focus: function(event, ui) {
                    // prevent autocomplete from updating the textbox
                    event.preventDefault();
                    return false;
                },
                select: function(event, ui) {
                    // prevent autocomplete from updating the textbox
                    event.preventDefault();
                    // manually update the textbox and hidden field
                    createAppointmentAction.config.formCreate.find("input[name='pet_name']").val(ui.item.label);
                    createAppointmentAction.config.formCreate.find("input[name='pet_id']").val(ui.item.value).trigger('change');
                    createAppointmentAction.config.formCreate.find("textarea[name='pet_notes']").val(ui.item.notes);
                    createAppointmentAction.config.formCreate.find("input[name='customer_name']").val(ui.item.description);
                    createAppointmentAction.config.formCreate.find("input[name='customer_phone']").val(ui.item.phone);
                    createAppointmentAction.config.formCreate.find("input[name='customer_phone_preference'][value='phone']").click();
                    createAppointmentAction.config.formCreate.find("input[name='customer_email']").val(ui.item.email);
                    return false;
                },
                response: function(event, ui) {
                    if (ui.content.length === 0) {
                        $("div[data-class='customer_error']").html("No customer found");
                        $("input[name='c_id']").val("");
                    } else {
                        $("div[data-class='customer_error']").empty();
                    }
                }
            })
            .autocomplete("instance")._renderItem = function(ul, item) {
                return $("<li>").append("<a>" + item.label + "<br />" + item.description + "</a>").appendTo(ul);
            };

        // ----- step 2 event handlers (including event submission)
        // submit new event / edit existing event
        createAppointmentAction.config.formCreate.on('click', "button[data-role='submit']", createAppointmentAction.submitForm);

        // ----- create new customer
        createAppointmentAction.config.formCreateCustomer.on('click', "[data-role='calendar-customer-submit']", createAppointmentAction.submitCustomerForm);
    },
    displayStep1: function(event) {
        createAppointmentAction.config.formCreate.find("[data-role*='step2']").hide();
        createAppointmentAction.config.formCreate.find("[data-role*='step1']").show();
    },
    displayStep2: function(event) {
        if (!createAppointmentAction.config.formCreate.find("form").valid()) { return false; }
        var petID = createAppointmentAction.config.formCreate.find("input[name='pet_id']").val();
        if (petID == '') { return false; }          // user cannot click next if no pet is selected

        // fill in disabled fields
        $.ajax({
            type: 'POST',
            url: createAppointmentAction.config.ajaxRetrievePetDetails,
            data: { 'id': petID },
            success: function(data) {
                var jsonData = JSON.parse(data);
                createAppointmentAction.config.formCreate.find("input[name='pet_name_disabled']").val(jsonData.name);
                createAppointmentAction.config.formCreate.find("input[name='pet_breed_disabled']").val(jsonData.breed);
                createAppointmentAction.config.formCreate.find("input[name='customer_name_disabled']").val(jsonData.customerName);
            }
        });

        // get appointment history
        $.ajax({
            type: 'POST',
            url: createAppointmentAction.config.ajaxRetrieveHistory,
            data: { 'id': petID, 'option': 'getAppointmentHistory' },
            success: function(data) {
                var jsonData = JSON.parse(data);
                var output = "<table class='table table-hover table-striped table-bordered'>" + 
                                "<thead>" + 
                                    "<th class='c_table'>Date/Time</th>" + 
                                    "<th class='c_table'>Services</th>" + 
                                    "<th class='c_table'>Pet Notes</th>" + 
                                    "<th class='c_table'>Amount Paid</th>" + 
                                "</thead>" + 
                                "<tbody>";
                if (jsonData.length == 0) {
                    output +=   "<tr>" + 
                                "<td colspan='4' align='center'>No appointment recorded</td>" + 
                                "</tr>";
                }
                else {
                    for(var i = 0; i < jsonData.length; i++) {
                        output +=   "<tr data-id='" + jsonData[i].id + "'>" + 
                                        "<td>" + jsonData[i].date + "</td>" + 
                                        "<td>" + jsonData[i].services + "</td>" + 
                                        "<td>" + jsonData[i].notes + "</td>" + 
                                        "<td>" + jsonData[i].price + "</td>" + 
                                    "</tr>";
                    }               
                }
                output += "</tbody></table>";

                createAppointmentAction.config.formCreate.find('[data-role="pet_history_container"]').html(output);
            }
        });

        // hide step 1 and display step 2
        createAppointmentAction.config.formCreate.find("[data-role*='step1']").hide();
        createAppointmentAction.config.formCreate.find("[data-role*='step2']").show();
    },
    submitForm: function(event) {
        var ajaxURL = createAppointmentAction.config.ajaxEventSave;
        if (createAppointmentAction.config.formCreate.find("input[name='appointment_id']").val() != '') {
            ajaxURL = createAppointmentAction.config.ajaxEventEdit;
        }
        if (!createAppointmentAction.validateCreateForm()) { return false; }

        var data = createAppointmentAction.config.formCreate.find('form').serializeArray();

        $.ajax({
            type: 'POST',
            url: ajaxURL,
            data: data,
            success: function(data) {
                createAppointmentAction.config.formCreate.modal('hide');
                clearEventForm(createAppointmentAction.config.formCreate);
                createAppointmentAction.config.formCreate.find("[data-role*='step2']").hide();
                createAppointmentAction.config.formCreate.find("[data-role*='step1']").hide();
                createAppointmentAction.config.formCreate.find("[data-role='step1_1']").show();
                createAppointmentAction.config.calendarSelector.fullCalendar('refetchEvents');
            }
        });
    },
    submitCustomerForm: function(event) {
        if (!createAppointmentAction.validateCustomerForm()) { return false; }

        var data = createAppointmentAction.config.formCreateCustomer.find("form").serialize();
        $.ajax({
            type: 'POST',
            url: createAppointmentAction.config.ajaxAddCustomer,
            data: data,
            success: function(data) {
                var jsonData = JSON.parse(data);
                createAppointmentAction.resetForm(createAppointmentAction.config.formCreate);

                for (var property in jsonData ) {
                    createAppointmentAction.config.formCreate.find("[name='" + property + "']").val(jsonData[property]);
                }
                createAppointmentAction.config.formCreateCustomer.modal('hide');
                createAppointmentAction.config.formCreate.find("[name='pet_id']").trigger('change');
            }
        });
    },
    validateCreateForm: function() {
        // check if a pet is selected
        if (createAppointmentAction.config.formCreate.find("input[name='pet_id']").val() == '') {
            alert("Invalid pet");
            return false;
        }

        //check if any service or package is selected
        if (createAppointmentAction.config.formCreate.find("select[name='service_list[]']").multiselect('getChecked').length == 0) {
            alert("Please select at least 1 service or 1 package");
            return false;
        }

        if (createAppointmentAction.config.formCreate.find("input[name='appointment_date']").val() == '') {
            alert("Please enter appointment date");
            return false;
        }
        if (createAppointmentAction.config.formCreate.find("input[name='appointment_time']").val() == '') {
            alert("Please enter appointment time");
            return false;
        }
        return true;
    },
    validateCustomerForm: function() {
        if (createAppointmentAction.config.formCreateCustomer.find("input[name='customer_fname']").val() == '') {
            alert("Please enter customer first name");
            return false;
        }
        if (createAppointmentAction.config.formCreateCustomer.find("input[name='customer_lname']").val() == '') {
            alert("Please enter customer last name");
            return false;
        }

        var number = createAppointmentAction.config.formCreateCustomer.find("input[name='customer_phone']").val();
        var raw_number = number.replace(/[^0-9]/g,'');
        var phone_regex = /^1?([2-9]..)([2-9]..)(....)$/;
        if (number == '') {
            alert("Please enter customer phone");
            return false;
        } else if (!phone_regex.test(raw_number)) {
            alert("Please enter a valid US phone number");
            return false;
        }

        var email = createAppointmentAction.config.formCreateCustomer.find("input[name='customer_email']").val();
        var email_regex = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
        if (createAppointmentAction.config.formCreateCustomer.find("input[name='customer_email']").val() == '') {
            alert("Please enter customer email");
            return false;
        } else if (!email_regex.test(email)) {
            alert("Please enter a valid email");
            return false;
        }

        if (createAppointmentAction.config.formCreateCustomer.find("input[name='pet_name']").val() == '') {
            alert("Please enter pet name");
            return false;
        }
        if (createAppointmentAction.config.formCreateCustomer.find("input[name='pet_breed']").val() == '') {
            alert("Please enter pet breed");
            return false;
        }
        return true;
    },
    validateCreate: {
        rules: {
            alternate_phone1: {
                phoneUS: true
            },
            alternate_phone2: {
                phoneUS: true
            }
        },
        messages: {
            alternate_phone1: {
                phoneUS: "Please enter a valid US phone number"
            },
            alternate_phone2: {
                phoneUS: "Please enter a valid US phone number"
            }
        }
    },
    // static functions, can be used without init()
    resetForm: function(form) {
        clearEventForm(form);
        form.find("[data-role*='step2']").hide();
        form.find("[data-role*='step1']").hide();
        form.find("[data-role='step1_1']").show();
        form.find(".modal-footer [data-role='step1']").show();
        form.find("button[data-role='submit']").html('ADD');
    },
    openCreateForm: function(form, duration, startDate, startTime) {
        createAppointmentAction.resetForm(form);
        form.find('h4.modal-title').html("Create new Appointment");

        form.find("select[name='duration']").val(duration);
        form.find("input[name='appointment_date']").val(startDate);
        form.find("input[name='appointment_time']").val(startTime);

        form.modal('show');
    },
    openEditForm: function(form, event_id) {
        $.ajax({
            type: 'POST',
            url: createAppointmentAction.config.ajaxRetrieveDescription,
            data: { 'id': event_id, 'mode': 'getInfo' },
            async: false,
            success: function(data) {
                eventData = JSON.parse(data);
                createAppointmentAction.resetForm(form);

                // select services
                var services = eventData.service_list.split(",");
                for (var i = 0; i < services.length; i++) {
                    form.find("select[name='service_list[]']").multiselect('widget').find(":checkbox[value='s" + services[i] + "']").click();
                }
                var packages = eventData.package_list.split(",");
                for (var i = 0; i < packages.length; i++) {
                    form.find("select[name='service_list[]']").multiselect('widget').find(":checkbox[value='p" + packages[i] + "']").click();
                }

                // select preferences
                form.find("input[name='communication_preference'][value='" + eventData.communication_preference + "']").click();
                if (eventData.customer_phone_sms == 1) { form.find("input[name='customer_phone_sms']").prop('checked', true); }
                if (eventData.customer_cellphone_sms == 1) { form.find("input[name='customer_cellphone_sms']").prop('checked', true); }
                if (eventData.customer_alternate_phone1_sms == '1') { form.find("input[name='customer_alternate_phone1_sms']").prop('checked', true); }
                if (eventData.customer_alternate_phone2_sms == '1') { form.find("input[name='customer_alternate_phone2_sms']").prop('checked', true); }

                // remove properties after use
                delete eventData.service_list;
                delete eventData.package_list;
                delete eventData.customer_phone_sms;
                delete eventData.customer_cellphone_sms;
                delete eventData.customer_alternate_phone1_sms;
                delete eventData.customer_alternate_phone2_sms;

                // insert existing data into form
                form.find('h4.modal-title').html("Edit Appointment");
                for (var property in eventData ) {
                    form.find("[name='" + property + "']").val(eventData[property]);
                }
            }
        });

        form.find("[data-role*='step1']").show();
        form.find("button[data-role='submit']").html('EDIT');
        form.modal('show');
    }
};

var appointmentDetailsAction = {
    config: {
        modalViewSelector: '#cal_viewModal',
        modalInvoiceSelector: null,

        // not include in init()
        ajaxEditInvoice: 'ajax/invoice.ajax.php?action=edit',
        eventID: null
    },
    init: function(newSettings) {
        $.extend(appointmentDetailsAction.config, newSettings);
        appointmentDetailsAction.setup();
    },
    setup: function() { 
        appointmentDetailsAction.config.modalViewSelector.on('click', 'a[data-role="view_invoice"]', appointmentDetailsAction.displayInvoice);
        appointmentDetailsAction.config.modalInvoiceSelector.on('click', 'button[data-role="edit-invoice"]', appointmentDetailsAction.editInvoice_display);
        appointmentDetailsAction.config.modalInvoiceSelector.on('focusout', 'input[data-role="editField"]', appointmentDetailsAction.editInvoice_handler);
    },
    displayInvoice: function(event) {
        $.ajax({
            type: 'POST',
            url: 'ajax/appointments.ajax.php',
            async: false,
            data: { 'option': 'getInvoice', 'id': appointmentDetailsAction.config.eventID },
            success: function(data) {
                appointmentDetailsAction.config.modalInvoiceSelector.find(".modal-body").html(data);
                appointmentDetailsAction.config.modalInvoiceSelector.find(".modal").modal('show');
            }
        });
    },
    // enable input field in invoice table to edit data (only discount price atm)
    editInvoice_display: function(event) {
        event.preventDefault();
        var tdObj = appointmentDetailsAction.config.modalInvoiceSelector.find(".invoice-table tr:nth-last-child(2) td:nth-child(2)");
        var currentValue = tdObj.html().substr(1).trim();      // remove $ in the string
        tdObj.html("$").append($("<input type='text' data-role='editField' name='discount' value='" + currentValue + "' />"));
        appointmentDetailsAction.config.modalInvoiceSelector.find("input:nth-child(1)").trigger('focus');
    },
    editInvoice_handler: function(event) {
        var inputObj = $(event.currentTarget);
        var value = inputObj.val();
        var key = inputObj.attr('name');
        if (isNaN(value)) {
            alert("Discount must be a string");
            return false;
        }

        $.ajax({
            type: 'POST',
            url: appointmentDetailsAction.config.ajaxEditInvoice,
            data: { 'key': key, 'value': value, 'app_id': appointmentDetailsAction.config.eventID },
            complete: function() {
                appointmentDetailsAction.config.modalViewSelector.find('a[data-role="view_invoice"]').trigger('click');
            }
        });
    }
};



var calendar = {};
function createCalendar(elementList, calendarOptions) {

	var defaultElementList = {
		calendarSelector: '#calendar',
		ajaxFetchEvent: 'ajax/calendar.ajax.php?option=getAllEvents',
        ajaxFetchTimeOff: 'ajax/calendar.ajax.php?option=getTimeOff',
		ajaxUiUpdate: 'ajax/calendar.ajax.php?option=uiUpdateEvent',
        ajaxChangeStatus: 'ajax/calendar.ajax.php?option=changeStatus',
		ajaxEventSave: 'ajax/calendar.ajax.php?option=createEvent',
		ajaxEventQuickSave: 'includes/cal_quicksave.php',
		ajaxEventDelete: 'ajax/calendar.ajax.php?option=deleteEvent',
		ajaxEventEdit: 'ajax/calendar.ajax.php?option=editEvent',
		ajaxEventExport: 'includes/cal_export.php',
		ajaxRepeatCheck: 'includes/cal_check_rep_events.php',
		ajaxRetrieveDescription: 'ajax/calendar.ajax.php?option=eventDescription',
        ajaxRetrieveHistory: 'ajax/appointments.ajax.php',
		ajaxImport: 'importer.php',
        ajaxCustomerAutocomplete: 'ajax/calendar.ajax.php?option=customerAutocomplete',
        ajaxAddCustomer: 'ajax/calendar.ajax.php?option=createCustomer',
		
		modalViewSelector: '#cal_viewModal',
		modalEditSelector: '#cal_addModal',
        modalCreateSelector: '#cal_addModal',
		modalQuickSaveSelector: '#cal_quickSaveModal',
		modalPromptSelector: '#cal_prompt',
		modalEditPromptSelector: '#cal_edit_prompt_save',
        modalCreateCustomerSelector: '#cal_add_customer',
        modalViewHistorySelector: '#appointment_history',
        formAddEventSelector: 'form#add_event',
		formFilterSelector: 'form#filter-category select',
		formEditEventSelector: 'form#edit_event', // php version
		formSearchSelector:"form#search",
        formAddCustomer: 'form#quickAddPatient',

        btnEditSelector: 'a[data-option="edit"]',
        btnDeleteSelector: 'a[data-option="remove"]',
        btnAddNewSelector: 'a[data-option="add-new"]',
        btnCreateSubmitSelector: 'button[data-role="appointment-submit"]',
        btnEditSubmitSelector: 'button[data-role="appointment-submit"]',
        btnAddCustomerSelector: 'button[data-role="calendar-customer-submit"]',
		
		successAddEventMessage: 'Successfully Added Event',
		successDeleteEventMessage: 'Successfully Deleted Event',
		successUpdateEventMessage: 'Successfully Updated Event',
		failureAddEventMessage: 'Failed To Add Event',
		failureDeleteEventMessage: 'Failed To Delete Event',
		failureUpdateEventMessage: 'Failed To Update Event',
		generalFailureMessage: 'Failed To Execute Action',
		ajaxError: 'Failed to load content'
	};
    var elementOps = $.extend(defaultElementList, elementList);

    var timeoffs = [];

	var defaultsOptions = {
		lang: 'en',
		editable: true,
		eventLimit: true,
		defaultView: 'month',
		aspectRatio: 1.35,
		weekends: true,								// show weekends or not
		weekNumbers: false, 						// show week numbers (true) or not (false)
		weekNumberCalculation: 'iso',
		weekNumberTitle: 'W',
		titleFormat: {
			month: '',
			week: '',
			day: ''
		},
		columnFormat: {
			month: '',
			week: '',
			day: ''
		},
		isRTL: false,
		hiddenDays: [],								// hide specific dates
		theme: false,
		buttonIcons: {
			prev: "left-single-arrow",
			next: "right-single-arrow",
			prevYear: "left-double-arrow",
			nextYear: "right-double-arrow"
		},
		themeButtonIcons: {
			prev: 'circle-triangle-w',
			next: 'circle-triangle-e'
		},
		weekMode: 'fixed', 							// 'fixed', 'liquid', 'variable'
		allDaySlot: true, 							// true, false
		allDayText: 'all-day',
		axisFormat: 'h(:mm)a',
		slotDuration: '00:30:00',					// interval between each line in calendar
		minTime: '00:00:00',
		maxTime: '24:00:00',
		slotEventOverlap: true,
		timeFormat: 'H:mm',
		header: {
				left: 'prev,next',
				center: 'title',
				right: 'month,' + 'agendaWeek' + ',' + 'agendaDay'
		},
		monthNames: ['January','February','March','April','May','June','July','August','September','October','November','December'],
		monthNamesShort: ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
		dayNames: ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'],
		dayNamesShort: ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'],
		buttonText: {
			today: 'today',
			month: 'month',
			week: 'week',
			day: 'day'
		},
		ignoreTimezone: false,
		firstDay: 0,
		lazyFetching: true,

		selectable: true,
		selectHelper: true,
        selectOverlap: false,
		select: function(start, end, jsEvent, view) {

			calendar.view = view.name;
            calendar.start = start;
            calendar.end = end;

            calendar.openModal('', 'create');

            // if (moment().isBefore(start)) {
            //     calendar.openModal('', 'create');
            // } else {
            //     alert("Cannot create event in the past");
            //     $(elementOps.calendarSelector).fullCalendar('unselect');
            // }
		},
		eventSources: [
            { url: elementOps.ajaxFetchEvent, allDayDefault: false },
            { url: elementOps.ajaxFetchTimeOff, allDayDefault: false, overlap: false, editable: false }
        ],
		eventDrop: function(event) { 
			var ed_startDate = moment(event.start).format('YYYY-MM-DD');
			var ed_startTime = moment(event.start).format('HH:mm');
			var ed_endDate = moment(event.end).format('YYYY-MM-DD');
			var ed_endTime = moment(event.end).format('HH:mm');
			
            var params = {
                'start': ed_startDate + ' ' + ed_startTime,
                'end': ed_endDate + ' ' + ed_endTime,
                'id': event.id
            };
			$.post(elementOps.ajaxUiUpdate, params, function(response) {
				$(elementOps.calendarSelector).fullCalendar('refetchEvents');
			});
		},
		eventResize: function(event) { 
			var er_startDate = moment(event.start).format('YYYY-MM-DD');
			var er_startTime = moment(event.start).format('HH:mm');
			var er_endDate = moment(event.end).format('YYYY-MM-DD');
			var er_endTime = moment(event.end).format('HH:mm');

            var params = {
                'start': er_startDate + ' ' + er_startTime,
                'end': er_endDate + ' ' + er_endTime,
                'id': event.id
            };

			$.post(elementOps.ajaxUiUpdate, params, function(response) {
				$(elementOps.calendarSelector).fullCalendar('refetchEvents');
			});
		},
		eventRender: function(event, element, view) {
            var d_color = event.color;
            var d_startDate = moment(event.start).format('YYYY-MM-DD');
            var d_startTime = moment(event.start).format('HH:mm');
			var d_endDate = moment(event.end).format('YYYY-MM-DD');
			var d_endTime = moment(event.end).format('HH:mm');
			
			var e_val = moment(event.end).isValid();
			if(e_val == false) {
				var d_endDate = d_startDate; 
				var d_endTime = d_startTime; 
			}
			
			if(event.end !== null && view.name == 'month') {
				timeformat = event.start.format('H:mm') + ' - ' + event.end.format('H:mm');
				element.find('.fc-time').html(timeformat);	
			}

            if (event.className != "disabled") {
                element.attr('data-toggle', 'modal');
                element.attr('href', 'javascript:void(0)');
                element.attr('onclick', 'calendar.openModal(' + event.id + ', "details");');
            }
		},
		eventAfterRender: function(event, element, view) {
			element.find('div.fc-title').html(event.pets + " - " + event.title);
		}
	};
	var ops = $.extend(defaultsOptions, calendarOptions);

	$(elementOps.calendarSelector).fullCalendar(ops);
    // -------------------------- end initializing fullCalendar ----------------------
    // -------------------------- start event behavior -------------------------------

    createAppointmentAction.init({
        calendarSelector: $(elementOps.calendarSelector),
        formCreate: $(elementOps.modalCreateSelector),
        formCreateCustomer: $(elementOps.modalCreateCustomerSelector)
    });

    appointmentDetailsAction.init({
        modalViewSelector: $(elementOps.modalViewSelector),
        modalInvoiceSelector: $("#invoice_container")
    });

    // open details modal
    calendar.openModal = function(id, type) {
        if (type == "details") {
            calendar.id = id;
            return calendar.openDetails();
        }
        else if (type == "edit") {
            return calendar.openEdit();
        }
        else if (type == "create") {
            return calendar.openCreate();
        }
    }

    calendar.openDetails = function() {
        appointmentDetailsAction.config.eventID = calendar.id;
        $.ajax({
            type: 'POST',
            url: elementOps.ajaxRetrieveDescription,
            data: { 'id': calendar.id },
            async: false,
            datatype: 'json',
            success: function(data) {
                var d = JSON.parse(data);
                $(elementOps.modalViewSelector).find("[data-role='appointment-details']").html(d.description);
                $(elementOps.modalViewSelector).find("input[name='status'][value='" + d.status + "']").prop('checked', true);
            }
        });
        $(elementOps.modalViewSelector).modal('show');
    }

    calendar.openEdit = function() {
        createAppointmentAction.openEditForm($(elementOps.modalEditSelector), calendar.id);
    }

    calendar.openCreate = function() {
        var duration = (calendar.end - calendar.start)/60000;
        var startDate = calendar.start.format("YYYY-MM-DD");
        var startTime = calendar.start.format("HH:mm");

        createAppointmentAction.openCreateForm($(elementOps.modalCreateSelector), duration, startDate, startTime);
    }

    $('a[data-role="new_appointment"]').on('click', function() {
        createAppointmentAction.resetForm($(elementOps.modalCreateSelector));
    });

    // change status to paid/checkin in View Appointment dialog
    // change color to orange if checkin, green if paid
    $(elementOps.modalViewSelector).find("input[name='status']").on('click', function(event) {
        var value = $(event.currentTarget).val();
        $.ajax({
            type: 'POST',
            url: elementOps.ajaxChangeStatus,
            data: { 'status': value, 'id': calendar.id },
            success: function() {
                $(elementOps.calendarSelector).fullCalendar('refetchEvents');
            }
        });
    });

    // open edit modal
    $(elementOps.modalViewSelector).find(elementOps.btnEditSelector).on('click', function() {
        $(elementOps.modalViewSelector).modal('hide');
        calendar.openModal('', 'edit');
    });
    // cancel event
    $(elementOps.modalViewSelector).find(elementOps.btnDeleteSelector).on('click', function() {
        $.ajax({
            type: 'POST',
            url: elementOps.ajaxEventDelete,
            data: { 'id': calendar.id },
            success: function() {
                $(elementOps.modalViewSelector).modal('hide');
                $(elementOps.calendarSelector).fullCalendar('refetchEvents');
            }
        });
    });

    // copy time and duration to create form
    $(elementOps.modalViewSelector).find(elementOps.btnAddNewSelector).on('click', function() {
        $.ajax({
            type: 'POST',
            url: elementOps.ajaxRetrieveDescription,
            data: { 'id': calendar.id, 'mode': 'getInfo' },
            async: false,
            success: function(data) {
                eventData = JSON.parse(data);
                createAppointmentAction.openCreateForm($(elementOps.modalCreateSelector), eventData.visit_duration, eventData.appointment_date, eventData.appointment_time);
            }
        });
        $(elementOps.modalViewSelector).modal('hide');
    });

    // multiselect
    $(elementOps.modalCreateSelector).find("select[name='service_list[]']").multiselect({
        appendTo: elementOps.modalCreateSelector
    });
}
