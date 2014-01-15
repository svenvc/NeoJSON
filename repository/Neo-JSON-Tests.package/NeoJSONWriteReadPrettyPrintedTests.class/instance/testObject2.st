testing
testObject2
	| json |
	json := NeoJSONWriter toStringPretty: NeoJSONTestObject2 example1.
	self 
		assert: (NeoJSONReader fromString: json as: NeoJSONTestObject2)
		equals: NeoJSONTestObject2 example1