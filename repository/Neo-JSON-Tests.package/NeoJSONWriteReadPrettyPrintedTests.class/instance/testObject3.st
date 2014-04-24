testing
testObject3
	| json |
	json := NeoJSONWriter toStringPretty: NeoJSONTestObject3 example1.
	self 
		assert: (NeoJSONReader fromString: json as: NeoJSONTestObject3)
		equals: NeoJSONTestObject3 example1