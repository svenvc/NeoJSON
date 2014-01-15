testing
testDictionaryOfObject2
	| data json reader |
	data := Dictionary new.
	data 
		at: #one put: NeoJSONTestObject2 example1;
		at: #two put: NeoJSONTestObject2 example1.
	json := NeoJSONWriter toString: data.
	reader := NeoJSONReader on: json readStream.
	reader for: #DictionaryOfObject2 customDo: [ :mapping |
		mapping mapWithValueSchema: NeoJSONTestObject2 ].  
	self 
		assert: (reader nextAs: #DictionaryOfObject2)
		equals: data