mapping
for: schemaName customDo: block
	"Create and add a new custom mapping for schemaName.
	The code in block should further customize the mapping."
	
	| mapping |
	mapping := self newCustomMappingFor: schemaName.
	block value: mapping.
	^ mapping