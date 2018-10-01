Extension { #name : #Boolean }

{ #category : #'*neo-json-core' }
Boolean >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeBoolean: self
]
