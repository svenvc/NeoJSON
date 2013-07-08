accessing
mappingFor: schema
	^ self 
		mappingFor: schema 
		ifAbsent: [ NeoJSONMappingNotFound signalFor: schema in: self ]