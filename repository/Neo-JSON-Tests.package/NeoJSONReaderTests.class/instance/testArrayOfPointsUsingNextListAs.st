testing
testArrayOfPointsUsingNextListAs
	| reader |
	reader := [ :string | 
		(NeoJSONReader on: string readStream) 
			mapInstVarsFor: Point;
			nextListAs: Point ].
	self assert: (reader value: '[ { "x":1, "y":2 }, { "y":-2, "x":-1 } ]') equals: (Array with: 1@2 with: -1@ -2) . 
	self assert: (reader value: '[ ]') equals: #().
	self assert: (reader value: '[ { } ]') equals: (Array with: Point new) 