convencience
mapInstVarsFor: smalltalkClass
	"Map the instance variables of smalltalkClass"

	| mapping |
	mapping := self newObjectMappingFor: smalltalkClass.
	mapping mapInstVars.
	^ mapping