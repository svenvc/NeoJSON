testing
testObject1
	| json |
	json := NeoJSONWriter toString: NeoJSONTestObject1 example1.
	self 
		assert: (NeoJSONReader fromString: json as: NeoJSONTestObject1)
		equals: NeoJSONTestObject1 example1