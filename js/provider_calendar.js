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
	$(form).find('input').val('');
	$(form).find("input[name='form_type']").val('add');
	$(form).find("input[name='color']").spectrum('set', '#0000FF');
	
	$(form).find("textarea").each(function() { $(this).val(""); });
	$(form).find('select[multiple="multiple"] option:selected').each(function() {
		$(this).prop('selected', false);
	});	 
	$(form).find('select[multiple="multiple"]').multiselect('refresh');
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
    return result;
}

var calendar = {};
function createCalendar(elementList, calendarOptions) {

	var defaultElementList = {
		calendarSelector: '#calendar',
		ajaxFetchEvent: 'ajax/calendar.ajax.php?option=getAllEvents',
        ajaxFetchTimeOff: 'ajax/calendar.ajax.php?option=getTimeOff',
		ajaxUiUpdate: 'ajax/calendar.ajax.php?option=uiUpdateEvent',
		ajaxEventSave: 'ajax/calendar.ajax.php?option=createEvent',
		ajaxEventQuickSave: 'includes/cal_quicksave.php',
		ajaxEventDelete: 'ajax/calendar.ajax.php?option=deleteEvent',
		ajaxEventEdit: 'ajax/calendar.ajax.php?option=editEvent',
		ajaxEventExport: 'includes/cal_export.php',
		ajaxRepeatCheck: 'includes/cal_check_rep_events.php',
		ajaxRetrieveDescription: 'ajax/calendar.ajax.php?option=eventDescription',
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

            if (moment().isBefore(start)) {
                calendar.openModal('', 'create');
            } else {
                alert("Cannot create event in the past");
                $(elementOps.calendarSelector).fullCalendar('unselect');
            }

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
			element.find('div.fc-title').html(event.name);
		}
	};
	var ops = $.extend(defaultsOptions, calendarOptions);

	$(elementOps.calendarSelector).fullCalendar(ops);
    // -------------------------- end initializing fullCalendar ----------------------
    // -------------------------- start event behavior -------------------------------
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
        $.ajax({
            type: 'POST',
            url: elementOps.ajaxRetrieveDescription,
            data: { 'id': calendar.id },
            async: false,
            success: function(data) {
                $(elementOps.modalViewSelector).find(".modal-body").html(data);
            }
        });
        $(elementOps.modalViewSelector).modal('show');
    }

    calendar.openEdit = function() {
        $.ajax({
            type: 'POST',
            url: elementOps.ajaxRetrieveDescription,
            data: { 'id': calendar.id, 'mode': 'getInfo' },
            async: false,
            success: function(data) {
                eventData = JSON.parse(data);
                $(elementOps.modalEditSelector).find('h4.modal-title').html("Edit Appointment");
                $(elementOps.modalEditSelector).find("input[name='appointment_id']").val(eventData.id);
                $(elementOps.modalEditSelector).find("input[name='appointment_customer_id']").val(eventData.customer_id);
                $(elementOps.modalEditSelector).find("input[name='customer_name']").val(eventData.first_name + " " + eventData.last_name);
                $(elementOps.modalEditSelector).find("input[name='appointment_date']").val(eventData.appointment_date);
                $(elementOps.modalEditSelector).find("input[name='appointment_time']").val(eventData.appointment_time);
                $(elementOps.modalEditSelector).find("select[name='duration']").val(eventData.visit_duration);
                $(elementOps.modalEditSelector).find("input[name='color']").spectrum("set", eventData.color);

                var services = eventData.service_list.split(",");
                for (var i = 0; i < services.length; i++) {
                    $(elementOps.modalEditSelector).find("select[name='service_list[]']").multiselect('widget').find(":checkbox[value='s" + services[i] + "']").click();
                }
                var packages = eventData.package_list.split(",");
                for (var i = 0; i < packages.length; i++) {
                    $(elementOps.modalEditSelector).find("select[name='service_list[]']").multiselect('widget').find(":checkbox[value='p" + packages[i] + "']").click();
                }
            }
        });
        $(elementOps.modalEditSelector).modal('show');
    }

    calendar.openCreate = function() {
        var duration = (calendar.end - calendar.start)/60000;
        var startDate = calendar.start.format("YYYY-MM-DD");
        var startTime = calendar.start.format("HH:mm");
        $(elementOps.modalCreateSelector).find('h4.modal-title').html("Create new Appointment");
        $(elementOps.modalCreateSelector).find("select[name='duration']").val(duration);
        $(elementOps.modalCreateSelector).find("input[name='appointment_date']").val(startDate);
        $(elementOps.modalCreateSelector).find("input[name='appointment_time']").val(startTime);

        $(elementOps.modalCreateSelector).modal('show');
    }

    // open edit modal
    $(elementOps.modalViewSelector).find(elementOps.btnEditSelector).on('click', function() {
        $(elementOps.modalViewSelector).modal('hide');
        calendar.openModal('', 'edit');
    });

    // edit event
    $(elementOps.modalEditSelector).find(elementOps.btnEditSubmitSelector).on('click', function() {
        if ($(elementOps.modalEditSelector).find("input[name='appointment_id']").val() != '') {
            var data = $(elementOps.modalEditSelector).find("form").serialize();
            $.ajax({
                type: 'POST',
                url: elementOps.ajaxEventEdit,
                data: data,
                success: function() {
                    $(elementOps.modalEditSelector).modal('hide');
                    $(elementOps.calendarSelector).fullCalendar('refetchEvents');
                }
            });
        }
    });

    // calendar form validation
    $(elementOps.modalCreateSelector).find('#form-appointment').validate({
        rules: {
            customer_phone: {
                required: true
            },
            'service_list[]': {
                required: true
            }
        },
        messages: {
            customer_phone: {
                required: "Please enter customer name"
            },
            'service_list[]': {
                required: true
            }
        }
    });

    // submit new event
    $(elementOps.modalCreateSelector).find(elementOps.btnCreateSubmitSelector).on('click', function() {
        if ($(elementOps.modalCreateSelector).find("input[name='appointment_id']").val() == '') {
            if ($(elementOps.modalCreateSelector).find("input[name='appointment_customer_id']").val() == '') {
                alert("Invalid customer");
                return false;
            }

            if (!$(elementOps.modalCreateSelector).find('#form-appointment').valid()) { return false; }

            var data = $(elementOps.modalCreateSelector).find("form").serializeArray();
            data.color = $(elementOps.modalCreateSelector).find("input[name='color']").val();
            $.ajax({
                type: 'POST',
                url: elementOps.ajaxEventSave,
                data: data,
                success: function() {
                    $(elementOps.modalCreateSelector).modal('hide');
                    clearEventForm(elementOps.modalCreateSelector);
                    $(elementOps.calendarSelector).fullCalendar('refetchEvents');
                }
            });
        }
    });

    // submit new customer
    $(elementOps.modalCreateCustomerSelector).find(elementOps.btnAddCustomerSelector).on('click', function() {
        var data = $(elementOps.modalCreateCustomerSelector).find("form").serialize();
        var fname = $(elementOps.modalCreateCustomerSelector).find("input[name='customer_fname']").val();
        var lname = $(elementOps.modalCreateCustomerSelector).find("input[name='customer_lname']").val();
        $.ajax({
            type: 'POST',
            url: elementOps.ajaxAddCustomer,
            data: data,
            success: function(response) {
                $(elementOps.modalCreateSelector).find("input[name='appointment_customer_id']").val(response);
                $(elementOps.modalCreateSelector).find("input[name='customer_name']").val(fname + " " + lname);
                $(elementOps.modalCreateCustomerSelector).modal('hide');
            }
        });
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
                $(elementOps.modalCreateSelector).find('h4.modal-title').html("Create New Appointment");
                $(elementOps.modalCreateSelector).find("input[name='appointment_date']").val(eventData.appointment_date);
                $(elementOps.modalCreateSelector).find("input[name='appointment_time']").val(eventData.appointment_time);
                $(elementOps.modalCreateSelector).find("select[name='duration']").val(eventData.visit_duration);
            }
        });
        $(elementOps.modalViewSelector).modal('hide');
        $(elementOps.modalCreateSelector).modal('show');
    });

    // autocomplete customer details
    $(elementOps.modalCreateSelector).find("input[name='customer_name']").autocomplete({
        source: elementOps.ajaxCustomerAutocomplete,
        appendTo: elementOps.modalCreateSelector,
        focus: function(event, ui) {
            // prevent autocomplete from updating the textbox
            event.preventDefault();
            return false;
        },
        select: function(event, ui) {
            // prevent autocomplete from updating the textbox
            event.preventDefault();
            // manually update the textbox and hidden field
            $(this).val(ui.item.label);
            $(elementOps.modalCreateSelector).find("input[name='appointment_customer_id']").val(ui.item.value);
            $(elementOps.modalCreateSelector).find("input[name='customer_phone']").val(ui.item.phone);
            $(elementOps.modalCreateSelector).find("input[name='customer_email']").val(ui.item.email);
            $(elementOps.modalCreateSelector).find("input[name='customer_pets']").val(ui.item.pets);
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

    // multiselect
    $(elementOps.modalCreateSelector).find("select[name='service_list[]']").multiselect({
        appendTo: elementOps.modalCreateSelector
    });
}
