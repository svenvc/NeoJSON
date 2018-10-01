writing
writeElement: value as: valueSchema
	first 
		ifTrue: [ 
			jsonWriter newlineIndent. 
			first := false ]
		ifFalse: [ 
			jsonWriter listElementSeparator ].
	jsonWriter nextPut: value as: valueSchema