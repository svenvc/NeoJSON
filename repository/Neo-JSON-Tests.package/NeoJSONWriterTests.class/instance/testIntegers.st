testing
testIntegers
	| writer |
	writer := [ :object | 
		String streamContents: [ :stream |
			(NeoJSONWriter on: stream) nextPut: object ] ].
	self assert: (writer value: 123) equals: '123'.
	self assert: (writer value: -123) equals: '-123'.
	self assert: (writer value: 0) equals: '0'.