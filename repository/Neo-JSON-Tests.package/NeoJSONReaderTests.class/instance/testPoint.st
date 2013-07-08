testing
testPoint
	| reader |
	reader := [ :string | 
		(NeoJSONReader on: string readStream) nextAs: Point ].
	self should: [ reader value: '{"x":1,"y":2}' ] raise: NeoJSONMappingNotFound