tests
testRectanglePointsWithNils
	self
		assert: 
			(String streamContents: [ :stream | 
				(NeoJSONWriter on: stream)
					for: Point do: [ :mapping | mapping mapAllInstVars ];
					for: Rectangle do: [ :mapping | 
						(mapping mapInstVar: #origin) valueSchema: Point.
						(mapping mapInstVar: #corner) valueSchema: Point ];
					nextPut: Rectangle new ])
		equals: '{}'.
	self
		assert:
			(String streamContents: [ :stream | 
				(NeoJSONWriter on: stream)
					for: Point do: [ :mapping | mapping mapAllInstVars ];
					for: Rectangle	do: [ :mapping | 
						(mapping mapInstVar: #origin) valueSchema: Point.
						(mapping mapInstVar: #corner) valueSchema: Point ];
					writeNil: true;
					nextPut: Rectangle new ])
		equals: '{"origin":null,"corner":null}'.