"
I am NeoJSONWriteReadAsciiOnlyTests.
"
Class {
	#name : #NeoJSONWriteReadAsciiOnlyTests,
	#superclass : #NeoJSONWriteReadTests,
	#category : 'Neo-JSON-Tests'
}

{ #category : #private }
NeoJSONWriteReadAsciiOnlyTests >> writeRead: object [
	| json |
	json := String streamContents: [ :stream |
		(NeoJSONWriter on: stream) asciiOnly: true; nextPut: object ].
	^ (NeoJSONReader on: json readStream) next 
]
