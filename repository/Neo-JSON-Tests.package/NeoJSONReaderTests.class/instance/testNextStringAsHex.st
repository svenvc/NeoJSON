testing
testNextStringAsHex
	| string |
	string := (NeoJSONReader on: '"466F6F2062617221"' readStream)
		for: #StringAsHex
			customDo: [ :mapping | 
					mapping
						encoder: [ :x | x asByteArray hex asUppercase ];
						decoder: [ :x | (ByteArray readHexFrom: x) asString ] ];
		nextAs: #StringAsHex.
	self assert: string equals: 'Foo bar!'