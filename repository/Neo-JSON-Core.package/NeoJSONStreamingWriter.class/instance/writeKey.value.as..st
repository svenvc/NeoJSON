writing
writeKey: key value: value as: valueSchema
	first 
		ifTrue: [ 
			jsonWriter newlineIndent. 
			first := false ]
		ifFalse: [ 
			jsonWriter mapElementSeparator ].
	jsonWriter encodeKey: key value: value as: valueSchema