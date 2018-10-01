tests
testStackOverflowInfo

	ZnClient new
		contentReader: [ :entity | NeoJSONReader fromString: entity contents ];
		get: 'http://api.stackexchange.com/2.1/info?site=stackoverflow'