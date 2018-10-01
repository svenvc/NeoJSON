"
I am NeoJSONMappingNotFound. I am signalled when no mapping is found for a schema.

Portability comment: In Pharo,  I could technically subclass from NotFound directly, avoid all my defined methods and only keep #messageText and #standardMessageText. However, NotFound exception does not exist in other dialects. To keep NeoJSON as portable as possible we duplicate some Pharo code into myself. 
"
Class {
	#name : #NeoJSONMappingNotFound,
	#superclass : #Error,
	#instVars : [
		'object',
		'collection'
	],
	#category : 'Neo-JSON-Core'
}

{ #category : #'instance creation' }
NeoJSONMappingNotFound class >> signalFor: anObject [
	"Create and signal an exception for anObject in the default receiver."
	
	^ self new
		object: anObject;
		signal
]

{ #category : #'instance creation' }
NeoJSONMappingNotFound class >> signalFor: anObject in: aCollection [
	"Create and signal an exception for anObject in aCollection."

	^ self new
		object: anObject;
		collection: aCollection;
		signal
]

{ #category : #accessing }
NeoJSONMappingNotFound >> collection [
	"Return the collection where something is not found in"
	
	^ collection
]

{ #category : #accessing }
NeoJSONMappingNotFound >> collection: aCollection [
	"Set the collection where something is not found in"
	
	collection := aCollection
]

{ #category : #accessing }
NeoJSONMappingNotFound >> messageText [
	"Overwritten with standard text. To ease portability to other Smalltalk dialects we do not access the instVar 'messageText' as not all dialects have it. Not caching the value on the instVar shouldn't bring any performance hit in this case. "
	
	^ self standardMessageText 
]

{ #category : #accessing }
NeoJSONMappingNotFound >> object [
	"Return the object that was not found"
	
	^ object
]

{ #category : #accessing }
NeoJSONMappingNotFound >> object: anObject [
	"Set the object that was not found"
	
	object := anObject
]

{ #category : #private }
NeoJSONMappingNotFound >> standardMessageText [
	^ String streamContents: [ :stream |
		stream << 'No mapping found for '.
		stream print: self object.
		stream << ' in '.
		stream print: self collection class ]
]
