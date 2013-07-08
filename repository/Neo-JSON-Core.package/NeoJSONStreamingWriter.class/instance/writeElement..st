writing
writeElement: value
	first 
		ifTrue: [ 
			jsonWriter newlineIndent. 
			first := false ]
		ifFalse: [ 
			jsonWriter listElementSeparator ].
	jsonWriter nextPut: value 