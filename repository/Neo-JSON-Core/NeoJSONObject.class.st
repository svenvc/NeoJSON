"
I am NeoJSONObject.
I am a Dictionary.

I behave more like a JavaScript object. I return nil for missing keys. I allow any property to be read or set by using a normal accessor message.

The following are equivalent:

	self foo.
	self at: #foo.

As are the following

	self foo: 1. 
	self at: #foo put: 1.
	
Except that in the first case, self is returned.

I can optionally be used by NeoJSONReader as mapClass (see #mapClass:).

For output, I act just like my superclass (it is thus not necessary to do any conversions).

Example:

	NeoJSONObject fromString: '{""foo"":1,""bar"":-2}'.
	NeoJSONObject new foo: 1; bar: -2.
	{ #x -> 100. #y -> 200 } as: NeoJSONObject.
	(NeoJSONObject new data: (NeoJSONObject new id: #sensor1; value: 37.5)) asString.

I use JSON as my printed representation. To convert me to JSON, use #printString or #asString.

Additionally, I support path access for nested instances of me, using #atPath: and #atPath:put:

The first is special because it returns nil as soon as a key is missing. The second is special because it creates extra levels (instances of me) as needed to follow the path of keys.

	NeoJSONObject new atPath: #(one two three) put: 42; yourself.
	NeoJSONObject new atPath: #(one two three) put: 42; atPath: #(one two three).
		
"
Class {
	#name : #NeoJSONObject,
	#superclass : #Dictionary,
	#category : 'Neo-JSON-Core'
}

{ #category : #convenience }
NeoJSONObject class >> fromString: string [
	"Parse string as JSON, so that maps become instances of me"

	^ (NeoJSONReader on: string readStream)
			mapClass: NeoJSONObject;
			propertyNamesAsSymbols: true;
			next
]

{ #category : #accessing }
NeoJSONObject >> at: key [
	"I return nil for missing keys.
	My superclass would signal a KeyNotFound."
	
	^ self at: key ifAbsent: [ nil ]
]

{ #category : #accessing }
NeoJSONObject >> atPath: keyCollection [
	"Use each key in keyCollection recursively, stop when nil is encountered"
	
	| value |
	value := self.
	keyCollection do: [ :each |
		value := value at: each.
		value ifNil: [ ^ nil ] ].
	^ value 
]

{ #category : #accessing }
NeoJSONObject >> atPath: keyCollection put: newValue [
	"Use each key in keyCollection recursively, create new levels when needed"
	
	| target |
	keyCollection ifEmpty: [ ^ self ].
	target := self.
	keyCollection allButLastDo: [ :each |
		(target at: each)
			ifNil: [ target := target at: each put: target species new ]
			ifNotNil: [ :subValue | target := subValue ] ].
	^ target at: keyCollection last put: newValue
]

{ #category : #'reflective operations' }
NeoJSONObject >> doesNotUnderstand: message [
	"Overwritten so that 'self foo' becomes 'self at: #foo'
	and 'self foo: 1' becomes 'self at: #foo put: 1' except that self is returned"
	
	| key |
	key := message selector.
	key isUnary
		ifTrue: [ ^ self at: key ].
	^ (key isKeyword and: [ key numArgs = 1 ])
		ifTrue: [ self at: key allButLast asSymbol put: message arguments first; yourself ]
		ifFalse: [ super doesNotUnderstand: message ]
]

{ #category : #accessing }
NeoJSONObject >> name [
	"Overwritten to make this accessor available as key"
	
	^ self at: #name
]

{ #category : #printing }
NeoJSONObject >> printOn: stream [
	"I use my JSON representation when printing myself"

	[ (NeoJSONWriter on: stream) nextPut: self ]
		on: Error
		do: [ :exception | 
			stream
				nextPutAll: ' Error printing JSON: ';
				nextPutAll: exception printString ]
]

{ #category : #evaluating }
NeoJSONObject >> value [
	"Overwritten to make this accessor available as key"
	
	^ self at: #value
]
