"
I am NeoJSONWriter.
I am a NeoJSONMapper.
I write a JSON representation of Smalltalk objects to a textual stream.

Objects implementing #neoJsonOn: can be encoded.
A number of primitive types, like Strings, Numbers, Booleans and UndefinedObject are treated specially.
Collection are encoded as lists, except for Dictionaries that are encoded as maps.

All other objects need a mapping to help in doing the encoding.

Here are some examples:

	NeoJSONWriter toString: #(1 2 3).
	NeoJSONWriter toString: { Float pi. true. false. 'string' }.
	NeoJSONWriter toStringPretty: (Dictionary new at: #x put: 1; at: #y put: 2; yourself).
	
	String streamContents: [ :stream |
		(NeoJSONWriter on: stream)
			prettyPrint: true;
			mapInstVarsFor: Point;
			nextPut: (Array with: 1@3 with: -1@3) ].
	
"
Class {
	#name : #NeoJSONWriter,
	#superclass : #NeoJSONMapper,
	#instVars : [
		'writeStream',
		'prettyPrint',
		'level',
		'newLine',
		'asciiOnly',
		'writeNil',
		'floatPrinter'
	],
	#category : #'Neo-JSON-Core'
}

{ #category : #'instance creation' }
NeoJSONWriter class >> on: writeStream [
	"Initialize on writeStream, which should be a character stream that 
	implements #nextPut:, #nextPutAll:, #space and (optionally) #close."

	^ self new
		on: writeStream;
		yourself
]

{ #category : #convenience }
NeoJSONWriter class >> toString: object [
	^ String streamContents: [ :stream |
			(self on: stream) nextPut: object ]
]

{ #category : #convenience }
NeoJSONWriter class >> toStringPretty: object [
	^ String streamContents: [ :stream |
			(self on: stream)
				prettyPrint: true; 
				nextPut: object ]
]

{ #category : #'initialize-release' }
NeoJSONWriter >> asciiOnly: boolean [
	"Set whether I should escape all non ASCII characters or not"
	
	asciiOnly := boolean
]

{ #category : #'initialize-release' }
NeoJSONWriter >> close [
	"Close the stream that I write to"
	
	writeStream ifNotNil: [
		writeStream close.
		writeStream := nil ]
]

{ #category : #private }
NeoJSONWriter >> doesCodePointNeedEscaping: code [
	code < 32 ifTrue: [ ^ true ].
	( code = 34 or: [ code = 92 ]) ifTrue: [ ^ true ].
	^ asciiOnly and: [ code > 126 ]	
]

{ #category : #private }
NeoJSONWriter >> encodeChar: char [
	| code |
	code := char codePoint.
	(self doesCodePointNeedEscaping: code)
		ifTrue: [ self escapeChar: code ]
		ifFalse: [ writeStream nextPut: char ]
]

{ #category : #private }
NeoJSONWriter >> encodeKey: key [
	key isString ifFalse: [ ^ self error: 'JSON key names in objects must be strings' ].
	self nextPut: key.
	self prettyPrintSpace.
	writeStream nextPut: $:.
	self prettyPrintSpace
]

{ #category : #private }
NeoJSONWriter >> encodeKey: key value: value [
	self encodeKey: key.
	self nextPut: value
]

{ #category : #private }
NeoJSONWriter >> encodeKey: key value: value as: valueSchema [
	self encodeKey: key.
	self nextPut: value as: valueSchema
]

{ #category : #private }
NeoJSONWriter >> escapeChar: code [
	code = 34
		ifTrue: [ ^ writeStream nextPutAll: '\"' ].
	code = 92
		ifTrue: [ ^ writeStream nextPutAll: '\\' ].
	code = 47
		ifTrue: [ ^ writeStream nextPutAll: '\/' ].
	code = 8
		ifTrue: [ ^ writeStream nextPutAll: '\b' ].
	code = 12
		ifTrue: [ ^ writeStream nextPutAll: '\f' ].		
	code = 10
		ifTrue: [ ^ writeStream nextPutAll: '\n' ].		
	code = 13
		ifTrue: [ ^ writeStream nextPutAll: '\r' ].		
	code = 9
		ifTrue: [ ^ writeStream nextPutAll: '\t' ].		
	self escapeUnicode: code
]

{ #category : #private }
NeoJSONWriter >> escapeUnicode4: codePoint [
	writeStream nextPutAll: '\u'.
	codePoint printOn: writeStream base: 16 nDigits: 4
]

{ #category : #private }
NeoJSONWriter >> escapeUnicode: codePoint [
	codePoint <= 16rFFFF
		ifTrue: [ self escapeUnicode4: codePoint ]
		ifFalse: [ 
			codePoint <= 16r10FFFF
				ifTrue: [ | leadSurrogate trailSurrogate shifted |
					"Characters not in the Basic Multilingual Plane are encoded as a UTF-16 surrogate pair"
					"See https://tools.ietf.org/html/rfc7159#section-7"
					shifted := codePoint - 16r10000.
					leadSurrogate := 16rD800 + (shifted // 16r400).
					trailSurrogate := 16rDC00 + (shifted \\ 16r400).
					self escapeUnicode4: leadSurrogate.
					self escapeUnicode4: trailSurrogate ]
				ifFalse: [ self error: 'Character Unicode code point outside encoder range' ] ]
]

{ #category : #'initialize-release' }
NeoJSONWriter >> floatPrinter: anObject [
	"Set the float print, an object that implements #printFloat:on:
	By default, I am my own float printer"
	
	floatPrinter := anObject
]

{ #category : #private }
NeoJSONWriter >> indentedDo: block [
	level := level + 1.
	block value.
	level := level - 1
]

{ #category : #'initialize-release' }
NeoJSONWriter >> initialize [
	super initialize.
	self newLine: OSPlatform current lineEnding.
	self prettyPrint: false.
	self asciiOnly: false.
	self writeNil: false.
	self floatPrinter: self.
	level := 0
]

{ #category : #private }
NeoJSONWriter >> listElementSeparator [
	writeStream nextPut: $,.
	self newlineIndent

]

{ #category : #private }
NeoJSONWriter >> mapElementSeparator [
	writeStream nextPut: $,.
	self newlineIndent

]

{ #category : #'initialize-release' }
NeoJSONWriter >> newLine: string [
	"Set the newline string that I should use when pretty printing"
	
	newLine := string
]

{ #category : #accessing }
NeoJSONWriter >> newline [
	"Write a newline on the stream that I wrap.
	What gets written depends on the configuration, see #newLine:"
	
	writeStream nextPutAll: newLine
]

{ #category : #private }
NeoJSONWriter >> newlineIndent [
	prettyPrint
		ifTrue: [ 
			self newline.
			level timesRepeat: [ writeStream nextPut: Character tab ] ]
]

{ #category : #accessing }
NeoJSONWriter >> nextPut: anObject [
	"Primary interface. Write a JSON representation of anObject to my stream."
	
	anObject neoJsonOn: self
]

{ #category : #accessing }
NeoJSONWriter >> nextPut: anObject as: schema [
	"Secondary interface to write JSON.
	Write objects according to schema."
	
	| mapping |
	(schema isNil or: [ anObject isNil ]) ifTrue: [ ^ self nextPut: anObject ].
	mapping := self mappingFor: schema.
	^ mapping writeObject: anObject on: self
]

{ #category : #'initialize-release' }
NeoJSONWriter >> on: aWriteStream [
	"Initialize on aWriteStream, which should be a character stream that 
	implements #nextPut:, #nextPutAll:, #space and (optionally) #close."

	writeStream := aWriteStream

]

{ #category : #'initialize-release' }
NeoJSONWriter >> prettyPrint: boolean [
	"Set whether I should pretty print the JSON that I write"

	prettyPrint := boolean
]

{ #category : #private }
NeoJSONWriter >> prettyPrintSpace [
	prettyPrint
		ifTrue: [ writeStream nextPut: Character space ]
]

{ #category : #printing }
NeoJSONWriter >> printFloat: float on: stream [
	"See NeoJSONFloatPrinter for a custom float printer"
	
	float printOn: stream
]

{ #category : #writing }
NeoJSONWriter >> writeBoolean: boolean [
	boolean printOn: writeStream
]

{ #category : #writing }
NeoJSONWriter >> writeFloat: float [
	floatPrinter printFloat: float on: writeStream
]

{ #category : #writing }
NeoJSONWriter >> writeInteger: integer [
	integer printOn: writeStream
	
]

{ #category : #writing }
NeoJSONWriter >> writeList: collection [
	self writeListStreamingDo: [ :jsonListWriter |
		collection do: [ :each |
			jsonListWriter writeElement: each ] ]
]

{ #category : #writing }
NeoJSONWriter >> writeListStreamingDo: block [
	writeStream nextPut: $[.
	self writeStreamingDo: block.
	writeStream nextPut: $]
]

{ #category : #writing }
NeoJSONWriter >> writeMap: keyValueCollection [
	self writeMapStreamingDo: [ :jsonMapWriter |
		keyValueCollection keysAndValuesDo: [ :key :value |
			jsonMapWriter writeKey: key value: value ] ]
]

{ #category : #writing }
NeoJSONWriter >> writeMapStreamingDo: block [
	writeStream nextPut: ${.
	self writeStreamingDo: block.
	writeStream nextPut: $}
]

{ #category : #accessing }
NeoJSONWriter >> writeNil [
	"Return whether I will write nil/null properties of objects or skip them."
	
	^ writeNil
]

{ #category : #'initialize-release' }
NeoJSONWriter >> writeNil: boolean [
	"Set whether I will write nil/null properties of objects or skip them."
	
	writeNil := boolean
]

{ #category : #writing }
NeoJSONWriter >> writeNull [
	writeStream nextPutAll: 'null'
]

{ #category : #writing }
NeoJSONWriter >> writeObject: anObject [
	| mapping |
	mapping := self mappingFor: anObject class.
	mapping
		writeObject: anObject
		on: self
]

{ #category : #writing }
NeoJSONWriter >> writeStreamingDo: block [
	| mapWriter |
	mapWriter := NeoJSONStreamingWriter on: self.
	self indentedDo: [
		block value: mapWriter ].
	mapWriter wasUsed
		ifTrue: [ self newlineIndent ]
		ifFalse: [ self prettyPrintSpace ]
]

{ #category : #writing }
NeoJSONWriter >> writeString: string [
	writeStream nextPut: $".
	1 to: string size do: [ :index |
		self encodeChar: (string at: index) ].
	writeStream nextPut: $"
]
