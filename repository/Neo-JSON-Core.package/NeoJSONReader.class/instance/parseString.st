parsing
parseString
	| result |
	(readStream peekFor: $")
		ifFalse: [ self error: '" expected' ].
	result := self stringStreamContents: [ :stream | 
		[ readStream atEnd or: [ readStream peek = $" ] ] 
			whileFalse: [ stream nextPut: self parseCharacter ] ].
	self expectChar: $".
	^ result