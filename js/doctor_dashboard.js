/*
function getMySQLDate(date) {
	var dd = date.getDate();
	var mm = date.getMonth() + 1;
	var yyyy = date.getFullYear();
	if(dd < 10) {
		dd='0' + dd;
	} 

	if(mm < 10) {
		mm='0' + mm;
	}
	
	return yyyy + "-" + mm + "-" + dd;
}

function getAppointmentsOnDate(date) {
	var result = "";
	$.ajax({
		type: 'POST',
		url: 'ajax/appointments.ajax.php',
		async: false,
		data: { 'option': 'getOnDate', 'date': date },
		success: function(data) {
			result = JSON.parse(data);
		}
	});
	return result;
}

function getAllAppointmentDate() {
	var result = "";
	$.ajax({
		type: 'POST',
		url: 'ajax/appointments.ajax.php',
		async: false,
		data: { 'option': 'getAllDate' },
		success: function(data) {
			result = JSON.parse(data);
		}
	});
	return result;
}

// generate bootstrap format appointment list and put it inside a Bootstrap Panel
function generateAppointment(panelObj, date) {
	var appointments = getAppointmentsOnDate(date);
	var momentObj = new moment(date);
	//header
	$(panelObj).find("div.panel-heading h3").html(momentObj.format("dddd MMMM DD") + "<span class='badge pull-right'>" + appointments.length + "</span>");
	
	var appList = $(panelObj).find("ul");
	$(appList).empty();

	for (i = 0; i < appointments.length; i++) {
		if (appointments[i].status == 0) { appointments[i].status = '<span class="label label-info pull-right">reserved</span>'; }
		else if (appointments[i].status == 1) { appointments[i].status = '<span class="label label-success pull-right">Verified</span>'; }
		else if (appointments[i].status == 2) { appointments[i].status = '<span class="label label-danger pull-right">canceled</span>'; }
		
		var content = 	"<li class='list-group-item'>" + 
							"<div data-toggle='popover' title='Customer Information' data-content='<b>Customer name: </b>" + appointments[i].first_name + " " + appointments[i].last_name + "<br /><b>Phone: </b>" + appointments[i].phone + "<br /><b>Email: </b>" + appointments[i].email + "'>" +
								"<h3 class='list-group-item-heading'>" + 
									"<div class='square' style='background: " + appointments[i].color + ";'></div>" + 
									appointments[i].appointment_time + " - " + appointments[i].visit_duration + " minutes " + 
								"</h3>" + 
							"</div>" + 
							"<p class='list-group-item-text'>" + 
							appointments[i].first_name + " " + appointments[i].last_name +
							appointments[i].status + 
							"</p>" + 
						"</li>";
		$(appList).append(content);
	}
}

var today = getMySQLDate(new Date());
$('div.calendar_date').css("height", $('div.calendar_date').css("width"));
$("div.calendar_date").jqxCalendar();

// highlight days with appointments
var app_dates = getAllAppointmentDate();
console.log(app_dates);
for (i = 0; i < app_dates.length; i++) {
	$("div.calendar_date").jqxCalendar('addSpecialDate', new Date(app_dates[i].appointment_date), "");
}

$(document).find('div.calendar_date').on('change', function (event) { 
    var date = getMySQLDate(event.args.date);
	// generate today's appointment
	generateAppointment($("div[data-appointment='day']"), date);

	// generate the next day's appointment
	var nextDate = new moment(date);
	nextDate.add(1, 'days');
	generateAppointment($("div[data-appointment='next_day']"), nextDate.format("YYYY-MM-DD"));
	
	$("div[data-toggle='popover']").popover({
		placement: 'left',
		html: true,
	});
});



// for some reason the onchange event doesn't fire on load, manually adding today's appointments
generateAppointment($("div[data-appointment='day']"), today);
// generate the next day's appointment
var nextDate = new moment(today);
nextDate.add(1, 'days');
generateAppointment($("div[data-appointment='next_day']"), nextDate.format("YYYY-MM-DD"));

$(document).on('hover', 'div[data-toggle="popover"]', function() {
	$(this).css('cursor', 'pointer');
});

$('body').on('click', function (e) {
    $('[data-toggle="popover"]').each(function () {
        //the 'is' for buttons that trigger popups
        //the 'has' for icons within a button that triggers a popup
        if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {
            $(this).popover('hide');
        }
    });
});
*/
// ------------------- Summary Chart -------------------------------
function getSummaryData() {
	var result = "";
	$.ajax({
		type: 'POST',
		url: 'ajax/appointments.ajax.php',
		async: false,
		data: { 'option': 'getSummaryData' },
		success: function(data) {
			result = JSON.parse(data);
		}
	});
	return result;
}

function renderSummaryChart(obj, data) {
	var summaryChartOptions = {
		chart: {
			type: 'line'
		},
		title: {
			text: 'Appointments per Year/Month'
		},
		xAxis: {
			categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
		},
		yAxis: {
			title: {
				text: 'Appointments'
			}
		},
		plotOptions: {
			line: {
				dataLabels: {
					enabled: true
				},
				enableMouseTracking: false
			}
		},
		series: data
	};
	$(obj).highcharts(summaryChartOptions);
}

function renderSummaryTable(obj, data) {
	var d = new Date();
	
	// print HTML code
	var monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
	var htmlCode = "<table class='table table-hover table-striped table-bordered'>" + 
						"<thead>" + 
							"<tr>" + 
								"<th colspan='6' class='c_table'>Total Appointments Year/Month</th>" + 
							"</tr>" +
							"<tr>" +
								"<th class='c_table'></th>";
	for (var i = 4; i >= 0; i--) {
		htmlCode += "<th class='c_table'>" + (d.getFullYear() - i) + "</th>";
	}
	htmlCode += 			"</tr>" +
						"</thead>" + 
						"<tbody>";
	for (var i = 0; i < 12; i++) {
		htmlCode += "<tr>" + 
						"<td>" + monthNames[i] + "</td>";
		for (var j = 0; j < 5; j++) {
			htmlCode += "<td>" + data[j].data[i] + "</td>";
		}
		htmlCode += "</tr>";
	}
	htmlCode += "</table>";
	$(obj).html(htmlCode);
}

function renderChartAndTable(chartObj, tableObj) {
	var data = getSummaryData();
	var d = new Date();
	var year = d.getFullYear() - 4, month = 0;
	
	
	var chartData = [];
	// handle empty data
	if (data.length == 0) {
		aYear = { name: '', data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] };
		for (var i = 0; i < 5; i++) { chartData.push(aYear); }
	} else {
		var aYear = { name: '', data: [] };
		for (var i = 0; i < data.length; i++) {
			while (year < data[i].year) {
				aYear.name = year;
				aYear.data = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
				chartData.push(aYear);
				year++;
				aYear = { name: '', data: [] };
			}
			if (year == data[i].year) {		// same year => check and add month
				while (month < data[i].month - 1) { aYear.data.push(0); month++; }
				aYear.data.push(parseInt(data[i].appointments));
				month++;
			}
			else {
				while (month < 12) { aYear.data.push(0); month++; }
				aYear.name = year;
				chartData.push(aYear);
				// reset variable
				aYear = { name: '', data: [] };
				year = data[i].year;
				month = 0;
			}
		}
		// handle the last year data
		while (month < 12) { aYear.data.push(0); month++; }
		aYear.name = year;
		chartData.push(aYear);
	}
	
	renderSummaryChart(chartObj, chartData);
	renderSummaryTable(tableObj, chartData);
}

// ------------------- Home chart for current month ----------------
function getAppointmentDataForThisMonth() {
    var result = '';
    $.ajax({
        type: 'POST',
        url: 'ajax/appointments.ajax.php',
        async: false,
        data: { 'option': 'getAppointmentsThisMonth' },
        success: function(data) {
            result = JSON.parse(data);
        }
    });
    return result;
}

function renderHomeChart(obj) {
    var data = getAppointmentDataForThisMonth();
    var monthNames = ["January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
    ];
    var d = new Date();

    var chartOps = {
        chart: {
            type: 'line'
        },
        credits: {
            enabled: false
        },
        title: {
            text: 'Appointments Summary in ' + monthNames[d.getMonth()]
        },
        xAxis: {
            title: {
                text: 'Day'
            },
            min: 1
        },
        yAxis: {
            title: {
                text: 'Appointments'
            },
            min: 0
        },
        plotOptions: {
            line: {
                dataLabels: {
                    enabled: false
                },
                enableMouseTracking: true
            }
        },
        series: [{
            name: 'Appointments',
            data: data
        }]
    };
    $(obj).highcharts(chartOps);
}
// ------------------- jquery events -------------------------------
$(document).on('click', 'a[data-role="view_appointment_invoice"]', function() {
    var id = $(this).closest('tr').attr('id');
    $.ajax({
        type: 'POST',
        url: 'ajax/appointments.ajax.php',
        async: false,
        data: { 'option': 'getInvoice', 'id': id },
        success: function(data) {
            $("#invoice_container").find(".modal-body").html(data);
            $("#invoice_container").find(".modal").modal('show');
        }
    });
});