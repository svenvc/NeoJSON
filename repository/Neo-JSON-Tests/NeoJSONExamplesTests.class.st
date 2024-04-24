"
NeoJSONExamplesTests runs a couple of examples as tests
"
Class {
	#name : #NeoJSONExamplesTests,
	#superclass : #TestCase,
	#category : #'Neo-JSON-Tests'
}

{ #category : #tests }
NeoJSONExamplesTests >> testMultiInstances [
	"Newline delimited JSON (application/x-ndjson) - https://github.com/ndjson/ndjson-spec"
	"JSON Lines (application/jsonl) - https://jsonlines.org"

	| data json |
	
	data := (1 to: 10) collect: [ :each |
		{ #number -> each } asDictionary ].
	
	json := String streamContents: [ :out |
		(NeoJSONWriter on: out) nextPutAll: data ].
	
	self assert: (NeoJSONReader on: json readStream) upToEnd equals: data.
	
	self assert: (NeoJSONReader on: json readStream) next equals: data first.
	self deny: ((NeoJSONReader on: json readStream) next; atEnd)
]

{ #category : #tests }
NeoJSONExamplesTests >> testPoints [
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
]

{ #category : #tests }
NeoJSONExamplesTests >> testRectanglePoints [
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
]

{ #category : #tests }
NeoJSONExamplesTests >> testRectanglePointsWithNils [
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
]
