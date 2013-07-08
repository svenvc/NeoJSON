parsing
parseList
	^ self listClass 
		streamContents: [ :stream |
			self parseListElementsDo: [ :each |
				stream nextPut: each ] ]

		