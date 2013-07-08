convenience
toStringPretty: object
	^ String streamContents: [ :stream |
			(self on: stream)
				prettyPrint: true; 
				nextPut: object ]