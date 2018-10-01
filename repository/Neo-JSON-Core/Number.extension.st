Extension { #name : #Number }

{ #category : #'*neo-json-core' }
Number >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeFloat: self asFloat
]
