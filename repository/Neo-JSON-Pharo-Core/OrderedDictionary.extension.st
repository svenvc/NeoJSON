Extension { #name : #OrderedDictionary }

{ #category : #'*neo-json-pharo-core' }
OrderedDictionary >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeMap: self
]
