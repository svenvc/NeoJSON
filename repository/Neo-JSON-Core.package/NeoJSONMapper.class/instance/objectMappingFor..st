private
objectMappingFor: smalltalkClass
	^ self mappings
		at: smalltalkClass
		ifAbsentPut: [ 
			NeoJSONObjectMapping new
				subjectClass: smalltalkClass;
				yourself ]