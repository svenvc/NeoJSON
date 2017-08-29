testing
testPointWriteNil
	| writer |
	writer := [ :object | 
		String streamContents: [ :stream |
			(NeoJSONWriter on: stream) 
				writeNil: true;
				mapAllInstVarsFor: Point;
				nextPut: object ] ].
	self assert: (writer value: 1@2) equals: '{"x":1,"y":2}'.
	self assert: (writer value: Point new) equals: '{"x":null,"y":null}'