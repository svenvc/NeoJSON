"
I am NeoJSONStreamingWriter.
I help in writing streamed maps and lists.

This is an internal class used by NeoJSONWriter to deal with interleaving elements and separators as well as pretty printing.
"
Class {
	#name : #NeoJSONStreamingWriter,
	#superclass : #Object,
	#instVars : [
		'jsonWriter',
		'first'
	],
	#category : 'Neo-JSON-Core'
}

{ #category : #'instance creation' }
NeoJSONStreamingWriter class >> on: jsonWriter [
	^ self new
		on: jsonWriter;
		yourself
]

{ #category : #'initialize-release' }
NeoJSONStreamingWriter >> initialize [
	super initialize.
	first := true
]

{ #category : #'initialize-release' }
NeoJSONStreamingWriter >> on: aJSONWriter [
	jsonWriter := aJSONWriter
]

{ #category : #testing }
NeoJSONStreamingWriter >> wasUsed [
	^ first not
]

{ #category : #writing }
NeoJSONStreamingWriter >> writeElement: value [
	first 
		ifTrue: [ 
			jsonWriter newlineIndent. 
			first := false ]
		ifFalse: [ 
			jsonWriter listElementSeparator ].
	jsonWriter nextPut: value 
]

{ #category : #writing }
NeoJSONStreamingWriter >> writeElement: value as: valueSchema [
	first 
		ifTrue: [ 
			jsonWriter newlineIndent. 
			first := false ]
		ifFalse: [ 
			jsonWriter listElementSeparator ].
	jsonWriter nextPut: value as: valueSchema
]

{ #category : #writing }
NeoJSONStreamingWriter >> writeKey: key value: value [
	first 
		ifTrue: [ 
			jsonWriter newlineIndent. 
			first := false ]
		ifFalse: [ 
			jsonWriter mapElementSeparator ].
	jsonWriter encodeKey: key value: value 
]

{ #category : #writing }
NeoJSONStreamingWriter >> writeKey: key value: value as: valueSchema [
	first 
		ifTrue: [ 
			jsonWriter newlineIndent. 
			first := false ]
		ifFalse: [ 
			jsonWriter mapElementSeparator ].
	jsonWriter encodeKey: key value: value as: valueSchema
]

{ #category : #accessing }
NeoJSONStreamingWriter >> writeNil [
	^ jsonWriter writeNil
]
