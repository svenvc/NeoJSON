Extension { #name : #Dictionary }

{ #category : #'*neo-json-core' }
Dictionary >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeMap: self
]
