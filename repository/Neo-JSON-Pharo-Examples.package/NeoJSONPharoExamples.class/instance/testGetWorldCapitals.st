tests
testGetWorldCapitals
	((NeoJSONReader fromString: (ZnEasy get: 'http://api.geonames.org/countryInfoJSON' username: 'demo' password: '') contents) at: #geonames)
		collect: [ :d | d at: #capital ]