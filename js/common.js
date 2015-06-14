// convert GET data from url string to an array
function parseURLParams(url) {
    var queryStart = url.indexOf("?") + 1,
        queryEnd   = url.indexOf("#") + 1 || url.length + 1,
        query = url.slice(queryStart, queryEnd - 1),
        pairs = query.replace(/\+/g, " ").split("&"),
        parms = {}, i, n, v, nv;

    if (query === url || query === "") {
        return;
    }

    for (i = 0; i < pairs.length; i++) {
        nv = pairs[i].split("=");
        n = decodeURIComponent(nv[0]);
        v = decodeURIComponent(nv[1]);

        if (!parms.hasOwnProperty(n)) {
            parms[n] = [];
        }

        parms[n].push(nv.length === 2 ? v : null);
    }
    return parms;
}

jQuery.validator.addMethod("zipcode", function(value, element) {
	var zipCodePattern = /^\d{5}$|^\d{5}-\d{4}$/;
	return zipCodePattern.test(value);
}, "Please enter a valid zipcode");

jQuery.validator.addMethod("address", function(value, element, params) {
	// Convert the value variable into something a bit more descriptive
	var form = $(element).closest('form');
	var address = $(form).find('input[name="address"]').val();
	var city = $(form).find('input[name="city"]').val();
	var state = $(form).find('select[name="state"]').val();
	var zipcode = $(form).find('input[name="zipcode"]').val();
	var flag = null;			// flag to determine the callback completion
	
	if (city == "" || state == "" || zipcode == "") { return true; }
	
	var CurrentAddress = address + " " + city + " " + state + " " + zipcode;
	if (CurrentAddress.length == 0) { return true; }

	// if already validated before
	if ($(element).data('address') == CurrentAddress) {
		if ($(element).data('validated') == "true") { return true; }
		else { return false; }
	}
	else { 
		$(element).data('address', CurrentAddress);
		$(element).data('validated', '');
		$(form).find("input[name='latitude']").val('');
	}
	
	// Create a new Google geocoder
	var geocoder = new google.maps.Geocoder();
	geocoder.geocode({ 'address': CurrentAddress }, function (results, status) {
		// Google reported a valid geocoded address
		if (status == google.maps.GeocoderStatus.OK) {
			var format_address = results[0].formatted_address;
			// Count the commas in the fomatted address.
			// This doesn't look great, but it helps us understand how specific the geocoded address
			// is.  For example, "CA" will geocde to "California, USA".
			numCommas = format_address.match(/,/g).length;
			// A full street address will have at least 3 commas.  Alternate techniques involve
			// fetching the address_components returned by Google Maps.  That code looks even more ugly.
			if (numCommas >= 3) {
				$(element).data('validated', "true");
				console.log(results[0].geometry.location.lat());
				console.log(results[0].geometry.location.lng());
				$(form).find("input[name='latitude']").val(results[0].geometry.location.lat());
				$(form).find("input[name='longitude']").val(results[0].geometry.location.lng());
			} else {
				$(element).data('validated', "false");
			}
		} else {
			$(element).data('validated', "false");
		}
		$(element).valid();
	});
	return true;
}, "Please enter a valid address");
