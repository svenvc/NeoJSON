writing
writeObject: anObject on: jsonMapWriter
	| value |
	value := getter value: anObject.
	(value notNil or: [ jsonMapWriter writeNil ])
		ifTrue: [ jsonMapWriter writeKey: propertyName value: value as: valueSchema ] 