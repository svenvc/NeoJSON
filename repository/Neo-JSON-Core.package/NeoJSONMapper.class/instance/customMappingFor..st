private
customMappingFor: schemaName
	^ self mappings
		at: schemaName
		ifAbsentPut: [ 
			NeoJSONCustomMapping new
				schemaName: schemaName;
				yourself ]