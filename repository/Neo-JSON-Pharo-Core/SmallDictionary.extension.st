Extension { #name : #SmallDictionary }

{ #category : #'*neo-json-pharo-core' }
SmallDictionary >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeMap: self
]
