"
I am NeoJSONValidation, a set of tests to validate NeoJSON against some external rules.

Both positive & negative tests are includes.
Some of these are implementation choices.

http://seriot.ch/parsing_json.php
https://github.com/nst/JSONTestSuite
https://github.com/nst/JSONTestSuite.git
  test_parsing
  test_transform

https://github.com/miloyip/nativejson-benchmark
https://github.com/miloyip/nativejson-benchmark.git
  data/jsonchecker
  data/roundtrip

This can only be run with the correct setup (checkout/config).

  NeoJSONValidation new runNativeJsonBenchmarkRoundTrip.
  NeoJSONValidation new runNativeJsonBenchmarkJsonCheckerPasses.
  NeoJSONValidation new runNativeJsonBenchmarkJsonCheckerFailures.

  NeoJSONValidation new runJsonTestSuiteTestParsingPasses.
  NeoJSONValidation new runJsonTestSuiteTestParsingFailures.
  NeoJSONValidation new runJsonTestSuiteTestParsingInfo.

Logging goes to a file, neo-json-validation.log
"
Class {
	#name : #NeoJSONValidation,
	#superclass : #Object,
	#instVars : [
		'gitDirectory',
		'logStream'
	],
	#category : 'Neo-JSON-Tests'
}

{ #category : #private }
NeoJSONValidation >> closeLog [
	logStream ifNotNil: [ 
		logStream close.
		logStream := nil ].
	^ self logFile exists
		ifTrue: [ self logFile contents ] 
		ifFalse: [ 'log file is empty' ]
]

{ #category : #private }
NeoJSONValidation >> ensureLog [
	logStream ifNil: [ 
		logStream := self logFile ensureDelete; writeStream. 
		logStream setToEnd ]
	
]

{ #category : #accessing }
NeoJSONValidation >> gitDirectory [
	^ gitDirectory ifNil: [ gitDirectory := FileLocator home / #Develop / #git ]
]

{ #category : #accessing }
NeoJSONValidation >> gitDirectory: fileReference [
	gitDirectory := fileReference
]

{ #category : #accessing }
NeoJSONValidation >> jsonTestSuiteDirectory [
	^ self gitDirectory / #JSONTestSuite
]

{ #category : #accessing }
NeoJSONValidation >> jsonTestSuiteTestParsingDirectory [
	^ self jsonTestSuiteDirectory / 'test_parsing'
]

{ #category : #accessing }
NeoJSONValidation >> jsonTestSuiteTestParsingFailFiles [
	^ self jsonTestSuiteTestParsingDirectory childrenMatching: 'n_*.json'
]

{ #category : #accessing }
NeoJSONValidation >> jsonTestSuiteTestParsingInfoFiles [
	^ self jsonTestSuiteTestParsingDirectory childrenMatching: 'i_*.json'
]

{ #category : #accessing }
NeoJSONValidation >> jsonTestSuiteTestParsingPassFiles [
	^ self jsonTestSuiteTestParsingDirectory childrenMatching: 'y_*.json'
]

{ #category : #accessing }
NeoJSONValidation >> jsonTestSuiteTestTransformDirectory [
	^ self jsonTestSuiteDirectory / 'test_transform'
]

{ #category : #private }
NeoJSONValidation >> log: message [
	self ensureLog.
	logStream nextPutAll: message; lf; flush

]

{ #category : #private }
NeoJSONValidation >> logFile [
	^ 'neo-json-validation.log' asFileReference
]

{ #category : #accessing }
NeoJSONValidation >> nativeJsonBenchmarkDataDirectory [
	^ self nativeJsonBenchmarkDirectory / #data
]

{ #category : #accessing }
NeoJSONValidation >> nativeJsonBenchmarkDirectory [
	^ self gitDirectory / 'nativejson-benchmark'
]

{ #category : #accessing }
NeoJSONValidation >> nativeJsonBenchmarkJsonCheckerDirectory [
	^ self nativeJsonBenchmarkDataDirectory / #jsonchecker
]

{ #category : #accessing }
NeoJSONValidation >> nativeJsonBenchmarkJsonCheckerFailFiles [
	^ self nativeJsonBenchmarkJsonCheckerDirectory childrenMatching: 'fail*.json'
]

{ #category : #accessing }
NeoJSONValidation >> nativeJsonBenchmarkJsonCheckerPassFiles [
	^ self nativeJsonBenchmarkJsonCheckerDirectory childrenMatching: 'pass*.json'
]

{ #category : #accessing }
NeoJSONValidation >> nativeJsonBenchmarkRoundTripDirectory [
	^ self nativeJsonBenchmarkDataDirectory / #roundtrip
]

{ #category : #accessing }
NeoJSONValidation >> nativeJsonBenchmarkRoundTripFiles [
	^ self nativeJsonBenchmarkRoundTripDirectory children
]

{ #category : #running }
NeoJSONValidation >> runJsonTestSuiteTestParsingFailures [
	^ self
		validateFiles: self jsonTestSuiteTestParsingFailFiles 
		usingTest: [ :file | 
			| data success |
			success := false.
			[ data := file readStreamDo: [ :in | (NeoJSONReader on: in) next; failIfNotAtEnd ] ]
				on: NeoJSONParseError
				do: [ :exception | self log: exception printString. success := true ].
			success ]
]

{ #category : #running }
NeoJSONValidation >> runJsonTestSuiteTestParsingInfo [
	^ self
		validateFiles: self jsonTestSuiteTestParsingInfoFiles 
		usingTest: [ :file | 
			| data success |
			success := true.
			[ data := file readStreamDo: [ :in | (NeoJSONReader on: in) next ] ]
				on: NeoJSONParseError
				do: [ :exception | self log: exception printString. success := false ].
			success ]
]

{ #category : #running }
NeoJSONValidation >> runJsonTestSuiteTestParsingPasses [
	^ self
		validateFiles: self jsonTestSuiteTestParsingPassFiles 
		usingTest: [ :file | 
			| data success |
			success := true.
			[ data := file readStreamDo: [ :in | (NeoJSONReader on: in) next ] ]
				on: NeoJSONParseError
				do: [ :exception | self log: exception printString. success := false ].
			success ]
]

{ #category : #running }
NeoJSONValidation >> runNativeJsonBenchmarkJsonCheckerFailures [
	^ self
		validateFiles: self nativeJsonBenchmarkJsonCheckerFailFiles
		usingTest: [ :file | 
			| data success |
			success := false.
			[ data := file readStreamDo: [ :in | (NeoJSONReader on: in) next; failIfNotAtEnd ] ]
				on: NeoJSONParseError
				do: [ :exception | self log: exception printString. success := true ].
			success ]
]

{ #category : #running }
NeoJSONValidation >> runNativeJsonBenchmarkJsonCheckerPasses [
	^ self
		validateFiles: self nativeJsonBenchmarkJsonCheckerPassFiles
		usingTest: [ :file | 
			| data success |
			success := true.
			[ data := file readStreamDo: [ :in | (NeoJSONReader on: in) next ] ]
				on: NeoJSONParseError
				do: [ :exception | self log: exception printString. success := false ].
			success ]
]

{ #category : #running }
NeoJSONValidation >> runNativeJsonBenchmarkRoundTrip [
	^ self 
		validateFiles: self nativeJsonBenchmarkRoundTripFiles
		usingTest: [ :file |
			| data json |
			data := file readStreamDo: [ :in | (NeoJSONReader on: in) next ].
			json := NeoJSONWriter toString: data.
			json = file contents ]
]

{ #category : #private }
NeoJSONValidation >> validateFiles: files usingTest: block [
	| total succeeded failed |
	total := succeeded := failed := 0.
	files do: [ :file | 
		| success |
		self log: 'Running ' , file pathString.
		self log: ([ file contents contractTo: 64 ] on: Error do: [ :exception | exception printString ]).
		success := [ block value: file ]
			on: Error
			do: [ :exception | self log: '  Errored. ' , exception printString. false ].
		total := total + 1.
		success
			ifTrue: [ succeeded := succeeded + 1 ]
			ifFalse: [ failed := failed + 1 ].
		self log: (success ifTrue: [ '  Succeeded' ] ifFalse: [ '  Failed' ]); log: '' ].
	self log: ('{1} total = {2} succeeded + {3} failed' format: (Array with: total with: succeeded with: failed) ).
	^ self closeLog
]
