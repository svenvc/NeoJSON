mapping
for: smalltalkClass do: block
	"Create and add a new standard object mapping for smalltalkClass.
	The code in block should further customize the mapping."
	
	| mapping |
	mapping := self newObjectMappingFor: smalltalkClass.
	block value: mapping.
	^ mapping