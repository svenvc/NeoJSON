testing
testStrings
	| reader |
	reader := [ :string |
		(NeoJSONReader on: string readStream) next ].
	self assert: (reader value: '"foo"') equals: 'foo'.
	self assert: (reader value: '""') equals: ''.
	self assert: (reader value: '"Foo BAR"') equals: 'Foo BAR'.
	self assert: (reader value: '"\u00E9l\u00E8ve en Fran\u00E7ais"') equals: 'élève en Français'.
	self 
		assert: (reader value: '"\"\\\/\t\r\n\f\b"') 
		equals: (String withAll: { 
					$". $\. $/. Character tab. Character cr. Character lf.  Character newPage. Character backspace }).
	self should: [ reader value: '"open' ] raise: NeoJSONParseError.
	self should: [ reader value: '"\uAA"' ] raise: NeoJSONParseError.
	self should: [ reader value: '"\uZZ"' ] raise: NeoJSONParseError.
	self should: [ reader value: '"\x"' ] raise: NeoJSONParseError.
	self should: [ reader value: ' " ' ] raise: NeoJSONParseError.
