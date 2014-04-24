testing
testNextPutStringAsHex
	| output |
	output := String
		streamContents: [ :out | 
			(NeoJSONWriter on: out)
				for: #StringAsHex
					customDo: [ :mapping | 
							mapping
								encoder: [ :x | x asByteArray hex asUppercase ];
								decoder: [ :x | (ByteArray readHexFrom: x) asString ] ];
				nextPut: 'Foo bar!' as: #StringAsHex ].
	self assert: output equals: '"466F6F2062617221"'