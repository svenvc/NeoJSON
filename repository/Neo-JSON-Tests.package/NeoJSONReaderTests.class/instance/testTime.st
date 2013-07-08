testing
testTime
	| reader |
	reader := [ :input | 
		(NeoJSONReader on: input readStream) 
			for: Time customDo: [ :mapping |
				mapping decoder: [ :string | Time fromString: string ] ];
			nextAs: Time ].
	self assert: (reader value: ' "14:30:08" ') equals: (Time hour: 14 minute: 30 second: 8)