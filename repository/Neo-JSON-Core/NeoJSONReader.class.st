"
I am NeoJSONReader.
I am a NeoJSONMapper.
I parse a JSON representation from a textual stream into Smalltalk objects.

Primitive types are automatically mapped to their Smalltalk counterpart: Numbers, Strings, Booleans and UndefinedObject.
When parsing using #next, lists normally become Arrays and maps become Dictionaries.
An alternative listClass or mapClass can be specified.

When parsing using #nextAs: a schema can be specified. This schema defines a mapping to be used.

Here are some examples:

	NeoJSONReader fromString: ' [ 1,2,3 ] '.
	NeoJSONReader fromString: ' [ 3.14159, true, false, null, ""string"" ] '.
	NeoJSONReader fromString: ' { ""x"" : 1, ""y"" : 2 } '.
	
	(NeoJSONReader on: ' { ""x"" : 1, ""y"" : 2 } ' readStream)
		mapInstVarsFor: Point;
		nextAs: Point.	
			
	(NeoJSONReader on: '[ { ""x"" : 1, ""y"" : 2 }, { ""x"" : 3, ""y"" : 4 } ]' readStream)
		mapInstVarsFor: Point;
		for: #ArrayOfPoints customDo: [ :mapping |
			mapping listOfElementSchema: Point ];
		nextAs: #ArrayOfPoints.

	(NeoJSONReader on: '[ { ""x"" : 1, ""y"" : 2 }, { ""x"" : 3, ""y"" : 4 } ]' readStream)
		mapInstVarsFor: Point;
		nextListAs: Point.
"
Class {
	#name : #NeoJSONReader,
	#superclass : #NeoJSONMapper,
	#instVars : [
		'readStream',
		'stringStream',
		'listClass',
		'mapClass',
		'propertyNamesAsSymbols'
	],
	#category : #'Neo-JSON-Core'
}

{ #category : #convenience }
NeoJSONReader class >> fromString: string [
	^ (self on: string readStream) next
]

{ #category : #convenience }
NeoJSONReader class >> fromString: string as: schema [
	^ (self on: string readStream) nextAs: schema
]

{ #category : #'instance creation' }
NeoJSONReader class >> on: readStream [
	"Initialize on readStream, which should be a character stream that 
	implements #next, #peek, #atEnd and (optionally) #close."

	^ self new
		on: readStream;
		yourself
]

{ #category : #testing }
NeoJSONReader >> atEnd [
	^ readStream atEnd
]

{ #category : #'initialize-release' }
NeoJSONReader >> close [
	readStream ifNotNil: [
		readStream close.
		readStream := nil ]
]

{ #category : #private }
NeoJSONReader >> consumeWhitespace [
	"Strip whitespaces from the input stream."

	[ readStream atEnd not and: [ readStream peek isSeparator ] ]
		whileTrue: [ 
			readStream next ]
]

{ #category : #private }
NeoJSONReader >> error: text [
	NeoJSONParseError signal: text
]

{ #category : #private }
NeoJSONReader >> expectChar: character [
	"Expect character and consume input and optional whitespace at the end,
	 throw an error otherwise."

	(self matchChar: character)
		ifFalse: [ self error: character asString, ' expected' ]
]

{ #category : #parsing }
NeoJSONReader >> failIfNotAtEnd [
	self atEnd
		ifFalse: [ self error: 'extraneous input detected' ]
]

{ #category : #'initialize-release' }
NeoJSONReader >> initialize [ 
	super initialize.
	propertyNamesAsSymbols := false
]

{ #category : #accessing }
NeoJSONReader >> listClass [
	"Return the collection type to use for JSON lists"
	
	^ listClass ifNil: [ Array ]
]

{ #category : #'initialize-release' }
NeoJSONReader >> listClass: collectionClass [
	listClass := collectionClass
]

{ #category : #accessing }
NeoJSONReader >> mapClass [
	"Return the collection type to use for JSON maps"
	
	^ mapClass ifNil: [ Dictionary ]
]

{ #category : #'initialize-release' }
NeoJSONReader >> mapClass: collectionClass [
	mapClass := collectionClass
]

{ #category : #private }
NeoJSONReader >> match: string do: block [
	"Try to read and consume string and execute block if successful.
	Else do nothing (but do not back up)"

	(string allSatisfy: [ :each | readStream peekFor: each ])
		ifTrue: [ 
			self consumeWhitespace.
			block value ]
]

{ #category : #private }
NeoJSONReader >> matchChar: character [
	"Tries to match character, consume input and 
	answer true if successful and consumes whitespace at the end.
	When character does not match, return false and leave stream untouched."

	^ (readStream peekFor: character)
		ifTrue: [ 
			self consumeWhitespace.
			true ]
		ifFalse: [ false ]
]

{ #category : #accessing }
NeoJSONReader >> next [
	"Primary interface to parse a JSON value.
	Return either primitives, a listClass or a mapClass instance."
	
	^ self 
		consumeWhitespace; 
		parseValue
]

{ #category : #accessing }
NeoJSONReader >> nextAs: schema [
	"Secondary interface to parse JSON.
	Return an object according to schema.
	If schema is nil, act like #next"
	
	| mapping |
	schema ifNil: [ ^ self next ].
	self consumeWhitespace.
	mapping := self mappingFor: schema.
	^ mapping readFrom: self
]

{ #category : #accessing }
NeoJSONReader >> nextListAs: schema [
	"Secondary interface to parse JSON.
	Return a list of objects, each element according to schema."
	
	^ self listClass streamContents: [ :stream |
			self parseListDo: [ 
				stream nextPut: (self nextAs: schema) ] ]
]

{ #category : #'initialize-release' }
NeoJSONReader >> on: aReadStream [
	"Initialize on aReadStream, which should be a character stream that 
	implements #next, #peek, #atEnd and (optionally) #close."
	
	readStream := aReadStream
]

{ #category : #parsing }
NeoJSONReader >> parseCharacter [
	| char |
	(char := readStream next) = $\ 
		ifFalse: [ ^ char ].
	('/"\' includes: (char := readStream next))
		ifTrue: [ ^ char ].
	('bfnrt' includes: char)
		ifTrue: [ ^ self unescapeChar: char ].
	char = $u
		ifTrue: [ ^ self parseCharacterHex ].
	char 
		ifNil: [ self error: 'invalid escape, end of file' ]
		ifNotNil: [ self error: 'invalid escape character \' , char asString ]
]

{ #category : #private }
NeoJSONReader >> parseCharacterHex [
	| value codePoint |
	value := self parseCharacterHex4Value.
	(value < 16rD800 or: [ value > 16rDBFF ])
		ifTrue: [ codePoint := value ]
		ifFalse: [ | leadSurrogate trailSurrogate |
			"Characters not in the Basic Multilingual Plane are encoded as a UTF-16 surrogate pair"
			"See https://tools.ietf.org/html/rfc7159#section-7"
			leadSurrogate := value.
			trailSurrogate := self parseTrailingSurrogateHexEscape.
			codePoint := (leadSurrogate - 16rD800) * 16r400 + (trailSurrogate - 16rDC00).
			codePoint := 16r10000 + codePoint.
			codePoint > 16r10FFFF 
				ifTrue: [ self error: 'Character Unicode code point outside encoder range' ] ].
	^ Character codePoint: codePoint
]

{ #category : #private }
NeoJSONReader >> parseCharacterHex4Value [
	| value |
	value := self parseCharacterHexDigit.
	3 timesRepeat: [ 
		value := (value << 4) + self parseCharacterHexDigit ].
	^ value
]

{ #category : #private }
NeoJSONReader >> parseCharacterHexDigit [
	| digit |
	readStream atEnd 
		ifFalse: [ 
			digit := readStream next asInteger.
			(digit between: "$0" 48 and: "$9" 57)
				ifTrue: [ ^ digit - 48 ].
			(digit between: "$A" 65 and: "$F" 70)
				ifTrue: [ ^ digit - 55 ].
			(digit between: "$a" 97 and: "$f" 102)
				ifTrue: [ ^ digit - 87 ] ].
	self error: 'hex-digit expected'
]

{ #category : #private }
NeoJSONReader >> parseConstantDo: block [
	"Parse and consume either true|false|nil|null and execute block 
	or else do nothing (but do not back up).
	Hand written implementation to avoid the use of #position:"
	
	(readStream peek = $t)
		ifTrue: [
			^ self match: 'true' do: [ block value: true ] ].
	(readStream peek = $f)
		ifTrue: [
			^ self match: 'false' do: [ block value: false ] ].
	(readStream peek = $n)
		ifTrue: [
			^ self match: 'null' do: [ block value: nil ] ]

]

{ #category : #parsing }
NeoJSONReader >> parseList [
	^ self listClass 
		streamContents: [ :stream |
			self parseListElementsDo: [ :each |
				stream nextPut: each ] ]

		
]

{ #category : #parsing }
NeoJSONReader >> parseListDo: block [
	self expectChar: $[.
	(self matchChar: $]) 
		ifTrue: [ ^ self ].
	[ readStream atEnd ] 
		whileFalse: [
			block value.
			(self matchChar: $]) 
				ifTrue: [ ^ self ].
			(self matchChar: $,)
				ifFalse: [ self error: ', or ] expected' ] ].
	self error: 'incomplete list'
]

{ #category : #parsing }
NeoJSONReader >> parseListElementsDo: block [
	self parseListDo: [ 
		block value: self parseValue ]
]

{ #category : #parsing }
NeoJSONReader >> parseMap [
	| map |
	map := self mapClass new.
	self parseMapKeysAndValuesDo: [ :key :value |
		map at: key put: value ].
	^ map
]

{ #category : #parsing }
NeoJSONReader >> parseMapDo: block [
	self expectChar: ${.
	(self matchChar: $})
		ifTrue: [ ^ self ].
	[ readStream atEnd ] whileFalse: [
		block value.
		(self matchChar: $}) 
			ifTrue: [ ^ self ].
		(self matchChar: $,)
			ifFalse: [ self error: ', or } expected' ] ].
	self error: 'incomplete map'
]

{ #category : #parsing }
NeoJSONReader >> parseMapKeysAndValuesDo: block [
	self parseMapKeysDo: [ :key |
		block value: key value: self parseValue ]
]

{ #category : #parsing }
NeoJSONReader >> parseMapKeysDo: block [
	self parseMapDo: [ | key |
		key := self parsePropertyName.
		self expectChar: $:.
		block value: key ]
]

{ #category : #parsing }
NeoJSONReader >> parseNumber [
	| negated number isFloat |
	negated := readStream peekFor: $-.
	number := self parseNumberInteger.
	isFloat := (readStream peekFor: $.)
		ifTrue: [ number := number + self parseNumberFraction. true ]
		ifFalse: [ false ].
	((readStream peekFor: $e) or: [ readStream peekFor: $E ])
		ifTrue: [ number := number * self parseNumberExponent ].
	isFloat ifTrue: [ number := number asFloat ].
	negated
		ifTrue: [ number := number negated ].
	self consumeWhitespace.
	^ number
]

{ #category : #parsing }
NeoJSONReader >> parseNumberExponent [
	| number negated |
	number := 0.
	(negated := readStream peekFor: $-)
		ifFalse: [ readStream peekFor: $+ ].
	(readStream atEnd or: [ readStream peek isDigit not ])
		ifTrue: [ self error: 'number exponent expected' ].
	[ readStream atEnd not and: [ readStream peek isDigit ] ]
		whileTrue: [ number := 10 * number + readStream next digitValue ].
	negated
		ifTrue: [ number := number negated ].
	number positive 
		ifTrue: [ number > Float emax ifTrue: [ self error: 'number exponent too large' ] ]
		ifFalse: [ number < Float emin ifTrue: [ self error: 'number exponent too small' ] ].
	^ 10 raisedTo: number
]

{ #category : #parsing }
NeoJSONReader >> parseNumberFraction [
	| number power |
	number := 0.
	power := 1.
	[ readStream atEnd not and: [ readStream peek isDigit ] ] 
		whileTrue: [
			number := 10 * number + readStream next digitValue.
			power := power * 10 ].
	^ number / power
]

{ #category : #parsing }
NeoJSONReader >> parseNumberInteger [
	| number |
	number := nil.
	[ readStream atEnd not and: [ readStream peek isDigit ] ] 
		whileTrue: [ 
			number := 10 * (number ifNil: [ 0 ]) + readStream next digitValue ].
	number ifNil: [ self error: 'Integer digit expected' ].
	^ number
]

{ #category : #parsing }
NeoJSONReader >> parsePropertyName [
	| name |
	name := self parseValue.
	^ name isString
		ifTrue: [ 
			propertyNamesAsSymbols 
				ifTrue: [ name asSymbol ]
				ifFalse: [ name ] ]
		ifFalse: [ 
			self error: 'property name must be a string, not ', name asString ]
]

{ #category : #parsing }
NeoJSONReader >> parseString [
	| result |
	(readStream peekFor: $")
		ifFalse: [ self error: '" expected' ].
	result := self stringStreamContents: [ :stream | 
		[ readStream atEnd or: [ readStream peek = $" ] ] 
			whileFalse: [ stream nextPut: self parseCharacter ] ].
	self expectChar: $".
	^ result
]

{ #category : #private }
NeoJSONReader >> parseTrailingSurrogateHexEscape [
	(readStream next = $\ and: [ readStream next = $u ])
		ifTrue: [ ^ self parseCharacterHex4Value ]
		ifFalse: [ self error: 'trailing surrogate hex escape expected' ]
]

{ #category : #parsing }
NeoJSONReader >> parseValue [
	| char |
	readStream atEnd ifFalse: [ 
		char := readStream peek.
		char = ${
			ifTrue: [ ^ self parseMap ].
		char = $[
			ifTrue: [ ^ self parseList ].
		char = $"
			ifTrue: [ ^ self parseString ].
		(char = $- or: [ char isDigit ])
			ifTrue: [ ^ self parseNumber ].
		self parseConstantDo: [ :value | ^ value ] ].
	self error: 'invalid input: ', char asString
]

{ #category : #'initialize-release' }
NeoJSONReader >> propertyNamesAsSymbols: boolean [
	propertyNamesAsSymbols := boolean
]

{ #category : #private }
NeoJSONReader >> stringStreamClass [
	"Answer the class of the collection used for the stringStream of receiver.
	
	NOTE: It is String, but if receiver's readStream is over 
	another class of String, then this provides compatibility for that."

	^ readStream collectionSpecies
]

{ #category : #private }
NeoJSONReader >> stringStreamContents: block [
	"Like String streamContents: block
	but reusing the underlying buffer for improved efficiency"

	stringStream ifNil: [ 
		stringStream := (self stringStreamClass new: 32) writeStream ].
	stringStream reset.
	block value: stringStream.
	^ stringStream contents
]

{ #category : #private }
NeoJSONReader >> unescapeChar: char [
	"Handle one of the named character escapes, b, f, n, r or t. Else fail."
	
	char = $b
		ifTrue: [ ^ Character backspace ].
	char = $f
		ifTrue: [ ^ Character newPage ].
	char = $n
		ifTrue: [ ^ Character lf ].
	char = $r
		ifTrue: [ ^ Character cr ].
	char = $t
		ifTrue: [ ^ Character tab ].
	self error: 'Unknown escape char: ', (String with: char)
]
