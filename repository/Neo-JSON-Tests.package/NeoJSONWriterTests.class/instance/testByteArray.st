testing
testByteArray
	| writer |
	writer := [ :object | 
		String streamContents: [ :stream |
			(NeoJSONWriter on: stream) nextPut: object ] ].
	self assert: (writer value: #[1 2 3]) equals: '[1,2,3]'.
	self assert: (writer value: #[]) equals: '[]'
