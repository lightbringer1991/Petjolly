/************************
    Pickers
*************************/
$("#datepicker").datepicker({dateFormat: "yy-mm-dd"});
$("#datepicker2").datepicker({dateFormat: "yy-mm-dd"});

$("input[data-role='spectrum']").spectrum({
	preferredFormat: "hex",
    showPaletteOnly: true,
    togglePaletteOnly: true,
    togglePaletteMoreText: 'more',
    togglePaletteLessText: 'less',
    color: '#587ca3',
    palette: [
/*
        ["#000","#444","#666","#999","#ccc","#eee","#f3f3f3","#fff"],
        ["#f00","#f90","#ff0","#0f0","#0ff","#00f","#90f","#f0f"],
        ["#f4cccc","#fce5cd","#fff2cc","#d9ead3","#d0e0e3","#cfe2f3","#d9d2e9","#ead1dc"],
        ["#ea9999","#f9cb9c","#ffe599","#b6d7a8","#a2c4c9","#9fc5e8","#b4a7d6","#d5a6bd"],
        ["#e06666","#f6b26b","#ffd966","#93c47d","#76a5af","#6fa8dc","#8e7cc3","#c27ba0"],
        ["#c00","#e69138","#f1c232","#6aa84f","#45818e","#3d85c6","#674ea7","#a64d79"],
        ["#900","#b45f06","#bf9000","#38761d","#134f5c","#0b5394","#351c75","#741b47"],
        ["#600","#783f04","#7f6000","#274e13","#0c343d","#073763","#20124d","#4c1130"]
*/
        ["#000","#444","#666","#ccc","#eee","#f3f3f3","#fff"],
        ["#f00","#f90","#ff0","#0ff","#00f","#90f","#f0f"],
        ["#f4cccc","#fce5cd","#fff2cc","#d0e0e3","#cfe2f3","#d9d2e9","#ead1dc"],
        ["#ea9999","#f9cb9c","#ffe599","#a2c4c9","#9fc5e8","#b4a7d6","#d5a6bd"],
        ["#e06666","#f6b26b","#ffd966","#76a5af","#6fa8dc","#8e7cc3","#c27ba0"],
        ["#c00","#e69138","#f1c232","#45818e","#3d85c6","#674ea7","#a64d79"],
        ["#900","#b45f06","#bf9000","#134f5c","#0b5394","#351c75","#741b47"],
        ["#600","#783f04","#7f6000","#0c343d","#073763","#20124d","#4c1130"]

    ]
});

$('#tp1').timepicker();
$('#tp2').timepicker();

function clearForm(form) {
	$(form).find("input").each(function() { $(this).val(""); });
	$(form).find("textarea").each(function() { $(this).val(""); });
}

$("form#quickAddPatient").on('submit', function() {
	var fname = $(this).find("input[name='p_fname']").val();
	var lname = $(this).find("input[name='p_lname']").val();
	var email = $(this).find("input[name='p_email']").val();
	var phone = $(this).find("input[name='p_phone']").val();
	var providerID = $(this).find("input[name='provider_id']").val();
	var parentForm = "addEvent";
	
	if (fname == "" || lname == "") { 
		alert("Name cannot be empty.");
		return false;
	}
	var emailFilter = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
	if (!emailFilter.test(email)) { alert("Please enter a valid email"); return false; }
	
	var phoneFilter = /([\+|\s|\d]+)/i;
	if (!phoneFilter.test(phone)) { alert("Please enter a valid phone number"); return false; }
	
	$.ajax({
		type: 'POST',
		url: 'ajaxCalendar/includes/cal_add_patient.php',
		data: { 'fname': fname, 'lname': lname, 'email': email, 'phone': phone, 'providerID': providerID },
		success: function(data) {
			if (data == -1) {
				$("#cal_add_customer").find("div[data-error='addPatientError']").html("Patient email or phone already exists");
			}
			else {
				$("#" + parentForm).find("input[name='c_id']").val(data);
				$("#" + parentForm).find("input[name='c_name']").val(fname + " " + lname);
				$("div[data-class='customer_error']").html("");
				$('#cal_add_customer').modal('hide');
				clearForm("#cal_add_customer");
			}
		}
	});
	return false;
});


var checkExist = setInterval(function() {
   if ($('#the-canvas').length) {
      console.log("Exists!");
      clearInterval(checkExist);
   }
}, 100);
