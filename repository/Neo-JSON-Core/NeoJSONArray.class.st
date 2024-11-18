"
I am NeoJSONArray.
I am an Array.

I am often used in combination with NeoJSONObject, to represent the result of parsing JSON.
 
 I support path access for nested instances of me, using #atPath: and #atPath:put:
 
Used in its generic way, NeoJSONParser will return Arrays and Dictionaries.
Returning NeoJSONArrays and NeoJSONObjects, simple subclasses, allows to add some convenience methods.

"
Class {
	#name : #NeoJSONArray,
	#superclass : #OrderedCollection,
	#category : #'Neo-JSON-Core'
}

{ #category : #example }
NeoJSONArray class >> exampleNumbers [
	<gtExample>
	| numbers |
	numbers := self new: 128 withAll: nil.
	0 to: 127 do: [ :n | 
		numbers
			at: n + 1
			put: (NeoJSONObject new
					integer: n;
					decimal: (n printStringBase: 10);
					octal: (n printStringBase: 8);
					hexadecimal: (n printStringBase: 16);
					binary: (n printStringBase: 2);
					roman: n printStringRoman;
					words: n asWords;
					prime: n isPrime;
					character: n asCharacter asString) ].
	^ numbers
]

{ #category : #example }
NeoJSONArray class >> exampleSimple [
	<gtExample>
	^ self withAll: { 0 . 1 . Float pi. 'string' . true . false. nil }
]

{ #category : #adding }
NeoJSONArray >> at: index add: object [
	^ index = '-'
		ifTrue: [ self addLast: object ]
		ifFalse: [ self insert: object before: index ]
]

{ #category : #accessing }
NeoJSONArray >> atPath: keyCollection [
	"Use each key in keyCollection recursively, return nil when a key is missing.
	Note how keys can also be indexes to arrays."

	| value |
	value := self.
	keyCollection do: [ :each |
		value := value at: each ifAbsent: [ ^ nil ] ].
	^ value
]

{ #category : #adding }
NeoJSONArray >> atPath: keyCollection add: newValue [
	"Use each key in keyCollection recursively, create new levels when needed.
	Note how keys can also be indexes to arrays.
	This variant will insert/add to arrays"

	| target |
	keyCollection ifEmpty: [ ^ self ].
	target := self.
	keyCollection allButLastDo: [ :each |
		target := target 
			at: each
			ifAbsent: [ target at: each add: target species new ] ].
	^ target at: keyCollection last add: newValue
]

{ #category : #accessing }
NeoJSONArray >> atPath: keyCollection put: newValue [
	"Use each key in keyCollection recursively, create new levels when needed.
	Note how keys can also be indexes to arrays."

	| target |
	keyCollection ifEmpty: [ ^ self ].
	target := self.
	keyCollection allButLastDo: [ :each |
		target := target 
			at: each
			ifAbsent: [ target at: each put: target species new ] ].
	^ target at: keyCollection last put: newValue
]

{ #category : #accessing }
NeoJSONArray >> findPath: conditionBlock [
	"Find and return the first path to an object in the graph that I represent 
	for which conditionBlock holds. Return nil when not found."

	(conditionBlock value: self) ifTrue: [ ^ #(()) ].
	self doWithIndex: [ :value :index |
		(conditionBlock value: value) ifTrue: [ ^ { index } ].
		(value isCollection and: [ value isString not ]) ifTrue: [
			(value findPath: conditionBlock) ifNotNil: [ :subPath |
				^ { index } , subPath ] ] ].
	^ nil
]

{ #category : #accessing }
NeoJSONArray >> findPaths: conditionBlock [
	"Find and return all paths to objects in the graph that I represent 
	for which conditionBlock holds. Return an empty collection when none are found."

	| found |
	found := OrderedCollection new.	
	self doWithIndex: [ :value :index |
		(conditionBlock value: value) ifTrue: [ found add: { index } ].
		(value isCollection and: [ value isString not ]) ifTrue: [
			(value findPaths: conditionBlock) do: [ :subPath |
				found add: { index } , subPath ] ] ].
	^ found
]

{ #category : #print }
NeoJSONArray >> printOn: stream [
	"I use my JSON representation when printing myself"

	[ (NeoJSONWriter on: stream) nextPut: self ]
		on: Error
		do: [ :exception |
			stream
				nextPutAll: ' Error printing JSON: ';
				print: exception ]
]

{ #category : #removing }
NeoJSONArray >> removeKey: index [
	"Polymorphic with NeoJSONObject: remove the element at index"

	^ self removeAt: index
]
