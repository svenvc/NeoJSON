testing
testDate
	| reader |
	reader := [ :input | 
		(NeoJSONReader on: input readStream) 
			for: Date customDo: [ :mapping |
				mapping decoder: [ :string | Date fromString: string ] ];
			nextAs: Date ].
	self assert: (reader value: ' "2012-06-08" ') equals: (Date newDay: 8 month: 6 year: 2012)