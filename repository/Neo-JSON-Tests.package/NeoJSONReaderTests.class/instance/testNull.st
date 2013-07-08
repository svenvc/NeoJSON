testing
testNull
	self assert: (NeoJSONReader on: 'null' readStream) next equals: nil.
	self assert: (NeoJSONReader on: '	null ' readStream) next equals: nil.
	self should: [ (NeoJSONReader on: '	nil ' readStream) next ] raise: NeoJSONParseError.