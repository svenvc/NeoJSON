testing
testParseErrors
	self should: [ NeoJSONReader fromString: 'zero' ] raise: NeoJSONParseError.
	self should: [ NeoJSONReader fromString: '#' ] raise: NeoJSONParseError.
	self should: [ NeoJSONReader fromString: '@' ] raise: NeoJSONParseError.
	
	self should: [ (NeoJSONReader on: '[1,2,3]true' readStream) next; failIfNotAtEnd ] raise: NeoJSONParseError.
	self should: [ (NeoJSONReader on: '{"foo":1}"extra"' readStream) next; failIfNotAtEnd ] raise: NeoJSONParseError.
	self should: [ (NeoJSONReader on: '[]"extra"' readStream) next; failIfNotAtEnd ] raise: NeoJSONParseError.