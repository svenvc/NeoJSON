tests
testFeed
	| json |
	json := ZnClient new
		systemPolicy;
		url: 'https://daringfireball.net/feeds/json';
		accept: ZnMimeType applicationJson;
		contentReader: [ :entity | NeoJSONObject fromString: entity contents ];
		get.
	json items collect: #title.
	json items collect: [ :each | each title -> each url ].
	json 