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
	#superclass : #Array,
	#type : #variable,
	#category : #'Neo-JSON-Core'
}

{ #category : #example }
NeoJSONArray class >> exampleNumbers [
	<gtExample>
	| numbers |
	numbers := self new: 128.
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
