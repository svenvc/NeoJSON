Extension { #name : #String }

{ #category : #'*neo-json-core' }
String >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeString: self
]
