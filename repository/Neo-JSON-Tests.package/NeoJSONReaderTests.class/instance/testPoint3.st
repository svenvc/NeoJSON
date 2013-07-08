testing
testPoint3
	| reader |
	reader := [ :string | 
		(NeoJSONReader on: string readStream) 
			for: Point do: [ :mapping |
				mapping mapInstVars: #(x y) ];
			nextAs: Point ].
	self assert: (reader value: '{"x":1,"y":2}') equals: 1@2. 
	self assert: (reader value: '{}') equals: Point new