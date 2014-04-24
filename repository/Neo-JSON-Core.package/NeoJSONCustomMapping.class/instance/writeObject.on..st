writing
writeObject: anObject on: jsonWriter
	writer 
		ifNil: [ anObject neoJsonOn: jsonWriter ]
		ifNotNil: [ writer value: jsonWriter value: anObject ]