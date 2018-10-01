tests
testRectanglePoints
	| rectangle rectangleJson result |

	rectangle := Rectangle origin: 3 @ 4 extent: 5 @ 6.

	rectangleJson := String streamContents: [ :stream | 
		(NeoJSONWriter on: stream)
			prettyPrint: true;
			mapInstVarsFor: Point;
			mapInstVarsFor: Rectangle;
			nextPut: rectangle ].

	result := (NeoJSONReader on: rectangleJson readStream)
		mapInstVarsFor: Point;
		for: Rectangle do: [ :mapping | 
			(mapping mapInstVar: #origin) valueSchema: Point.
			(mapping mapInstVar: #corner) valueSchema: Point ];
		nextAs: Rectangle.

	self assert: result equals: rectangle.

	result := (NeoJSONReader on: rectangleJson readStream)
		mapInstVarsFor: Point;
		for: Rectangle do: [ :mapping | 
			mapping mapInstVars do: [ :each | each valueSchema: Point ] ];
		nextAs: Rectangle.
		
	self assert: result equals: rectangle 