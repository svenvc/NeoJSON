private
newCustomMappingFor: schemaName
	| mapping |
	mapping := NeoJSONCustomMapping new.
	mapping schemaName: schemaName.
	self mappings at: schemaName put: mapping.
	^ mapping