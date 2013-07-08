testing
testOrderedCollectionOfPoints
	| reader |
	reader := [ :string | 
		(NeoJSONReader on: string readStream) 
			for: Point do: [ :mapping |
				mapping mapInstVars: #(x y) ];
			for: #OrderedCollectionOfPoints customDo: [ :mapping |
				mapping listOfType: OrderedCollection andElementSchema: Point ];
			nextAs: #OrderedCollectionOfPoints ].
	self assert: (reader value: '[ { "x":1, "y":2 }, { "x":-1, "y":-2 } ]') equals: { 1@2. -1@ -2 } asOrderedCollection. 
	self assert: (reader value: '[ ]') equals: OrderedCollection new.
	self assert: (reader value: '[ { } ]') equals: (OrderedCollection with: Point new)