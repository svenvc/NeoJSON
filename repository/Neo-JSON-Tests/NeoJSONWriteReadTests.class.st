"
I am NeoJSONWriteReadTests.
"
Class {
	#name : #NeoJSONWriteReadTests,
	#superclass : #TestCase,
	#category : 'Neo-JSON-Tests'
}

{ #category : #testing }
NeoJSONWriteReadTests >> testDictionaryOfObject2 [
	| data json reader |
	data := Dictionary new.
	data 
		at: 'one' put: NeoJSONTestObject2 example1;
		at: 'two' put: NeoJSONTestObject2 example1.
	json := NeoJSONWriter toString: data.
	reader := NeoJSONReader on: json readStream.
	reader for: #DictionaryOfObject2 customDo: [ :mapping |
		mapping mapWithValueSchema: NeoJSONTestObject2 ].  
	self 
		assert: (reader nextAs: #DictionaryOfObject2)
		equals: data
]

{ #category : #testing }
NeoJSONWriteReadTests >> testFloats [
	| objects |
	objects := OrderedCollection new add: Float pi; add: 1.0; add: -1.0; add: 0.0; add: 1.5e6; add: -1.5e6; add: 1.5e-6; add: -1.5e-6; yourself.
	(self writeRead: objects) 
		with: objects 
		do: [ :first :second | self assert: (first closeTo: second) ]
]

{ #category : #testing }
NeoJSONWriteReadTests >> testIntegers [
	| objects |
	objects := Array with: 1 with: -1 with: 0 with: 123467890 with: -1234567890.
	self 
		assert: (self writeRead: objects)
		equals: objects
]

{ #category : #testing }
NeoJSONWriteReadTests >> testLists [
	| objects |
	objects := Array with: #(1 2 3) with: #() with: #( 'foo' 'bar').
	self 
		assert: (self writeRead: objects)
		equals: objects
]

{ #category : #testing }
NeoJSONWriteReadTests >> testMaps [
	| objects |
	objects := Array 
		with: Dictionary new
		with: (Dictionary with: 'x' -> 1)
		with: (Dictionary newFromPairs: #( 'foo' true 'bar' false 'zero' 0 'null' nil 'string' 'Hello World!' )).
	self 
		assert: (self writeRead: objects)
		equals: objects
]

{ #category : #testing }
NeoJSONWriteReadTests >> testObject1 [
	| json |
	json := NeoJSONWriter toString: NeoJSONTestObject1 example1.
	self 
		assert: (NeoJSONReader fromString: json as: NeoJSONTestObject1)
		equals: NeoJSONTestObject1 example1
]

{ #category : #testing }
NeoJSONWriteReadTests >> testObject2 [
	| json |
	json := NeoJSONWriter toString: NeoJSONTestObject2 example1.
	self 
		assert: (NeoJSONReader fromString: json as: NeoJSONTestObject2)
		equals: NeoJSONTestObject2 example1
]

{ #category : #testing }
NeoJSONWriteReadTests >> testObject3 [
	| json |
	json := NeoJSONWriter toString: NeoJSONTestObject3 example1.
	self 
		assert: (NeoJSONReader fromString: json as: NeoJSONTestObject3)
		equals: NeoJSONTestObject3 example1
]

{ #category : #testing }
NeoJSONWriteReadTests >> testSpecials [
	| objects |
	objects := Array with: true with: false with: nil.
	self 
		assert: (self writeRead: objects)
		equals: objects
]

{ #category : #testing }
NeoJSONWriteReadTests >> testStrings [
	| objects |
	objects := OrderedCollection new
		add: 'foo'; add: 'Foo BAR'; add: ''; add: '	\\'''; 
		add: 'élève en Français';
		add: (Character codePoint: 12354) asString; "HIRAGANA LETTER A" 
		yourself;
		asArray.
	self 
		assert: (self writeRead: objects)
		equals: objects
]

{ #category : #private }
NeoJSONWriteReadTests >> writeRead: object [
	| json |
	json := String streamContents: [ :stream |
		(NeoJSONWriter on: stream) nextPut: object ].
	^ (NeoJSONReader on: json readStream) next 
]
