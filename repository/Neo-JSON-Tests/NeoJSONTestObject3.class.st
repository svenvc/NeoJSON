"
I am NeoJSONTestObject3, a subclass of NeoJSONTestObject2.

Instance Variables
	color:			<String>
	transparent :	<Boolean>

I am used for inheritance testing.

"
Class {
	#name : #NeoJSONTestObject3,
	#superclass : #NeoJSONTestObject2,
	#instVars : [
		'color',
		'transparent'
	],
	#category : 'Neo-JSON-Tests'
}

{ #category : #'instance creation' }
NeoJSONTestObject3 class >> example1 [
	^ super example1
		data: (String new: 8 withAll: $a);
		color: 'red';
		transparent: true;
		yourself
]

{ #category : #accessing }
NeoJSONTestObject3 class >> neoJsonMapping: mapper [
	"For inheritance mapping to work, the schema/classname must be self,
	but the instance variables have to be enumerated manually per class"
	
	super neoJsonMapping: mapper.
	mapper for: self do: [ :mapping |
		mapping mapInstVars: #(color transparent) ]
]

{ #category : #comparing }
NeoJSONTestObject3 >> = anObject [
	^ super = anObject 
		and: [ color = anObject color
			and: [ transparent = anObject transparent ] ]
]

{ #category : #converting }
NeoJSONTestObject3 >> asDictionary [
	^ super asDictionary
		at: #color put: color;
		at: #transparent put: transparent;
		yourself
]

{ #category : #accessing }
NeoJSONTestObject3 >> color [
	^ color
]

{ #category : #accessing }
NeoJSONTestObject3 >> color: anObject [
	color := anObject
]

{ #category : #accessing }
NeoJSONTestObject3 >> transparent [
	^ transparent
]

{ #category : #accessing }
NeoJSONTestObject3 >> transparent: anObject [
	transparent := anObject
]
