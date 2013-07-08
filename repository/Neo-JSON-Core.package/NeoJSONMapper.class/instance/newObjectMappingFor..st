private
newObjectMappingFor: smalltalkClass
	| mapping |
	mapping := NeoJSONObjectMapping new.
	mapping subjectClass: smalltalkClass.
	self mappings at: smalltalkClass put: mapping.
	^ mapping