testing
testAsciiOnlyStrings
	| writer |
	writer := [ :object | 
		String streamContents: [ :stream |
			(NeoJSONWriter on: stream) 
				asciiOnly: true;
				nextPut: object ] ].
	self assert: (writer value: 'élève français') equals: '"\u00E9l\u00E8ve fran\u00E7ais"'.
	self assert: (writer value: 'foo') equals: '"foo"'.
	self assert: (writer value: 'Foo BAR') equals: '"Foo BAR"'.
	self assert: (writer value: '') equals: '""'.
	self
		assert: (writer value: (String withAll: ( OrderedCollection new 
			add: $";
			add: $\; 
			add: $/;
			add: Character tab;
			add: Character cr;
			add: Character lf;
			add: Character newPage; 
			add: Character backspace;
			yourself )))
		equals: '"\"\\/\t\r\n\f\b"'

