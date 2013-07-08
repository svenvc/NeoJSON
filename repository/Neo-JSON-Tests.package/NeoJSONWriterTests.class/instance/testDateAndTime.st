testing
testDateAndTime 
	| writer |
	writer := [ :object | 
		String streamContents: [ :stream |
			(NeoJSONWriter on: stream) 
				for: DateAndTime customDo: [ :mapping |
					mapping encoder: [ :dateAndTime | dateAndTime printString ] ];
				nextPut: object ] ].
	self 
		assert: (writer value: (DateAndTime year: 2012 month: 2 day: 14 hour: 16 minute: 40 second: 18 offset: 1 hour)) 
		equals: '"2012-02-14T16:40:18+01:00"'