tests
testBittrexLitecoinAsDictionary 
	ZnClient new 
		url: 'https://bittrex.com/api/v1.1/public/getmarketSummary?market=BTC-LTC';
		accept: ZnMimeType applicationJson;
		contentReader: [ :entity | |reader|
			reader := (NeoJSONReader on: entity readStream).
			reader next ];
	   get.
	