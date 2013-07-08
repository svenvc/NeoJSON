writing
writeObject: anObject
	| mapping |
	mapping := self mappingFor: anObject class.
	mapping
		writeObject: anObject
		on: self