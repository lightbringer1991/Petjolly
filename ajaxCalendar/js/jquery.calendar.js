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
	$(form).find("input[name='color']").spectrum('set', '#587ca3');
	
	$(form).find("textarea").each(function() { $(this).val(""); });
	$(form).find('select[multiple="multiple"] option:selected').each(function() {
		$(this).prop('selected', false);
	});	 
	$(form).find('select[multiple="multiple"]').multiselect('refresh');
}
 
(function($, undefined) 
{
	$.fn.extend 
	({
		// FullCalendar Extendable Plugin
		FullCalendarExt: function(options) 
		{	
			// Default Configurations (General)
            var defaults = 
			{
				calendarSelector: '#calendar',
				ajaxJsonFetch: 'includes/cal_events.php',
				ajaxUiUpdate: 'includes/cal_update.php',
				ajaxEventSave: 'includes/cal_save.php',
				ajaxEventQuickSave: 'includes/cal_quicksave.php',
				ajaxEventDelete: 'includes/cal_delete.php',
				ajaxEventEdit: 'includes/cal_edit_update.php',
				ajaxEventExport: 'includes/cal_export.php',
				ajaxRepeatCheck: 'includes/cal_check_rep_events.php',
				ajaxRetrieveDescription: 'includes/cal_description.php',
				ajaxImport: 'importer.php',
				
				modalViewSelector: '#cal_viewModal',
				modalEditSelector: '#cal_editModal',
				modalQuickSaveSelector: '#cal_quickSaveModal',
				modalPromptSelector: '#cal_prompt',
				modalEditPromptSelector: '#cal_edit_prompt_save',
				formAddEventSelector: 'form#add_event',
				formFilterSelector: 'form#filter-category select',
				formEditEventSelector: 'form#edit_event', // php version
				formSearchSelector:"form#search",
				
				successAddEventMessage: 'Successfully Added Event',
				successDeleteEventMessage: 'Successfully Deleted Event',
				successUpdateEventMessage: 'Successfully Updated Event',
				failureAddEventMessage: 'Failed To Add Event',
				failureDeleteEventMessage: 'Failed To Delete Event',
				failureUpdateEventMessage: 'Failed To Update Event',
				generalFailureMessage: 'Failed To Execute Action',
				ajaxError: 'Failed to load content',
				
				visitUrl: 'Visit Url:',
				titleText: 'Title:',
				descriptionText: 'Description:',
				colorText: 'Color:',
				startDateText: 'Start Date:',
				startTimeText: 'Start Time:',
				endDateText: 'End Date:',
				endTimeText: 'End Time:',
				categoryText: 'Category:',
				eventText: 'Event: ',
				repetitiveEventActionText: 'This is a repetitive event, what do you want to do?',
								
				isRTL: false,				
				monthNames: ['January','February','March','April','May','June','July','August','September','October','November','December'],
				monthNamesShort: ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
				dayNames: ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'],
				dayNamesShort: ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'],
				today: 'today',
				month: 'month',
				week: 'week',
				day: 'day',
				weekNumberTitle: 'W',
				allDayText: 'all-day', 
				
				defaultColor: '#587ca3',
				
				weekType: 'agendaWeek', // basicWeek
				dayType: 'agendaDay', // basicDay
				
				editable: true,
				ignoreTimezone: true,
				lazyFetching: true,
				filter: true,
				quickSave: true,
				firstDay: 0,
				
				gcal: false,
				
				version: 'modal',
				
				quickSaveCategory: '',
				
				colorpickerArgs: {format: 'hex'},
				
				defaultView: 'month', // basicWeek or basicDay or agendaWeek
				aspectRatio: 1.35, // will make day boxes bigger
				weekends: true, // show (true) the weekend or not (false)
				weekNumbers: false, // show week numbers (true) or not (false)
				weekNumberCalculation: 'iso',
				
				hiddenDays: [], // [0,1,2,3,4,5,6] to hide days as you wish
				
				theme: false,
				themePrev: 'circle-triangle-w',
				themeNext: 'circle-triangle-e',
				
				titleFormatMonth: '',
				titleFormatWeek: '',
				titleFormatDay: '',
				columnFormatMonth: '',
				columnFormatWeek: '',
				columnFormatDay: '',
				timeFormat: 'H:mm',
				
				weekMode: 'fixed', // 'fixed', 'liquid', 'variable'
				
				allDaySlot: true, // true, false
				axisFormat: 'h(:mm)a',
				
				slotDuration: '00:30:00',
				minTime: '00:00:00',
				maxTime: '24:00:00',
				
				slotEventOverlap: true,
								
				savedRedirect: 'index.php',
				removedRedirect: 'index.php',
				updatedRedirect: 'index.php',
				
				ajaxLoaderMarkup: '<div class="loadingDiv"></div>',
				prev: "left-single-arrow",
				next: "right-single-arrow",
				prevYear: "left-double-arrow",
				nextYear: "right-double-arrow",  
				
				otherSource: '',
				
				eventLimit: true,
				palette: [
							["#0b57a4","#8bbdeb","#000000","#2a82d7","#148aa5","#3714a4","#587ca3","#a50516"],
							["#fb3c8f","#1b4f15","#1b4f15","#686868","#3aa03a","#ff0080","#fee233","#fc1cad"],
							["#7f2b14","#000066","#2b4726","#fd7222","#fc331c","#af31f2","#fc0d1b","#2b8a6d"],
							["#ea9999","#f9cb9c","#ffe599","#b6d7a8","#a2c4c9","#9fc5e8","#b4a7d6","#d5a6bd"]
						]
            }

			var ops =  $.extend(defaults, options);
			
			var opt = ops;
									
			if(opt.gcal == true) { opt.weekType = ''; opt.dayType = ''; }
			
			// fullCalendar
			$(opt.calendarSelector).fullCalendar
			({
				lang: 'en',
				editable: opt.editable,
				eventLimit: opt.eventLimit,
				
				defaultView: opt.defaultView,
				aspectRatio: opt.aspectRatio,
				weekends: opt.weekends,
				weekNumbers: opt.weekNumbers,
				weekNumberCalculation: opt.weekNumberCalculation,
				weekNumberTitle: opt.weekNumberTitle,
				titleFormat: {
					month: opt.titleFormatMonth,
					week: opt.titleFormatWeek,
					day: opt.titleFormatDay
				},
				columnFormat: {
					month: opt.columnFormatMonth,
					week: opt.columnFormatWeek,
					day: opt.columnFormatDay
				},
				isRTL: opt.isRTL,
				hiddenDays: opt.hiddenDays,
				theme: opt.theme,
				buttonIcons: {
					prev: opt.prev,
					next: opt.next,
					prevYear: opt.prevYear,
					nextYear: opt.nextYear
				},
				themeButtonIcons: {
					prev: opt.themePrev,
					next: opt.themeNext
				},
				weekMode: opt.weekMode,
				allDaySlot: opt.allDaySlot,
				allDayText: opt.allDayText,
				axisFormat: opt.axisFormat,
				slotDuration: opt.slotDuration,
				minTime: opt.minTime,
				maxTime: opt.maxTime,
				slotEventOverlap: opt.slotEventOverlap,
				
				timeFormat: opt.timeFormat,
				header: 
				{
						left: 'prev,next',
						center: 'title',
						right: 'month,'+opt.weekType+','+opt.dayType	
				},
				monthNames: opt.monthNames,
				monthNamesShort: opt.monthNamesShort,
				dayNames: opt.dayNames,
				dayNamesShort: opt.dayNamesShort,
				buttonText: {
					today: opt.today,
					month: opt.month,
					week: opt.week,
					day: opt.day
				},
				ignoreTimezone: opt.ignoreTimezone,
				firstDay: opt.firstDay,
				lazyFetching: opt.lazyFetching,
				selectable: opt.quickSave,
				selectHelper: opt.quickSave,
				select: function(start, end, allDay, view) 
				{ 
					calendar.view = view.name;
					if(opt.version == 'modal')
					{
						calendar.quickModal(start, end, allDay);
						$(opt.calendarSelector).fullCalendar('unselect');
					}
				},
				eventSources: [opt.otherSource, {url: opt.ajaxJsonFetch, allDayDefault: false}],
				eventDrop: 
					function(event) 
					{ 
						var ed_startDate = moment(event.start).format('YYYY-MM-DD');
						var ed_startTime = moment(event.start).format('HH:mm');
						var ed_endDate = moment(event.end).format('YYYY-MM-DD');
						var ed_endTime = moment(event.end).format('HH:mm');
						
						var e_val = moment(event.end).isValid();
						
						if(event.end === null || event.end === 'null' || e_val == false)
						{ 
							Eend = ed_startDate+' '+ed_startTime;
							EaD = event.allDay;	
						} else {
							Eend = ed_endDate+' '+ed_endTime;
							EaD = event.allDay;	
						}
						
						var theEvent = 'start=' + ed_startDate + ' ' + ed_startTime + 
									   '&end=' + Eend +
									   '&id=' + event.id + 
									   '&allDay=' + EaD + 
									   '&original_id=' + event.original_id;
						
						$.post(opt.ajaxUiUpdate, theEvent, function(response) {
							$(opt.calendarSelector).fullCalendar('refetchEvents');
						});
					},
				eventResize: function(event) { 
					var er_startDate = moment(event.start).format('YYYY-MM-DD');
					var er_startTime = moment(event.start).format('HH:mm');
					var er_endDate = moment(event.end).format('YYYY-MM-DD');
					var er_endTime = moment(event.end).format('HH:mm');
					
					var e_val = moment(event.end).isValid();
					
					if(event.end === null || event.end === 'null' || e_val == false)
					{
						Eend = er_startDate+' '+er_startTime;
						EaD = 'false';		
					} else {
						Eend = er_endDate+' '+er_endTime;
						EaD = event.allDay;	
					}
					
					var theEvent = 'start=' + er_startDate + ' ' + er_startTime + 
								   '&end=' + Eend +
								   '&id=' + event.id + 
								   '&allDay=' + EaD + 
								   '&original_id=' + event.original_id;
					
					$.post(opt.ajaxUiUpdate, theEvent, function(response) {
						$(opt.calendarSelector).fullCalendar('refetchEvents');
					});
				},
				eventRender: 
					function(event, element, view) {	
						var d_color = event.color;	
						var d_startDate = moment(event.start).format('YYYY-MM-DD');
						var d_startTime = moment(event.start).format('HH:mm');
						var d_endDate = moment(event.end).format('YYYY-MM-DD');
						var d_endTime = moment(event.end).format('HH:mm');
						
						var e_val = moment(event.end).isValid();
						if(e_val == false) 
						{ 
							var d_endDate = d_startDate; 
							var d_endTime = d_startTime; 
						}
						
						if(event.end !== null && view.name == 'month')
						{
							timeformat = event.start.format('H:mm') + ' - ' + event.end.format('H:mm');
							element.find('.fc-time').html(timeformat);	
						}
						
						if(opt.version == 'modal')
						{	
							// Open action  (modalView Mode)
							element.attr('data-toggle', 'modal');
							element.attr('href', 'javascript:void(0)');
							element.attr('onclick', 'calendar.openModal("' + event.title + '","' + event.url + '","' + event.original_id + '","' + event.id + '","' + event.start + '","' + event.end + '","' + d_color + '","' + d_startDate + '","' + d_startTime + '","' + d_endDate + '","' + d_endTime + '");');  
						} 
					},
				eventAfterRender: function(event, element, view) {
					element.find('div.fc-title').html(event.name);
				}
			}); //fullCalendar
				
				 // Function to Open Modal
				calendar.openModal = function(title, url, id, rep_id, eStart, eEnd, color, startDate, startTime, endDate, endTime)
				{
					 $(".modal-body").html(opt.ajaxLoaderMarkup); // clear data
					 
					 // Setup variables
					 calendar.title = title;
					 calendar.url = url;
					 calendar.id = id;
					 calendar.rep_id = rep_id;
					 
					 calendar.eventStart = eStart;
					 calendar.eventEnd = eEnd;
					  
					 calendar.color = color;	
					 calendar.startDate = startDate;
					 calendar.startTime = startTime;
					 calendar.endDate = endDate;
					 calendar.endTime = endTime;
					 
					 ExpS = startDate + ' ' + startTime; 
					 ExpE = endDate+' '+endTime;
 					  
					 var dataString = 'id=' + calendar.id;
					  
					  $.ajax({
						type: "POST",
						url: opt.ajaxRetrieveDescription,
						data: dataString,
						cache: false,
						beforeSend: function() { $('.loadingDiv').show(); $('.modal-footer').hide() },
						error: function() { $('.loadingDiv').hide(); alert(opt.ajaxError) },
						success: function(dsc) 
						{
							description = dsc.replace('$null', '');
							
							$('.loadingDiv').hide(); 
							$('.modal-footer').show();
							if(calendar.url === 'undefined' || calendar.url === undefined) 
					 		{
					  			$(".modal-body").html(opt.ajaxLoaderMarkup+description); 
					  		} else {
					  			$(".modal-body").html(opt.ajaxLoaderMarkup+description+'<br /><br />'+opt.visitUrl+' <a href="'+calendar.url+'">'+calendar.url+'</a>'); 	  
					  		}
							
							// Delete button
							$(".modal-footer").delegate('[data-option="remove"]', 'click', function(e) 
							{
								calendar.remove(calendar.id);	
								e.preventDefault();
							 });
							 
							 // Export button
							$(".modal-footer").delegate('[data-option="export"]', 'click', function(e) 
							{
								calendar.exportIcal(calendar.id, calendar.title, description, ExpS, ExpE, calendar.url);	
								e.preventDefault();
							 });
						}
					  });
					  									
					  $(".modal-header").html('<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>'+'<h4>'+calendar.title+'</h4>'); 
					  
					  $(opt.modalViewSelector).modal('show');
						
					  	// Edit Button
						$(".modal-footer").delegate('[data-option="edit"]', 'click', function(e) {
							$(opt.modalViewSelector).modal('hide');
//							$(".modal-body").html(opt.ajaxLoaderMarkup); // clear data
							var dataString2 = 'id=' + calendar.id + '&mode=getInfo';
							
							$.ajax({
								type: "POST",
								url: opt.ajaxRetrieveDescription,
								data: dataString2,
								cache: false,
//								beforeSend: function() { $('.loadingDiv').show(); $('.modal-footer').hide() },
//								error: function() { $('.loadingDiv').hide(); alert(opt.ajaxError) },
								success: function(json_enc) { 
									$(opt.modalEditSelector).find('button[type="submit"]').html("Edit Event");
									$(opt.modalEditSelector).find("input[name='form_type']").val("edit");
									var json = $.parseJSON(json_enc);
									$(opt.modalEditSelector).find("input[name='c_name']").val(json.customer_name);
									$(opt.modalEditSelector).find("input[name='c_id']").val(json.customer_id);
									$(opt.modalEditSelector).find("input[name='appointment_date']").val(json.start_date);
									$(opt.modalEditSelector).find("input[name='appointment_time']").val(json.start_time);
									$(opt.modalEditSelector).find("input[name='visit_duration']").val(json.duration);
									$(opt.modalEditSelector).find("input[name='color']").spectrum("set", json.color);									
									
									var specialities = json.speciality.split(",");
									$(opt.modalEditSelector).find("select[name='speciality_selector[]']").multiselect('select', specialities);
									
									$(opt.modalEditSelector).find("input[name='app_id']").val(calendar.id);

									$('.loadingDiv').hide(); 
									$('.modal-footer').show();									
								}
					  		});

							$(opt.modalEditSelector).modal('show'); 
							
							  // On Modal Hidden
							$(opt.modalEditSelector).on('hidden.bs.modal', function() {
								clearEventForm(opt.modalEditSelector);
								// $(opt.calendarSelector).fullCalendar('refetchEvents'); (by uncommenting this fixes multiply loads bug)
							 });
							 
							 // Close Button - This is due cache to prevent data being saved on another view
							 $(".modal-footer").delegate('[data-dismiss="modal"]', 'click', function(e) 
							 {
								 $('.modal-body').html(''); // clear data
								 // $(opt.calendarSelector).fullCalendar('refetchEvents'); (by uncommenting this fixes multiply loads bug)
								 e.preventDefault();
							 });
						 	 
							// After all step above save
							// Update button
							$(".modal-footer").off('click').delegate('[data-option="save"]', 'click', function(e) 
							{	
								var event_title_e = $(opt.modalEditSelector+" form#event_title_e").serializeArray(); 
								var event_description_e = $(opt.modalEditSelector+" form#event_description_e").serializeArray();
								var event_url = $(opt.modalEditSelector+" form#event_description_e").serializeArray();
								
								if(opt.quickSaveCategory !== '')
								{
									if(calendar.url === 'undefined')
									{
										var theEvent = {
//											'title_update' : event_title_e[0].value,
//											'description_update' : event_description_e[0].value,
//											'color_update' : event_description_e[1].value,
											'update_start_date' : event_description_e[0].value,
											'update_start_time' : event_description_e[1].value,
											'update_duration': event_description_e[2].value,
//											'update_end_date' : event_description_e[4].value,
//											'update_end_time' : event_description_e[5].value,
//											'categorie' : event_description_e[6].value
										}	
									} else {
										var theEvent = {
//											'title_update' : event_title_e[0].value,
//											'description_update' : event_description_e[0].value,
//											'color_update' : event_description_e[1].value,
											'update_start_date' : event_description_e[0].value,
											'update_start_time' : event_description_e[1].value,
											'update_duration': event_description_e[2].value,
//											'update_end_date' : event_description_e[4].value,
//											'update_end_time' : event_description_e[5].value,
//											'url_update' : event_description_e[6].value,
//											'categorie' : event_description_e[7].value
										}		
									}
								} else {
									if(calendar.url === 'undefined')
									{
										var theEvent = {
//											'title_update' : event_title_e[0].value,
//											'description_update' : event_description_e[0].value,
//											'color_update' : event_description_e[1].value,
											'update_start_date' : event_description_e[0].value,
											'update_start_time' : event_description_e[1].value,
											'update_duration': event_description_e[2].value,
//											'update_end_date' : event_description_e[4].value,
//											'update_end_time' : event_description_e[5].value
										}	
									} else {
										var theEvent = {
//											'title_update' : event_title_e[0].value,
//											'description_update' : event_description_e[0].value,
//											'color_update' : event_description_e[1].value,
											'update_start_date' : event_description_e[0].value,
											'update_start_time' : event_description_e[1].value,
											'update_duration': event_description_e[2].value,
//											'update_end_date' : event_description_e[4].value,
//											'update_end_time' : event_description_e[5].value,
//											'url_update' : event_description_e[6].value
										}		
									}	
								}
								
								calendar.update(calendar.id, theEvent);
								
								e.preventDefault();
							});
							 
							e.preventDefault();
						});		// end Edit button
						
				} // openModal

				// Function to quickModal
				calendar.quickModal = function(start, end, allDay)
				{
					var newPatientFormID = "cal_add_patient";
					
					$(".modal-header").html(
						'<form id="event_title">' +
							'<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>' +
							'<label>'+opt.titleText+' </label>' +
							'<input type="text" class="form-control" name="appointment_number" placeholder="Appointment Number" />' +
						'</form>'
						);
						
					$("#cal_add_patient input[name='parent_form_id']").val("event_description");
					
					$(".modal-body").html(
						'<form id="event_description">' +
							'<div class="pull-left mr-10" style="width: 300px;">' + 
								'<label>Patient Email</label>' + 
								'<input type="text" class="form-control" name="p_email"/>' + 
							'</div>' + 
							'<div class="pull-left mr-10" style="width: 180px;">' + 
								'<label>Patient Phone Number</label>' + 
								'<input type="text" class="form-control" name="p_number" />' + 
							'</div> <div class="clearfix"></div>' +
							'<div data-class="patient_error" style="color: red;"></div><div class="clearfix"></div>' + 
							'<label>'+opt.descriptionText+' </label>' +
						    '<textarea class="form-control" name="description"></textarea>' + opt.quickSaveCategory +
							'<div class="pull-left mr-10">' +
								'<label>Duration (minutes)</label>' +
								'<input type="text" class="form-control input-sm" name="visit_duration" value="' + (end - start)/60000 + '"/>' +
							'</div>' +
							'<input type="hidden" name="p_id" value="" />' + 
						 '</form>'
						 );
						 
					var duration = (end - start)/60000;
					$(opt.modalQuickSaveSelector).find("input[name='appointment_date']").val(start.format('YYYY-MM-DD'));
					$(opt.modalQuickSaveSelector).find("input[name='appointment_time']").val(start.format('HH:mm'));
					$(opt.modalQuickSaveSelector).find("input[name='visit_duration']").val(duration);
					$(opt.modalQuickSaveSelector).modal('show');
					
					calendar.start = start;
					calendar.end = end;
					calendar.allDay = allDay;
					
					// Save button
					$(".modal-footer").off('click').delegate('[data-option="quickSave"]', 'click', function(e) 
					{	
						var event_title = $("form#event_title").serializeArray();
						var event_description = [];
						$("form#event_description").find("input[name='p_id']").each(function() {
							if ($(this).val() != "") { event_description.push($(this).val()); }
						});
						console.log(event_description);
						$("form#event_description").find("textarea[name='description']").each(function() {
							if ($(this).is(":visible")) { event_description.push($(this).val()); }
						});
						console.log(event_description);
						$("form#event_description").find("input[name='visit_duration']").each(function() {
							if ($(this).is(":visible")) { event_description.push($(this).val()); }
						});
						console.log(event_description);
/*
						if(opt.quickSaveCategory !== '') 
						{ 
							calendar.category = event_description[5].value; 
							var description_fix = event_description[4];
						} else { 
							var description_fix = event_description[2];
							calendar.category = ''; 
						}
*/

						calendar.quickSave(event_title[2], event_description, calendar.start, calendar.end, calendar.allDay);
						
						e.preventDefault();
					});
					
					// e.preventDefault(); prevented duplication

				} // end quickModal
					
				// Function quickSave 
				calendar.quickSave = function(event_title, event_description, start, end, allDay)
				{
					var start_factor = moment(start).format('YYYY-MM-DD');
					var startTime_factor = moment(start).format('HH:mm');
					var end_factor = moment(end).format('YYYY-MM-DD');
					var endTime_factor = moment(end).format('HH:mm');
					
					if(opt.quickSaveCategory !== '')
					{
//						var constructor = 'title='+encodeURIComponent(event_title.value)+'&description='+encodeURIComponent(event_description[0].value)+'&start_date='+start_factor+'&start_time='+startTime_factor+'&end_date='+end_factor+'&end_time='+endTime_factor+'&url=false&color='+opt.defaultColor+'&allDay='+allDay+'&categorie='+calendar.category+'&view='+calendar.view;
						var constructor = 'title=' + encodeURIComponent(event_title.value) + 
												'&description=' + encodeURIComponent(event_description[1]) + 
												'&start_date=' + start_factor + 
												'&start_time=' + startTime_factor + 
												'&end_date=' + end_factor + 
												'&end_time=' + endTime_factor + 
												'&pid=' + event_description[0] + 
												'&duration=' + event_description[2] + 
												'&d_id=' + $("#addEvent").find("input[name='d_id']").val() + 
												'form_type=' + $("#addEvent").find("input[name='form_type']").val();
					} else {
//						var constructor = 'title='+encodeURIComponent(event_title.value)+'&description='+encodeURIComponent(event_description[0].value)+'&start_date='+start_factor+'&start_time='+startTime_factor+'&end_date='+end_factor+'&end_time='+endTime_factor+'&url=false&color='+opt.defaultColor+'&allDay='+allDay+'&view='+calendar.view;
						var constructor = 'title=' + encodeURIComponent(event_title.value) + 
												'&description=' + encodeURIComponent(event_description[1]) + 
												'&start_date=' + start_factor + 
												'&start_time=' + startTime_factor + 
												'&end_date=' + end_factor + 
												'&end_time=' + endTime_factor + 
												'&pid=' + event_description[0] + 
												'&duration=' + event_description[2] + 
												'&d_id=' + $("#addEvent").find("input[name='d_id']").val() +
												'form_type=' + $("#addEvent").find("input[name='form_type']").val();
					}
					
					$.post(opt.ajaxEventQuickSave, constructor, function(response) 
					{	
						if(response == 1) 
						{
							$(opt.modalQuickSaveSelector).modal('hide');
							$(opt.calendarSelector).fullCalendar('refetchEvents');
						} else {
							alert(opt.failureAddEventMessage);	
						}
						clearForm(opt.modalQuickSaveSelector);
					});	
					// e.preventDefault(); prevented duplication
				} // end quickSave
					   
				// Function to Save Data to the Database 
				calendar.save = function()
				{
					$(opt.formAddEventSelector).on('submit', function(e)
					{
						$.post(opt.ajaxEventSave, $(this).serialize(), function(response) 
						{
							if(response == 1 || response == '1' || response == true || response == 'true') 
							{
								alert(opt.successAddEventMessage);
								document.location.reload();
							} else {
								alert(opt.failureAddEventMessage);
								document.location.reload();
							}
							clearForm(opt.formAddEventSelector);
						});	
						e.preventDefault();
					}); 
				};
					
				// Function to Remove Event ID from the Database
				calendar.remove = function(id)
				{
					var construct = "id="+id;

					// First check if the event is a repetitive event
					$.ajax({
						type: "POST",
						url: opt.ajaxRepeatCheck,
						data: construct,
						cache: false,
						success: function(response) {
							if(response == 'REP_FOUND') 
							{
								// prompt user
								$(opt.modalViewSelector).modal('hide');
								
								if(opt.version == 'modal')
								{
									$(opt.modalPromptSelector+" .modal-header").html('<h4>'+opt.eventText+calendar.title+'</h4>');
									$(opt.modalPromptSelector+" .modal-body").html(opt.repetitiveEventActionText);	
								} else {
									$(opt.modalPromptSelector+" .modal-header").html('<h4>'+opt.eventText+'</h4>');
									$(opt.modalPromptSelector+" .modal-body").html(opt.repetitiveEventActionText);		
								}
								
								$(opt.modalPromptSelector).modal('show');
								
								// Action - remove this
								$(".modal-footer").delegate('[data-option="remove-this"]', 'click', function(e) 
								{
									calendar.remove_this(construct);
									$(opt.modalPromptSelector).modal('hide');
									e.preventDefault();
								 });
								
								// Action - remove repetitive
								$(".modal-footer").delegate('[data-option="remove-repetitives"]', 'click', function(e) 
								{
									if(opt.version == 'modal')
									{
										var construct = "id="+id+'&rep_id='+calendar.rep_id+'&method=repetitive_event';
									} else {
										var construct = "id="+id+'&rep_id='+$("input#rep_id").val()+'&method=repetitive_event';
									}
									
									calendar.remove_this(construct);
									$(opt.modalPromptSelector).modal('hide');
									e.preventDefault();
								 });
								
							} else {
								calendar.remove_this(construct);
							}
						},
						error: function(response) {
							alert(opt.generalFailureMessage);	
						}
					});	
				};
				
				// Functo to Remove Event from the database
				calendar.remove_this = function(construct)
				{
					// just remove this	
					$.post(opt.ajaxEventDelete, construct, function(response) 
					{
						if(response == '') 
						{
							if(opt.version == 'modal')
							{
								$(opt.modalViewSelector).modal('hide');
								$(opt.calendarSelector).fullCalendar('refetchEvents');	
							} else {
								document.location.reload();		
							}
						} else {
							alert(opt.failureDeleteEventMessage);
						}
					});			
				}
					
				// Function to Update Event to the Database
				calendar.update = function(id, theEvent)
				{
					var construct = "id="+id;
					
					if(opt.version == 'php')
					{
						var theEvent = {
							'title_update' : $('input#title_update').val(),
							'description_update' : $('textarea#description_update').val(),
							'color_update' : opt.defaultColor,
							'update_start_date' : $('input#datepicker').val(),
							'update_start_time' : $('input#tp1').val(),
							'update_end_date' : $('input#datepicker2').val(),
							'update_end_time' : $('input#tp2').val()
						};
						
						calendar.url = 'undefined';
					}
					
					// First check if the event is a repetitive event
					$.ajax({
						type: "POST",
						url: opt.ajaxRepeatCheck,
						data: construct,
						cache: false,
						success: function(response) {
							if(response == 'REP_FOUND') 
							{
								// prompt user	
								$(opt.modalEditSelector).modal('hide');	
								
								if(opt.version == 'modal')
								{
									$(opt.modalEditPromptSelector+" .modal-header").html('<h4>'+opt.eventText+calendar.title+'</h4>');
									$(opt.modalEditPromptSelector+" .modal-body-custom").css('padding', '15px').html(opt.repetitiveEventActionText);
								} else {
									$(opt.modalEditPromptSelector+" .modal-header").html('<h4>'+opt.eventText+'</h4>');
									$(opt.modalEditPromptSelector+" .modal-body-custom").css('padding', '15px').html(opt.repetitiveEventActionText);
								}
								
								$(opt.modalEditPromptSelector).modal('show');
								
								// Action - save this
								$(".modal-footer").delegate('[data-option="save-this"]', 'click', function(e) 
								{
									calendar.update_this(id, theEvent);
									$(opt.modalEditPromptSelector).modal('hide');
									$(opt.modalEditSelector).modal('hide');
									e.preventDefault();
								 });
								
								// Action - save repetitives
								$(".modal-footer").delegate('[data-option="save-repetitives"]', 'click', function(e) 
								{
									if(opt.version == 'modal')
									{
										var construct_two = '&rep_id='+calendar.rep_id+'&method=repetitive_event';
									} else {
										var construct_two = '&rep_id='+$("input#rep_id").val()+'&method=repetitive_event';	
									}
									
									calendar.update_this(id, theEvent, construct_two);
									$(opt.modalEditPromptSelector).modal('hide');
									$(opt.modalEditSelector).modal('hide');
									e.preventDefault();
								 });
								
							} else {
								calendar.update_this(id, theEvent);
							}
						},
						error: function(response) {
							alert(opt.generalFailureMessage);	
						}
					});	
				}
				
				// Function to update single and repetitive events
				calendar.update_this = function(id, theEvent, construct_two)
				{ 
					if(opt.version == 'modal')
					{
						// modalView Mode
						if(calendar.url === 'undefined' || calendar.url === undefined) {
							if(opt.quickSaveCategory == '')
							{
//								var construct = "id="+id+"&title="+encodeURIComponent(theEvent.title_update)+"&description="+encodeURIComponent(theEvent.description_update)+"&color="+theEvent.color_update+"&start_date="+theEvent.update_start_date+"&start_time="+theEvent.update_start_time+"&end_date="+theEvent.update_end_date+"&end_time="+theEvent.update_end_time;	
								var construct = "id="+id+"&start_date="+theEvent.update_start_date+"&start_time="+theEvent.update_start_time+"&duration="+theEvent.update_duration;
							} else {
//								var construct = "id="+id+"&title="+encodeURIComponent(theEvent.title_update)+"&description="+encodeURIComponent(theEvent.description_update)+"&color="+theEvent.color_update+"&start_date="+theEvent.update_start_date+"&start_time="+theEvent.update_start_time+"&end_date="+theEvent.update_end_date+"&end_time="+theEvent.update_end_time+"&category="+theEvent.categorie;		
								var construct = "id="+id+"&start_date="+theEvent.update_start_date+"&start_time="+theEvent.update_start_time+"&duration="+theEvent.update_duration;
							}
						} else {
							if(opt.quickSaveCategory == '')
							{
//								var construct = "id="+id+"&title="+encodeURIComponent(theEvent.title_update)+"&description="+encodeURIComponent(theEvent.description_update)+"&color="+theEvent.color_update+"&start_date="+theEvent.update_start_date+"&start_time="+theEvent.update_start_time+"&end_date="+theEvent.update_end_date+"&end_time="+theEvent.update_end_time+"&url="+theEvent.url_update;
								var construct = "id="+id+"&start_date="+theEvent.update_start_date+"&start_time="+theEvent.update_start_time+"&duration="+theEvent.update_duration;
							} else {
//								var construct = "id="+id+"&title="+encodeURIComponent(theEvent.title_update)+"&description="+encodeURIComponent(theEvent.description_update)+"&color="+theEvent.color_update+"&start_date="+theEvent.update_start_date+"&start_time="+theEvent.update_start_time+"&end_date="+theEvent.update_end_date+"&end_time="+theEvent.update_end_time+"&url="+theEvent.url_update+"&category="+theEvent.categorie;
								var construct = "id="+id+"&start_date="+theEvent.update_start_date+"&start_time="+theEvent.update_start_time+"&duration="+theEvent.update_duration;
							}
						}
					} else {
						// PHP Mode
//						var construct = "id="+id+"&title="+encodeURIComponent(theEvent.title_update)+"&description="+encodeURIComponent(theEvent.description_update)+"&color="+theEvent.color_update+"&start_date="+theEvent.update_start_date+"&start_time="+theEvent.update_start_time+"&end_date="+theEvent.update_end_date+"&end_time="+theEvent.update_end_time;
						var construct = "id="+id+"&start_date="+theEvent.update_start_date+"&start_time="+theEvent.update_start_time+"&duration="+theEvent.update_duration;
					}	
					
					if(construct_two === undefined)
					{
						var main_construct = construct;	
					} else {
						var main_construct = construct+construct_two;	
					}
										
					$.ajax({
						type: "POST",
						url: opt.ajaxEventEdit,
						data: main_construct,
						cache: false,
						success: function(response) {
							if(response == '') 
							{
								if(opt.version == 'modal')
								{
									$(opt.modalEditSelector).modal('hide');
									$(opt.calendarSelector).fullCalendar('refetchEvents');
								} else {
									document.location.reload();	
								}
							} else {
								alert(opt.failureUpdateEventMessage);	
							}
							clearForm(opt.modalEditPromptSelector);
						},
						error: function(response) {
							alert(opt.failureUpdateEventMessage);	
						}
					});	
				}
				
				// Function to Export Calendar
				calendar.exportIcal = function(expID, expTitle, expDescription, expStart, expEnd, expUrl)
				{ 
					var start_factor = expStart;
					var end_factor = expEnd;

					var construct = 'method=export&id='+expID+'&title='+encodeURIComponent(expTitle)+'&description='+encodeURIComponent(expDescription)+'&start_date='+start_factor+'&end_date='+end_factor+'&url='+expUrl;	

					$.post(opt.ajaxEventExport, construct, function(response) 
					{
						
						$(opt.modalViewSelector).modal('hide');
						window.location = 'includes/Event-'+expID+'.ics';
						var construct2 = 'id='+expID;
						$.post(opt.ajaxEventExport, construct2, function() {});
					});
				}
				
				// Import
				calendar.calendarImport = function()
				{
					txt = 'import='+encodeURIComponent($('#import_content').val());	
					$.post(opt.ajaxImport, txt, function(response) 
					{
						alert(response);
						$(opt.calendarSelector).fullCalendar('refetchEvents');
						$('#cal_import').modal('hide');
						$('#import_content').val('');	
					});
				}
			
			// Commons - modal + phpversion
			// Fiter
			if(opt.filter == true)
			{
				$(opt.formFilterSelector).on('change', function(e) 
				{
					 selected_value = $(this).val();
					 
					 construct = 'filter='+selected_value;
					 
					 $.post('includes/loader.php', construct, function(response) 
					{
						$(opt.calendarSelector).fullCalendar('refetchEvents');
					});	
					 
					 e.preventDefault();  
				});
				
			// Search Form
			// keypress
			$(opt.formSearchSelector).keypress(function(e) 
			{
				if(e.which == 13)
				{
					search_me();
					e.preventDefault();
				}
			});
			
			// submit button
			$(opt.formSearchSelector+' button').on('click', function(e) 
			{
				search_me();
			});
			
			function search_me()
			{
				 value = $(opt.formSearchSelector+' input').val();
				 
				 construct = 'search='+value;
				 
				 $.post('includes/loader.php', construct, function(response) 
				{
					$(opt.calendarSelector).fullCalendar('refetchEvents');
				});		
			}
				
			}
					   
		} // FullCalendar Ext
		
	}); // fn
	 
})(jQuery);

// define object at end of plugin to fix ie bug
var calendar = {};
