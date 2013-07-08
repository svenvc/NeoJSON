testing
testSymbol
	| writer |
	writer := [ :object | 
		String streamContents: [ :stream |
			(NeoJSONWriter on: stream) nextPut: object ] ].
	self assert: (writer value: #foo) equals: '"foo"'.
	self assert: (writer value: #'FOO-1') equals: '"FOO-1"'
