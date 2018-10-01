parsing
failIfNotAtEnd
	self atEnd
		ifFalse: [ self error: 'extraneous input detected' ]