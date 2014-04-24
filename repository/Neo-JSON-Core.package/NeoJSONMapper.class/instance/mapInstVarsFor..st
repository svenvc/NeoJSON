convencience
mapInstVarsFor: smalltalkClass
	"Map the instance variables of smalltalkClass"

	| mapping |
	mapping := self objectMappingFor: smalltalkClass.
	mapping mapInstVars.
	^ mapping