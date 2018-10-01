parsing
parseListDo: block
	self expectChar: $[.
	(self matchChar: $]) 
		ifTrue: [ ^ self ].
	[ readStream atEnd ] 
		whileFalse: [
			block value.
			(self matchChar: $]) 
				ifTrue: [ ^ self ].
			(self matchChar: $,)
				ifFalse: [ self error: ', or ] expected' ] ].
	self error: 'incomplete list'