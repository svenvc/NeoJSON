testing
testMaps
	| reader |
	reader := [ :string |
		(NeoJSONReader on: string readStream) next ].
	self assert: (reader value: '{"x":1,"y":2}') equals: (Dictionary newFromPairs: #( 'x' 1 'y' 2)).
	self assert: (reader value: '{}') equals: Dictionary new.
	self assert: (reader value: ' { "x" : 1 , "y" : 2 } ' ) equals: (Dictionary newFromPairs: #( 'x' 1 'y' 2)).
	self assert: (reader value: ' { } ') equals: Dictionary new.
	self should: [ reader value: '{"foo":}' ] raise: NeoJSONParseError. 
	self should: [ reader value: '{"foo":9,}' ] raise: NeoJSONParseError. 
	self should: [ reader value: '{9:true,}' ] raise: NeoJSONParseError. 
	self should: [ reader value: '{' ] raise: NeoJSONParseError.
	self should: [ reader value: '}' ] raise: NeoJSONParseError.
	self should: [ reader value: '{]' ] raise: NeoJSONParseError