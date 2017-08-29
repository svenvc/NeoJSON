testing
testAllowNil
	self 
		should: [ 
			(NeoJSONReader on: 'null' readStream)
				mapInstVarsFor: Point;
				nextAs: Point ] 
		raise: NeoJSONParseError.
	self
		assert: ((NeoJSONReader on: 'null' readStream)
						mapInstVarsFor: Point;
						for: Point do: [ :mapping | mapping allowNil ];
						nextAs: Point)
		equals: nil.
	self
		assert: ((NeoJSONReader on: '[ { "x" : 1, "y" : 2 }, null, { "x" : 3, "y" : -1 } ]' readStream)
						mapInstVarsFor: Point;
						for: Point do: [ :mapping | mapping allowNil ];
						for: #ArrayOfPoints customDo: [ :mapping | mapping listOfElementSchema: Point ];
						nextAs: #ArrayOfPoints)
		equals: { 1 @ 2. nil. 3 @ -1 }.