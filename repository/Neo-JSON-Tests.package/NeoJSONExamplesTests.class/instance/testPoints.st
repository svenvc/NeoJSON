tests
testPoints
	| points json result |
	
	points := Array with: 1@2 with: 3@4 with: 5@6.
	
	json := String streamContents: [ :out |
		(NeoJSONWriter on: out)
			prettyPrint: true;
			mapInstVarsFor: Point;
			nextPut: points ].
		
	result := (NeoJSONReader on: json readStream)
		mapInstVarsFor: Point;
		for: #ListOfPoints customDo: [ :mapping |
			mapping listOfElementSchema: Point ];
		nextAs: #ListOfPoints.
	
	self assert: result equals: points.
			
	result := (NeoJSONReader on: json readStream)
		mapInstVarsFor: Point;
		nextListAs: Point.
	
	self assert: result equals: points.
		
	result := (NeoJSONReader on: json readStream)
		mapInstVarsFor: Point;
		for: #OrderedCollectionOfPoints customDo: [ :mapping |
			mapping listOfType: OrderedCollection andElementSchema: Point ];
		nextAs: #OrderedCollectionOfPoints.
	
	self assert: result equals: points asOrderedCollection.