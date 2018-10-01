"
I am NeoJSONBenchmarkTests.

This test is obviously dependent on hardware, but the margin is quite high.
"
Class {
	#name : #NeoJSONBenchmarkTests,
	#superclass : #TestCase,
	#category : 'Neo-JSON-Tests'
}

{ #category : #testing }
NeoJSONBenchmarkTests >> testObject2 [
	| json |
	json := NeoJSONWriter toString: NeoJSONTestObject2 new.
	self 
		assert: (NeoJSONReader fromString: json as: NeoJSONTestObject2)
		equals: NeoJSONTestObject2 new
]

{ #category : #testing }
NeoJSONBenchmarkTests >> testPrettyPrinted [
	| benchmark |
	benchmark := NeoJSONBenchmark new.
	self
		assert: benchmark writePrettyPrintedRead
		equals: benchmark read
]

{ #category : #testing }
NeoJSONBenchmarkTests >> testRead [
	| benchmark |
	benchmark := NeoJSONBenchmark new.
	benchmark read
]

{ #category : #testing }
NeoJSONBenchmarkTests >> testWrite [
	| benchmark |
	benchmark := NeoJSONBenchmark new.
	benchmark write
]
