testing
testPoint1
	| writer |
	writer := [ :object | 
		String streamContents: [ :stream |
			(NeoJSONWriter on: stream) 
				for: Point do: [ :mapping |
					mapping mapProperty: 'x' getter: [ :point | point x ] setter: [ :point :value | point x: value ].
					mapping mapProperty: 'y' getter: [ :point | point y ] setter: [ :point :value | point y: value ]. ];
				nextPut: object ] ].
	self assert: (writer value: 1@2) equals: '{"x":1,"y":2}'.
	self assert: (writer value: Point new) equals: '{}'