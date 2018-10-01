testing
testMaps
	| writer |
	writer := [ :object | 
		String streamContents: [ :stream |
			(NeoJSONWriter on: stream) nextPut: object ] ].
	self assert: ((writer value: (Dictionary newFromPairs: #( 'x' 1 'y' 2))) includesSubstring: '"x":1').
	self assert: ((writer value: (Dictionary newFromPairs: #( 'x' 1 'y' 2))) includesSubstring: '"y":2').
	self assert: (writer value: Dictionary new) equals: '{}'.
