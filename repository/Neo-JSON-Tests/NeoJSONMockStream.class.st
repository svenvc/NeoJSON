"
I am NeoJSONMockStream.
I wrap another stream to validate the limited API used.
"
Class {
	#name : #NeoJSONMockStream,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : 'Neo-JSON-Tests'
}

{ #category : #'instance creation' }
NeoJSONMockStream class >> on: stream [
	^ self new
		stream: stream;
		yourself
]

{ #category : #testing }
NeoJSONMockStream >> atEnd [
	^ stream atEnd
]

{ #category : #accessing }
NeoJSONMockStream >> close [
	^ stream close
]

{ #category : #accessing }
NeoJSONMockStream >> collectionSpecies [
	^ stream collectionSpecies
]

{ #category : #accessing }
NeoJSONMockStream >> next [
	^ stream next
]

{ #category : #accessing }
NeoJSONMockStream >> nextPut: character [
	^ stream nextPut: character
]

{ #category : #accessing }
NeoJSONMockStream >> nextPutAll: string [
	^ stream nextPutAll: string
]

{ #category : #accessing }
NeoJSONMockStream >> peek [
	^ stream peek
]

{ #category : #accessing }
NeoJSONMockStream >> peekFor: char [
	^ stream peekFor: char
]

{ #category : #accessing }
NeoJSONMockStream >> space [
	^ stream space
]

{ #category : #'initialize-release' }
NeoJSONMockStream >> stream: anObject [
	stream := anObject
]
