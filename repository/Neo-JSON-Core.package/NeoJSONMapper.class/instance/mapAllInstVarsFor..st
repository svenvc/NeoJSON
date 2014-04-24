convencience
mapAllInstVarsFor: smalltalkClass
	"Map the instance variables of smalltalkClass and all its super classes"

	| mapping |
	mapping := self objectMappingFor: smalltalkClass.
	mapping mapAllInstVars.
	^ mapping