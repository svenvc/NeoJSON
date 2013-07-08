testing
testBooleans
	self assert: (NeoJSONReader on: 'true' readStream) next equals: true.
	self assert: (NeoJSONReader on: 'false' readStream) next equals: false.
	self should: [ (NeoJSONReader on: 'tru' readStream) next ] raise: NeoJSONParseError.
	self should: [ (NeoJSONReader on: 'falsE' readStream) next ] raise: NeoJSONParseError.