Extension { #name : #Collection }

{ #category : #'*neo-json-core' }
Collection >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeList: self
]
