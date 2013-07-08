testing
testIntegers
	| reader |
	reader := [ :string |
		(NeoJSONReader on: string readStream) next ].
	self assert: (reader value: '123') equals: 123.
	self assert: (reader value: '00123') equals: 123.
	self assert: (reader value: '-123') equals: -123.
	self assert: (reader value: '-0123') equals: -123.
	self assert: (reader value: '0') equals: 0.
	self assert: (reader value: '-0') equals: 0.
	self assert: (reader value: '00') equals: 0.
	self assert: (reader value: ' 123	') equals: 123.
	self should: [ reader value: '+1' ] raise: NeoJSONParseError.
	self should: [ reader value: ' - ' ] raise: NeoJSONParseError.
