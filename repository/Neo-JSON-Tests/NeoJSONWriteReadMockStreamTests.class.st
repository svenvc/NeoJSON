"
I am NeoJSONWriteReadMockStreamTests.
"
Class {
	#name : #NeoJSONWriteReadMockStreamTests,
	#superclass : #NeoJSONWriteReadTests,
	#category : 'Neo-JSON-Tests'
}

{ #category : #private }
NeoJSONWriteReadMockStreamTests >> writeRead: object [
	| json |
	json := String streamContents: [ :stream |
		(NeoJSONWriter on: (NeoJSONMockStream on: stream))
			prettyPrint: true;
			nextPut: object ].
	^ (NeoJSONReader on: (NeoJSONMockStream on: json readStream)) next 
]
