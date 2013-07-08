convenience
toString: object
	^ String streamContents: [ :stream |
			(self on: stream) nextPut: object ]