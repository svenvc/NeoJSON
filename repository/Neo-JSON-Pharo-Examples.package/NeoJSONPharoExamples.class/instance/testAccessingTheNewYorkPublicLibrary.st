tests
testAccessingTheNewYorkPublicLibrary

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