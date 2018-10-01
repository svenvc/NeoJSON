"
I am NeoJSONCustomMapping.

I read the next JSON value and turn it into a Smalltalk object using a converter block.
"
Class {
	#name : #NeoJSONCustomMapping,
	#superclass : #NeoJSONMapping,
	#instVars : [
		'schemaName',
		'reader',
		'writer'
	],
	#category : 'Neo-JSON-Core'
}

{ #category : #mapping }
NeoJSONCustomMapping >> decoder: block [
	"Set a decoder block that accepts the next object representation read 
	and converts it into the actual object to be returned."

	self reader: [ :jsonReader | | representation |
		representation := jsonReader next.
		block value: representation ]
]

{ #category : #mapping }
NeoJSONCustomMapping >> encoder: block [
	"Set a encoder block that accepts the next object to be written 
	and converts it into the actual representation to be written."

	self writer: [ :jsonWriter :anObject | | representation |
		representation := block value: anObject.
		jsonWriter nextPut: representation ]
]

{ #category : #accessing }
NeoJSONCustomMapping >> identifier [
	^ schemaName 
]

{ #category : #mapping }
NeoJSONCustomMapping >> listOfElementSchema: elementSchema [
	"Set the reader to a block that will create an instance of the
	standard listClass while reading a list of elements of type elementSchema"

	self reader: [ :jsonReader |
		jsonReader listClass streamContents: [ :stream |
			jsonReader parseListDo: [ | element |
				element := jsonReader nextAs: elementSchema.
				stream nextPut: element ] ] ].
	self writer: [ :jsonWriter :list | 
		jsonWriter writeListStreamingDo: [ :listWriter |
			list do: [ :each | listWriter writeElement: each as: elementSchema ] ] ]

]

{ #category : #mapping }
NeoJSONCustomMapping >> listOfType: collectionClass [
	"Set the reader to a block that will create an instance of collectionClass 
	using #streamContents: while reading a list of elements"

	self reader: [ :jsonReader |
		collectionClass streamContents: [ :stream |
			jsonReader parseListDo: [ | element |
				element := jsonReader next.
				stream nextPut: element ] ] ]
	"we do not set a writer, #neoJsonOn: should be sufficient, no element type known anyway"

]

{ #category : #mapping }
NeoJSONCustomMapping >> listOfType: collectionClass andElementSchema: elementSchema [
	"Set the reader to a block that will create an instance of collectionClass 
	using #streamContents: while reading a list of elements of type elementSchema"

	self reader: [ :jsonReader |
		collectionClass streamContents: [ :stream |
			jsonReader parseListDo: [ | element |
				element := jsonReader nextAs: elementSchema.
				stream nextPut: element ] ] ].
	self writer: [ :jsonWriter :list | 
		jsonWriter writeListStreamingDo: [ :listWriter |
			list do: [ :each | 
				listWriter writeElement: each as: elementSchema ] ] ]
]

{ #category : #mapping }
NeoJSONCustomMapping >> mapWithValueSchema: valueSchema [
	"Set the reader to a block that will create an instance of the
	standard mapClass while reading values of type valueSchema,
	with standard keys"

	self reader: [ :jsonReader | | map |
		map := jsonReader mapClass new.
		jsonReader parseMapKeysDo: [ :key | | value |
				value := jsonReader nextAs: valueSchema.
				map at: key put: value ].
		map ].
	self writer: [ :jsonWriter :map | 
		jsonWriter writeMapStreamingDo: [ :mapWriter |
			map keysAndValuesDo: [ :key :value | 
				mapWriter writeKey: key value: value as: valueSchema ] ] ]
]

{ #category : #parsing }
NeoJSONCustomMapping >> readFrom: jsonReader [
	^ reader 
		ifNil: [ jsonReader next ]
		ifNotNil: [ reader value: jsonReader ]
]

{ #category : #accessing }
NeoJSONCustomMapping >> reader: block [
	"Set the reader to block, a 1 argument block that when given 
	a jsonReader as argument reads the object that I represent.
	When there is no reader block, the default #next will be used."
	
	reader := block
]

{ #category : #accessing }
NeoJSONCustomMapping >> schemaName: schema [
	schemaName := schema
]

{ #category : #writing }
NeoJSONCustomMapping >> writeObject: anObject on: jsonWriter [
	writer 
		ifNil: [ anObject neoJsonOn: jsonWriter ]
		ifNotNil: [ writer value: jsonWriter value: anObject ]
]

{ #category : #accessing }
NeoJSONCustomMapping >> writer: block [
	"Set the writer to block, a 2 argument block that when given: a jsonWriter 
	and the object to write will write the object that I represent.
	When there is no writer block, the default #neoJsonOn: will be used."
	
	writer := block
]
