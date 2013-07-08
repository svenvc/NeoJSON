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
			self expectChar: $, ].
	self error: 'end of list expected'