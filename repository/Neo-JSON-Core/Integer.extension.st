Extension { #name : #Integer }

{ #category : #'*neo-json-core' }
Integer >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeInteger: self
]
