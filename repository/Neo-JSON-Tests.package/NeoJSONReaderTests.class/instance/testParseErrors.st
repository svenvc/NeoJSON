testing
testParseErrors
	self should: [ NeoJSONReader fromString: 'zero' ] raise: NeoJSONParseError.
	self should: [ NeoJSONReader fromString: '#' ] raise: NeoJSONParseError.
	self should: [ NeoJSONReader fromString: '@' ] raise: NeoJSONParseError.