testing
testDateAndTime 
	| reader |
	reader := [ :input | 
		(NeoJSONReader on: input readStream) 
			for: DateAndTime customDo: [ :mapping |
				mapping decoder: [ :string | DateAndTime fromString: string ] ];
			nextAs: DateAndTime ].
	self 
		assert: (reader value: ' "2012-02-14T16:40:18+01:00" ') 
		equals: (DateAndTime year: 2012 month: 2 day: 14 hour: 16 minute: 40 second: 18 offset: 1 hour)