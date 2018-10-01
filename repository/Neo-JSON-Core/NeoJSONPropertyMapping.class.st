"
I am NeoJSONPropertyMapping.
I describe how a property of a Smalltalk class maps to a JSON property.

A property is either an instance variable or getter/setter pair.
I hold a getter and setter block to do the actual work. The property name is used in JSON.

Optionally, the schema for the value of my property can be specified. This is then used recursively.
"
Class {
	#name : #NeoJSONPropertyMapping,
	#superclass : #Object,
	#instVars : [
		'propertyName',
		'valueSchema',
		'getter',
		'setter'
	],
	#category : 'Neo-JSON-Core'
}

{ #category : #accessing }
NeoJSONPropertyMapping >> getter: block [
	getter := block
]

{ #category : #printing }
NeoJSONPropertyMapping >> printOn: stream [
	super printOn: stream.
	stream nextPut: $(; print: propertyName; nextPut: $)
]

{ #category : #accessing }
NeoJSONPropertyMapping >> propertyName [
	^ propertyName 
]

{ #category : #accessing }
NeoJSONPropertyMapping >> propertyName: symbolOrString [
	propertyName := symbolOrString asSymbol
]

{ #category : #parsing }
NeoJSONPropertyMapping >> readObject: anObject from: jsonReader [
	| value |
	value := jsonReader nextAs: valueSchema.
	setter value: anObject value: value
]

{ #category : #accessing }
NeoJSONPropertyMapping >> setter: block [
	setter := block
]

{ #category : #accessing }
NeoJSONPropertyMapping >> valueSchema: schemaName [
	valueSchema := schemaName
]

{ #category : #writing }
NeoJSONPropertyMapping >> writeObject: anObject on: jsonMapWriter [
	| value |
	value := getter value: anObject.
	(value notNil or: [ jsonMapWriter writeNil ])
		ifTrue: [ jsonMapWriter writeKey: propertyName value: value as: valueSchema ] 
]
