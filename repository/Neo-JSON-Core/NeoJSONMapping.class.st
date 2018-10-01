"
I am NeoJSONMapping, an abstract superclass for mapping definitions.

"
Class {
	#name : #NeoJSONMapping,
	#superclass : #Object,
	#category : 'Neo-JSON-Core'
}

{ #category : #accessing }
NeoJSONMapping >> identifier [
	self subclassResponsibility 
]

{ #category : #printing }
NeoJSONMapping >> printOn: stream [
	super printOn: stream.
	stream nextPut: $(; print: self identifier; nextPut: $)
]

{ #category : #parsing }
NeoJSONMapping >> readFrom: jsonReader [
	self subclassResponsibility 
]

{ #category : #writing }
NeoJSONMapping >> writeObject: anObject on: jsonWriter [
	self subclassResponsibility 
]
