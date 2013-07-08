parsing
parseValue
	| char |
	readStream atEnd ifFalse: [ 
		char := readStream peek.
		char = ${
			ifTrue: [ ^ self parseMap ].
		char = $[
			ifTrue: [ ^ self parseList ].
		char = $"
			ifTrue: [ ^ self parseString ].
		(char = $- or: [ char isDigit ])
			ifTrue: [ ^ self parseNumber ].
		self parseConstantDo: [ :value | ^ value ] ].
	self error: 'invalid input: ', char asString