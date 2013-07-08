testing
testFloats
	| writer |
	writer := [ :object | 
		String streamContents: [ :stream |
			(NeoJSONWriter on: stream) nextPut: object ] ].
	self assert: (writer value: 123.0) equals: '123.0'.
	self assert: (writer value: -123.0) equals: '-123.0'.
	self assert: (writer value: 0.0) equals: '0.0'.