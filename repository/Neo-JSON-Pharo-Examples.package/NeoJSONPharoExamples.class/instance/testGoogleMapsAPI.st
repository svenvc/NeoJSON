tests
testGoogleMapsAPI

	ZnClient new
		url: 'http://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&sensor=false';
		contentReader: [ :entity | NeoJSONReader fromString: entity contents ];
		get