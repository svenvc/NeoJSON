tests
testParsingUserAgentStrings
	ZnClient new
		http;
		host: 'useragentstring.com';
		queryAt: 'uas' put: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/601.4.4 (KHTML, like Gecko) Version/9.0.3 Safari/601.4.4';
		queryAt: 'getJSON' put: 'all';
		contentReader: [ :entity | NeoJSONReader fromString: entity contents ];
		get