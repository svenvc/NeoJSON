testing
testMaps
	| writer |
	writer := [ :object | 
		String streamContents: [ :stream |
			(NeoJSONWriter on: stream) nextPut: object ] ].
	self assert: (writer value: (Dictionary newFromPairs: #( 'x' 1 'y' 2))) equals: '{"x":1,"y":2}'.
	self assert: (writer value: Dictionary new) equals: '{}'.
