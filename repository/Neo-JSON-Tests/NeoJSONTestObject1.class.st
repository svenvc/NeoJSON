"
I am NeoJSONTestObject1.

I repesent a domain model object.
I have the following properties:

- id <Integer>
- name <String>
- timestamp <DateAndTime>
- points <Array of: Point>
- bytes <ByteArray>

My JSON representation is like this:

- id <Number>
- name <String>
- created-at <ISO8601 String>
- points <Array of: <Map x,y>
- bytes <Array of: Number>

"
Class {
	#name : #NeoJSONTestObject1,
	#superclass : #Object,
	#instVars : [
		'id',
		'name',
		'timestamp',
		'points',
		'bytes'
	],
	#category : 'Neo-JSON-Tests'
}

{ #category : #'instance creation' }
NeoJSONTestObject1 class >> example1 [
	^ self new
		id: 123;
		name: 'Example1';
		timestamp: (DateAndTime year: 2012 month: 06 day: 08 hour: 14 minute: 30 second: 15 offset: 1 hour);
		points: (Array with: 1@2 with: 3@4);
		bytes: #[ 2 4 6 8 ];
		yourself
]

{ #category : #accessing }
NeoJSONTestObject1 class >> neoJsonMapping: mapper [
	mapper for: self do: [ :mapping |
		mapping mapInstVars: #(id name).
		(mapping mapInstVar: #timestamp to: 'created-at') valueSchema: DateAndTime.
		(mapping mapInstVar: #points) valueSchema: #ArrayOfPoints.
		(mapping mapInstVar: #bytes) valueSchema: ByteArray ].
	mapper for: DateAndTime customDo: [ :mapping |
		mapping decoder: [ :string | DateAndTime fromString: string ].
		mapping encoder: [ :dateAndTime | dateAndTime printString ] ].
	mapper for: #ArrayOfPoints customDo: [ :mapping |
		mapping listOfElementSchema: Point ].  
	mapper mapAllInstVarsFor: Point.
	mapper for: ByteArray customDo: [ :mapping |
		mapping listOfType: ByteArray ]
]

{ #category : #comparing }
NeoJSONTestObject1 >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ id = anObject id
		and: [
			name = anObject name
				and: [
					timestamp = anObject timestamp
						and: [
							points = anObject points
								and: [ bytes = anObject bytes ] ] ] ]
]

{ #category : #accessing }
NeoJSONTestObject1 >> bytes [
	^ bytes
]

{ #category : #accessing }
NeoJSONTestObject1 >> bytes: byteArray [
	bytes := byteArray
]

{ #category : #comparing }
NeoJSONTestObject1 >> hash [
	^ id hash bitXor: (name hash bitXor: (timestamp hash bitXor: (points hash bitXor: bytes hash)))
]

{ #category : #accessing }
NeoJSONTestObject1 >> id [
	^ id
]

{ #category : #accessing }
NeoJSONTestObject1 >> id: integer [
	id := integer
]

{ #category : #accessing }
NeoJSONTestObject1 >> name [
	^ name
]

{ #category : #accessing }
NeoJSONTestObject1 >> name: string [
	name := string
]

{ #category : #accessing }
NeoJSONTestObject1 >> points [
	^ points
]

{ #category : #accessing }
NeoJSONTestObject1 >> points: arrayOfPoints [
	points := arrayOfPoints 
]

{ #category : #accessing }
NeoJSONTestObject1 >> timestamp [
	^ timestamp
]

{ #category : #accessing }
NeoJSONTestObject1 >> timestamp: dateAndTime [ 
	timestamp := dateAndTime 
]
