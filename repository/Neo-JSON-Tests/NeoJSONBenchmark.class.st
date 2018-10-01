"
I am NeoJSONBenchmark.
I hold 1000 objects of the form Dictionary('color'->'green' 'enabled'->false 'id'->1 'name'->'Name-1' 'value'->0.002 ) in an Array.
I hold the JSON serialization of that as a String of the form '[{""value"":0.002,""enabled"":false,""name"":""Name-1"",""color"":""green"",""id"":1}, ...

| benchmark |
benchmark := NeoJSONBenchmark new.
[benchmark read] bench.

| benchmark |
benchmark := NeoJSONBenchmark new.
[benchmark write] bench.

| benchmark |
benchmark := NeoJSONBenchmark new.
[benchmark read] timeToRun.

| benchmark |
benchmark := NeoJSONBenchmark new.
[benchmark write] timeToRun.
"
Class {
	#name : #NeoJSONBenchmark,
	#superclass : #Object,
	#instVars : [
		'objects',
		'json'
	],
	#category : 'Neo-JSON-Tests'
}

{ #category : #'initialize-release' }
NeoJSONBenchmark >> initialize [
	super initialize.
	objects := Array new: 1000.
	1 to: 1000 do: [ :each |
		| map |
		(map := Dictionary new)
			at: 'id' put: each;
			at: 'name' put: 'Name-', each asString;
			at: 'enabled' put: (#( true false) at: (each \\ 2) + 1);
			at: 'color' put: (#( 'red' 'green' 'blue' ) at: (each \\ 3) + 1);
			at: 'value' put: each + each / 1000.0.
		objects at: each put: map ].
	json := String streamContents: [ :stream |
		(NeoJSONWriter on: stream) nextPut: objects ]
		
]

{ #category : #public }
NeoJSONBenchmark >> read [
	^ (NeoJSONReader on: json readStream) next

]

{ #category : #public }
NeoJSONBenchmark >> write [
	^ String streamContents: [ :stream |
		(NeoJSONWriter on: stream) nextPut: objects ]

]

{ #category : #public }
NeoJSONBenchmark >> writePrettyPrintedRead [
	| output |
	output := String streamContents: [ :stream |
		(NeoJSONWriter on: stream) 
			prettyPrint: true;
			nextPut: objects ].
	^ (NeoJSONReader on: output readStream) 
		next
]
