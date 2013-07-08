testing
testArrayOfPoints
	| reader |
	reader := [ :string | 
		(NeoJSONReader on: string readStream) 
			for: Point do: [ :mapping |
				mapping mapInstVars: #(x y) ];
			for: #ArrayOfPoints customDo: [ :mapping |
				mapping listOfElementSchema: Point ];
			nextAs: #ArrayOfPoints ].
	self assert: (reader value: '[ { "x":1, "y":2 }, { "x":-1, "y":-2 } ]') equals: { 1@2. -1@ -2 }. 
	self assert: (reader value: '[ ]') equals: #().
	self assert: (reader value: '[ { } ]') equals: { Point new }