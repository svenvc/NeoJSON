testing
testPoint
	| writer |
	writer := [ :object | 
		String streamContents: [ :stream |
			(NeoJSONWriter on: stream) nextPut: object ] ].
	self should: [ writer value: 1@2 ] raise: NeoJSONMappingNotFound