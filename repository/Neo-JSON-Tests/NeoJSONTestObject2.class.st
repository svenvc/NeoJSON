"
I am NeoJSONTestObject2.

Instance Variables
	data:		<String>
	height:		<Integer>
	id:			<Integer>
	width:		<Integer>

Used for benchmarking and other tests.
"
Class {
	#name : #NeoJSONTestObject2,
	#superclass : #Object,
	#instVars : [
		'id',
		'width',
		'height',
		'data'
	],
	#category : 'Neo-JSON-Tests'
}

{ #category : #testing }
NeoJSONTestObject2 class >> benchmark10k [
	"self benchmark10k"
	
	self benchmark: 10000
]

{ #category : #testing }
NeoJSONTestObject2 class >> benchmark10kAsDictionary [
	"self benchmark10kAsDictionary"
	
	self benchmarkAsDictionary: 10000
]

{ #category : #testing }
NeoJSONTestObject2 class >> benchmark200k [
	"self benchmark200k"
	
	self benchmark: 200000
]

{ #category : #testing }
NeoJSONTestObject2 class >> benchmark: count [
	"self benchmark: 1000"
	
	| collection json size |
	collection := Array new: count withAll: self example1.
	size := 2 + (count * (NeoJSONWriter toString: self example1) size) + count - 1.
	Transcript 
		cr;
		<< ('Serializing {1} objects took ms ' format: (Array with: count) );
		show: [ json := String new: size streamContents: [ :stream |
								(NeoJSONWriter on: stream) nextPut: collection ] ] timeToRun.
	Transcript 
		cr;
		<< ('Deserializing {1} objects took ms ' format: (Array with: count) );
		show: [ NeoJSONReader fromString: json ] timeToRun.
]

{ #category : #testing }
NeoJSONTestObject2 class >> benchmarkAsDictionary: count [
	"self benchmarkAsDictionary: 1000"
	
	| collection json size |
	collection := Array new: count withAll: self example1 asDictionary.
	size := 2 + (count * (NeoJSONWriter toString: self example1 asDictionary) size) + count - 1.
	Transcript 
		cr;
		<< ('Serializing {1} objects took ms ' format: (Array with: count) );
		show: [ json := String new: size streamContents: [ :stream |
								(NeoJSONWriter on: stream) nextPut: collection ] ] timeToRun.
	Transcript 
		cr;
		<< ('Deserializing {1} objects took ms ' format: (Array with: count) );
		show: [ NeoJSONReader fromString: json ] timeToRun.
]

{ #category : #'instance creation' }
NeoJSONTestObject2 class >> example1 [
	^ self new
		id: 13;
		width: 250;
		height: 110;
		data: (String new: 512 withAll: $a);
		yourself
]

{ #category : #accessing }
NeoJSONTestObject2 class >> neoJsonMapping: mapper [
	"For inheritance mapping to work, the schema/classname must be self,
	but the instance variables have to be enumerated manually per class"

	mapper for: self do: [ :mapping |
		mapping mapInstVars: #(id width height data) ] 
]

{ #category : #comparing }
NeoJSONTestObject2 >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ id = anObject id
		and: [
			height = anObject height
				and: [
					width = anObject width
						and: [
							data = anObject data ] ] ]
]

{ #category : #converting }
NeoJSONTestObject2 >> asDictionary [
	^ Dictionary new
		at: #id put: id;
		at: #height put: height;
		at: #width put: width;
		at: #data put: data;
		yourself
]

{ #category : #accessing }
NeoJSONTestObject2 >> data [
	^ data
]

{ #category : #accessing }
NeoJSONTestObject2 >> data: anObject [
	data := anObject
]

{ #category : #comparing }
NeoJSONTestObject2 >> hash [
	^ id hash bitXor: (width hash bitXor: (height hash bitXor: data hash))
]

{ #category : #accessing }
NeoJSONTestObject2 >> height [
	^ height
]

{ #category : #accessing }
NeoJSONTestObject2 >> height: anObject [
	height := anObject
]

{ #category : #accessing }
NeoJSONTestObject2 >> id [
	^ id
]

{ #category : #accessing }
NeoJSONTestObject2 >> id: anObject [
	id := anObject
]

{ #category : #accessing }
NeoJSONTestObject2 >> width [
	^ width
]

{ #category : #accessing }
NeoJSONTestObject2 >> width: anObject [
	width := anObject
]
