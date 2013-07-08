accessing
mappingFor: schema ifAbsent: block
	(self mappings includesKey: schema)
		ifFalse: [ self resolveMappingFor: schema ].
	^ self mappings
		at: schema
		ifAbsent: block