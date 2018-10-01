"
I am NeoJSONMapper.
I hold a mapping from schema identifiers to objects that known how to read or write instances from or to JSON.

Schema identifiers are either Smalltalk classes or Symbols.

I offer a builder interface to construct mappings. 

The standard object mapping represents a Smalltalk object as a map, mapping some or all instance variables, or a set of accessors (getter/setter methods). Furthermore, for each value an optional schema can be specified.

Using a custom mapping, a reader and/or writer block can deal with special cases such as specific collection types with an optional schema for the elements, or a direct mapping of semi primitive types such as Date or DateAndTime.

A mapping can be specified explicitely on a mapper, or can be resolved using the #neoJsonMapping: class method.

Here are some examples:

	mapper mapAllInstVarsFor: Point.
	mapper for: TestObject do: [ :mapping |
		mapping mapInstVars: #(id name).
		(mapping mapInstVar: #timestamp to: 'created-at') valueSchema: DateAndTime.
		(mapping mapInstVar: #points) valueSchema: #ArrayOfPoints.
		(mapping mapInstVar: #bytes) valueSchema: ByteArray ].
	mapper for: DateAndTime customDo: [ :mapping |
		mapping decoder: [ :string | DateAndTime fromString: string ].
		mapping encoder: [ :dateAndTime | dateAndTime printString ] ].
	mapper for: #ArrayOfPoints customDo: [ :mapping |
		mapping listOfElementSchema: Point ].  
	mapper for: ByteArray customDo: [ :mapping |
		mapping listOfType: ByteArray ]

"
Class {
	#name : #NeoJSONMapper,
	#superclass : #Object,
	#instVars : [
		'mappings'
	],
	#category : 'Neo-JSON-Core'
}

{ #category : #private }
NeoJSONMapper >> customMappingFor: schemaName [
	^ self mappings
		at: schemaName
		ifAbsentPut: [ 
			NeoJSONCustomMapping new
				schemaName: schemaName;
				yourself ]
]

{ #category : #mapping }
NeoJSONMapper >> for: schemaName customDo: block [
	"Execute the code in block to further customize the mapping for schemaName.
	Create and add a new custom mapping for schemaName if necessary."
	
	| mapping |
	mapping := self customMappingFor: schemaName.
	block value: mapping.
	^ mapping
]

{ #category : #mapping }
NeoJSONMapper >> for: smalltalkClass do: block [
	"Execute the code in block to further customize the mapping for schemaName.
	Create and add a new standard object mapping for schemaName if necessary."
	
	| mapping |
	mapping := self objectMappingFor: smalltalkClass.
	block value: mapping.
	^ mapping
]

{ #category : #convencience }
NeoJSONMapper >> mapAllInstVarsFor: smalltalkClass [
	"Map the instance variables of smalltalkClass and all its super classes"

	| mapping |
	mapping := self objectMappingFor: smalltalkClass.
	mapping mapAllInstVars.
	^ mapping
]

{ #category : #convencience }
NeoJSONMapper >> mapInstVarsFor: smalltalkClass [
	"Map the instance variables of smalltalkClass"

	| mapping |
	mapping := self objectMappingFor: smalltalkClass.
	mapping mapInstVars.
	^ mapping
]

{ #category : #accessing }
NeoJSONMapper >> mappingFor: schema [
	^ self 
		mappingFor: schema 
		ifAbsent: [ NeoJSONMappingNotFound signalFor: schema in: self ]
]

{ #category : #accessing }
NeoJSONMapper >> mappingFor: schema ifAbsent: block [
	(self mappings includesKey: schema)
		ifFalse: [ self resolveMappingFor: schema ].
	^ self mappings
		at: schema
		ifAbsent: block
]

{ #category : #private }
NeoJSONMapper >> mappings [
	^ mappings
		ifNil: [ mappings := Dictionary new ]
]

{ #category : #private }
NeoJSONMapper >> objectMappingFor: smalltalkClass [
	^ self mappings
		at: smalltalkClass
		ifAbsentPut: [ 
			NeoJSONObjectMapping new
				subjectClass: smalltalkClass;
				yourself ]
]

{ #category : #private }
NeoJSONMapper >> resolveMappingFor: class [
	(class respondsTo: #neoJsonMapping:)
		ifTrue: [ 
			class perform: #neoJsonMapping: with: self ]
]
