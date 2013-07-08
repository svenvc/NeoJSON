testing
testBooleans
	| writer |
	writer := [ :object | 
		String streamContents: [ :stream |
			(NeoJSONWriter on: stream) nextPut: object ] ].
	self assert: (writer value: true) equals: 'true'.
	self assert: (writer value: false) equals: 'false'.