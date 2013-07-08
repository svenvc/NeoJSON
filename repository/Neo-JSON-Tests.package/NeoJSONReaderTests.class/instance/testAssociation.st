testing
testAssociation
	| reader |
	reader := [ :string | 
		(NeoJSONReader on: string readStream) 
			for: Association do: [ :mapping |
				mapping mapAccessors: #(key value) ]; 
			nextAs: Association ].
	self assert: (reader value: '{"key":"foo","value":42}') equals: 'foo' -> 42. 
	self assert: (reader value: '{}') equals: Association new