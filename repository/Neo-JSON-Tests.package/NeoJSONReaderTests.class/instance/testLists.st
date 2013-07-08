testing
testLists
	| reader |
	reader := [ :string |
		(NeoJSONReader on: string readStream) next ].
	self assert: (reader value: '[1,2,3]') equals: #(1 2 3).
	self assert: (reader value: '[]') equals: #().
	self assert: (reader value: ' [ 1 , 2 , 3 ] ') equals: #(1 2 3).
	self assert: (reader value: ' [ ] ') equals: #().
	self should: [ reader value: '[1,]' ] raise: NeoJSONParseError. 
	self should: [ reader value: '[' ] raise: NeoJSONParseError.
	self should: [ reader value: ']' ] raise: NeoJSONParseError.
	self should: [ reader value: '[}' ] raise: NeoJSONParseError