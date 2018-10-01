Class {
	#name : #NeoJSONPharoExamples,
	#superclass : #TestCase,
	#category : 'Neo-JSON-Pharo-Examples'
}

{ #category : #tests }
NeoJSONPharoExamples >> testAccessingTheNewYorkPublicLibrary [

	| client reader data networkStream |
	(client := ZnClient new)
		streaming: true;
		url: 'https://github.com/NYPL-publicdomain/data-and-utilities/blob/master/items/pd_items_1.ndjson?raw=true';
		get.
	networkStream := ZnCharacterReadStream on: client contents.
	reader := NeoJSONReader on: networkStream.
	data := Array streamContents: [ :out | [ reader atEnd ] whileFalse: [ out nextPut: reader next ] ].
	client close.
	data
]

{ #category : #tests }
NeoJSONPharoExamples >> testAttachmentsExample [
	| collectionOne json |
	"Let's create a collection of two instances:"
	collectionOne := {(Attachment new
		url: 'http://example.com/random-name.txt' asZnUrl;
		fileName: 'chapter-one.txt' yourself).
	(Attachment new
		url: 'http://example.com/random-name.png' asZnUrl;
		fileName: 'image.png';
		yourself)}.

	"And let's map it to a JSON structure:"
	json := String
		streamContents: [ :aStream | 
			(NeoJSONWriter on: aStream)
				for: #CollectionOfAttachments customDo: [ :mapping | mapping listOfElementSchema: Attachment ];
				mapAllInstVarsFor: Attachment;
				for: ZnUrl customDo: [ :mapping | mapping encoder: [ :aZnUrl | aZnUrl asString ] ];
				nextPut: collectionOne as: #CollectionOfAttachments ].


	"And read the JSON structure:"
	(NeoJSONReader on: json readStream)
		for: #CollectionOfAttachments customDo: [ :mapping | mapping listOfElementSchema: Attachment ];
		for: Attachment
			do: [ :mapping | 
			mapping mapInstVar: 'fileName'.
			(mapping mapInstVar: 'url') valueSchema: ZnUrl ];
		for: ZnUrl customDo: [ :mapping | mapping decoder: [ :string | string asZnUrl ] ];
		nextAs: #CollectionOfAttachments
]

{ #category : #tests }
NeoJSONPharoExamples >> testBittrexLitecoinAsDictionary [ 
	ZnClient new 
		url: 'https://bittrex.com/api/v1.1/public/getmarketSummary?market=BTC-LTC';
		accept: ZnMimeType applicationJson;
		contentReader: [ :entity | |reader|
			reader := (NeoJSONReader on: entity readStream).
			reader next ];
	   get.
	
]

{ #category : #tests }
NeoJSONPharoExamples >> testBittrexLitecoinAsDomainObjects [
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
]

{ #category : #tests }
NeoJSONPharoExamples >> testDoomtownDBCards [

	NeoJSONReader fromString: 'http://dtdb.co/api/cards/' asUrl retrieveContents
]

{ #category : #tests }
NeoJSONPharoExamples >> testFeed [
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
]

{ #category : #tests }
NeoJSONPharoExamples >> testGetWorldCapitals [
	((NeoJSONReader fromString: (ZnEasy get: 'http://api.geonames.org/countryInfoJSON' username: 'demo' password: '') contents) at: #geonames)
		collect: [ :d | d at: #capital ]
]

{ #category : #tests }
NeoJSONPharoExamples >> testGoogleMapsAPI [

	ZnClient new
		url: 'http://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&sensor=false';
		contentReader: [ :entity | NeoJSONReader fromString: entity contents ];
		get
]

{ #category : #tests }
NeoJSONPharoExamples >> testParsingUserAgentStrings [
	ZnClient new
		http;
		host: 'useragentstring.com';
		queryAt: 'uas' put: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/601.4.4 (KHTML, like Gecko) Version/9.0.3 Safari/601.4.4';
		queryAt: 'getJSON' put: 'all';
		contentReader: [ :entity | NeoJSONReader fromString: entity contents ];
		get
]

{ #category : #tests }
NeoJSONPharoExamples >> testStackOverflowInfo [

	ZnClient new
		contentReader: [ :entity | NeoJSONReader fromString: entity contents ];
		get: 'http://api.stackexchange.com/2.1/info?site=stackoverflow'
]
