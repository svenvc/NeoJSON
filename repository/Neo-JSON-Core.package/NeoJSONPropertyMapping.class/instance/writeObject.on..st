writing
writeObject: anObject on: jsonMapWriter
	| value |
	value := getter value: anObject.
	value 
		ifNotNil: [ jsonMapWriter writeKey: propertyName value: value ] 