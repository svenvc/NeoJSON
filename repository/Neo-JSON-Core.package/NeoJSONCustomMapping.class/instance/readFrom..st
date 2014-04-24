parsing
readFrom: jsonReader
	^ reader 
		ifNil: [ jsonReader next ]
		ifNotNil: [ reader value: jsonReader ]