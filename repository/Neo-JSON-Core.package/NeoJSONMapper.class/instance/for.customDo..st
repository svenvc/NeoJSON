mapping
for: schemaName customDo: block
	"Execute the code in block to further customize the mapping for schemaName.
	Create and add a new custom mapping for schemaName if necessary."
	
	| mapping |
	mapping := self customMappingFor: schemaName.
	block value: mapping.
	^ mapping