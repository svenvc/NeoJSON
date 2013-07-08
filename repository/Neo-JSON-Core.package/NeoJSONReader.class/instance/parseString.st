parsing
parseString
	| result |
	self expectChar: $".
	result := self stringStreamContents: [ :stream |
		[ readStream atEnd or: [ readStream peek = $"] ] 
			whileFalse: [ 
				stream nextPut: self parseCharacter ] ].
	self expectChar: $".
	^ result