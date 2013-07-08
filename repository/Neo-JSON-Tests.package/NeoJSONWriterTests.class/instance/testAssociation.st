testing
testAssociation
	| writer |
	writer := [ :object | 
		String streamContents: [ :stream |
			(NeoJSONWriter on: stream) 
				for: Association do: [ :mapping |
					mapping mapAccessors: #(key value) ]; 
				nextPut: object ] ].
	self assert: (writer value: 'foo' -> 42) equals: '{"key":"foo","value":42}'.
	self assert: (writer value: Association new) equals: '{}'