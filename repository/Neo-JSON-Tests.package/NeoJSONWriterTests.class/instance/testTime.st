testing
testTime
	| writer |
	writer := [ :object | 
		String streamContents: [ :stream |
			(NeoJSONWriter on: stream) 
				for: Time customDo: [ :mapping |
					mapping encoder: [ :time | time print24 ] ];
				nextPut: object ] ].
	self assert: (writer value: (Time hour: 14 minute: 30 second: 8)) equals: '"14:30:08"'