testing
testObject2
	| json |
	json := NeoJSONWriter toString: NeoJSONTestObject2 new.
	self 
		assert: (NeoJSONReader fromString: json as: NeoJSONTestObject2)
		equals: NeoJSONTestObject2 new