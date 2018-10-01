"
I am NeoJSONWriteReadPrettyPrintedTests.
"
Class {
	#name : #NeoJSONWriteReadPrettyPrintedTests,
	#superclass : #NeoJSONWriteReadTests,
	#category : 'Neo-JSON-Tests'
}

{ #category : #testing }
NeoJSONWriteReadPrettyPrintedTests >> testDictionaryOfObject2 [
	| data json reader |
	data := Dictionary new.
	data 
		at: 'one' put: NeoJSONTestObject2 example1;
		at: 'two' put: NeoJSONTestObject2 example1.
	json := NeoJSONWriter toStringPretty: data.
	reader := NeoJSONReader on: json readStream.
	reader for: #DictionaryOfObject2 customDo: [ :mapping |
		mapping mapWithValueSchema: NeoJSONTestObject2 ].  
	self 
		assert: (reader nextAs: #DictionaryOfObject2)
		equals: data
]

{ #category : #testing }
NeoJSONWriteReadPrettyPrintedTests >> testObject1 [
	| json |
	json := NeoJSONWriter toStringPretty: NeoJSONTestObject1 example1.
	self 
		assert: (NeoJSONReader fromString: json as: NeoJSONTestObject1)
		equals: NeoJSONTestObject1 example1
]

{ #category : #testing }
NeoJSONWriteReadPrettyPrintedTests >> testObject2 [
	| json |
	json := NeoJSONWriter toStringPretty: NeoJSONTestObject2 example1.
	self 
		assert: (NeoJSONReader fromString: json as: NeoJSONTestObject2)
		equals: NeoJSONTestObject2 example1
]

{ #category : #testing }
NeoJSONWriteReadPrettyPrintedTests >> testObject3 [
	| json |
	json := NeoJSONWriter toStringPretty: NeoJSONTestObject3 example1.
	self 
		assert: (NeoJSONReader fromString: json as: NeoJSONTestObject3)
		equals: NeoJSONTestObject3 example1
]

{ #category : #private }
NeoJSONWriteReadPrettyPrintedTests >> writeRead: object [
	| json |
	json := String streamContents: [ :stream |
		(NeoJSONWriter on: stream) 
			prettyPrint: true;
			nextPut: object ].
	^ (NeoJSONReader on: json readStream) next 
]
