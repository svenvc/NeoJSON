testing
testDate
	| writer |
	writer := [ :object | 
		String streamContents: [ :stream |
			(NeoJSONWriter on: stream) 
				for: Date customDo: [ :mapping |
					mapping encoder: [ :date | date yyyymmdd ] ];
				nextPut: object ] ].
	self assert: (writer value: (Date newDay: 8 month: 6 year: 2012)) equals: '"2012-06-08"'