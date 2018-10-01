tests
testBittrexLitecoinAsDomainObjects
	ZnClient new 
		url: 'https://bittrex.com/api/v1.1/public/getmarkets';
		enforceHttpSuccess: true;
		accept: ZnMimeType applicationJson;
		contentReader: [ :entity | |reader|
			reader := (NeoJSONReader on: entity readStream).
			reader for: BittrexResponse do: [:m| 
				m mapInstVar: #success.
				m mapInstVar: #message.
				(m mapInstVar: #result) valueSchema: #ArrayOfMarkets].
			reader for: #ArrayOfMarkets customDo: [ :mapping | mapping listOfElementSchema: Market ].
			reader mapInstVarsFor: Market. 
	      reader nextAs: BittrexResponse ];
	   get