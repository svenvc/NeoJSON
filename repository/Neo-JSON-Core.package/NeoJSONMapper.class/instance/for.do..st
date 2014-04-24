mapping
for: smalltalkClass do: block
	"Execute the code in block to further customize the mapping for schemaName.
	Create and add a new standard object mapping for schemaName if necessary."
	
	| mapping |
	mapping := self objectMappingFor: smalltalkClass.
	block value: mapping.
	^ mapping