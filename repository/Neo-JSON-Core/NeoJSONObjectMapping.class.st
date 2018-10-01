"
I am NeoJSONObjectMapping.
I describe how instances of a Smalltalk class are mapped to a JSON map.

I do this using set of NeoJSONPropertyMappings.

I know the Smalltalk class that I am a mapping for. This class is the schema identifier and is used to instanciate new objects.

A mapping can be based on any combination of instance variables or accessors (getter/setter pairs). 

I offer a builder interface to constuct property mappings.
"
Class {
	#name : #NeoJSONObjectMapping,
	#superclass : #NeoJSONMapping,
	#instVars : [
		'subjectClass',
		'properties',
		'allowNil'
	],
	#category : 'Neo-JSON-Core'
}

{ #category : #'initialize-release' }
NeoJSONObjectMapping >> allowNil [
	"Set that I will allow nil/null values when I read/expect an object"
	
	allowNil := true
]

{ #category : #accessing }
NeoJSONObjectMapping >> identifier [
	^ subjectClass 
]

{ #category : #'initialize-release' }
NeoJSONObjectMapping >> initialize [
	super initialize.
	properties := OrderedCollection new.
	allowNil := false
]

{ #category : #mapping }
NeoJSONObjectMapping >> mapAccessor: accessor [
	^ self mapAccessor: accessor to: accessor 
]

{ #category : #mapping }
NeoJSONObjectMapping >> mapAccessor: accessor mutator: mutator to: propertyName [
	^ self 
		mapProperty: propertyName
		getter: [ :object | object perform: accessor ]
		setter: [ :object :value | object perform: mutator with: value ] 
]

{ #category : #mapping }
NeoJSONObjectMapping >> mapAccessor: accessor to: propertyName [
	^ self 
		mapProperty: propertyName
		getter: [ :object | object perform: accessor ]
		setter: [ :object :value | object perform: accessor asMutator with: value ] 
]

{ #category : #mapping }
NeoJSONObjectMapping >> mapAccessors: accessors [
	^ accessors collect: [ :each | self mapAccessor: each ]
]

{ #category : #convenience }
NeoJSONObjectMapping >> mapAllInstVars [
	^ self mapInstVars: subjectClass allInstVarNames
]

{ #category : #mapping }
NeoJSONObjectMapping >> mapInstVar: instVarName [
	^ self mapInstVar: instVarName to: instVarName 
]

{ #category : #mapping }
NeoJSONObjectMapping >> mapInstVar: instVarName to: propertyName [
	| index |
	index := 
		"For portability reasons, do not use instVarIndexFor:ifAbsent: 
		(it doesn't exist in all Smalltalk dialects) but the below approach.
		Also, convert to symbols for portability reasons"
		(subjectClass allInstVarNames collect: [ :each | each asSymbol ]) 
			indexOf: instVarName asSymbol 
			ifAbsent: [ self error: 'Inst var not found: ', instVarName printString ].
	^ self 
		mapProperty: propertyName asString
		getter: [ :object | object instVarAt: index ]
		setter: [ :object :value | object instVarAt: index put: value ] 
	

]

{ #category : #convenience }
NeoJSONObjectMapping >> mapInstVars [
	^ self mapInstVars: subjectClass instVarNames
]

{ #category : #mapping }
NeoJSONObjectMapping >> mapInstVars: instVarNames [
	^ instVarNames collect: [ :each | self mapInstVar: each ]
]

{ #category : #mapping }
NeoJSONObjectMapping >> mapProperty: propertyName getter: readBlock setter: writeBlock [
	| propertyMapping |
	propertyMapping := NeoJSONPropertyMapping new.
	propertyMapping 
		propertyName: propertyName;
		getter: readBlock;
		setter: writeBlock.
	properties removeAllSuchThat: [ :each | each propertyName = propertyMapping propertyName ].
	properties addLast: propertyMapping.
	^ propertyMapping 
]

{ #category : #accessing }
NeoJSONObjectMapping >> propertyNamed: propertyName ifAbsent: block [
	| symbolPropertyName |
	symbolPropertyName := propertyName asSymbol.
	^ properties detect: [ :each | each propertyName = symbolPropertyName ] ifNone: block
]

{ #category : #parsing }
NeoJSONObjectMapping >> readFrom: jsonReader [
	| anObject |
	anObject := subjectClass new.
	allowNil ifTrue: [ 
		jsonReader parseConstantDo: [ :value | 
			^ value ifNotNil: [ jsonReader error: 'Unexpected boolean constant' ] ] ].
	jsonReader parseMapKeysDo: [ :key |
		(self propertyNamed: key ifAbsent: [ nil ])
			ifNil: [
				"read, skip & ignore value"
				jsonReader next ]
			ifNotNil: [ :mapping |
				mapping readObject: anObject from: jsonReader ] ].
	^ anObject
]

{ #category : #accessing }
NeoJSONObjectMapping >> subjectClass: smalltalkClass [
	subjectClass := smalltalkClass
]

{ #category : #writing }
NeoJSONObjectMapping >> writeObject: anObject on: jsonWriter [
	jsonWriter writeMapStreamingDo: [ :jsonMapWriter |
		properties do: [ :each |
			each writeObject: anObject on: jsonMapWriter ] ]
]
