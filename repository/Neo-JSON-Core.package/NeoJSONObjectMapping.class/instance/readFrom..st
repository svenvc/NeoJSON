parsing
readFrom: jsonReader
	| anObject |
	anObject := subjectClass new.
	allowNil ifTrue: [ 
		jsonReader parseConstantDo: [ :value | 
			^ value ifNotNil: [ jsonReader error: 'Unexpected boolean constant' ] ] ].
	jsonReader parseMapKeysDo: [ :key |
		(self propertyNamed: key ifAbsent: [ nil ])
			ifNil: [
				"read, skip & ignore value"
				jsonReader next ]
			ifNotNil: [ :mapping |
				mapping readObject: anObject from: jsonReader ] ].
	^ anObject