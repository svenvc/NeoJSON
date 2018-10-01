Extension { #name : #Object }

{ #category : #'*neo-json-core' }
Object >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeObject: self
]
