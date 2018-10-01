testing
testTime
	| writer |
	writer := [ :object | 
		String streamContents: [ :stream |
			(NeoJSONWriter on: stream) 
				for: Time customDo: [ :mapping |
					mapping encoder: [ :time | time printString ] ];
				nextPut: object ] ].
	self assert: ((writer value: (Time fromSeconds: 52208)) includesSubstring: '2:30:08')