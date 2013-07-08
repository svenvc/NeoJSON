testing
testSymbol
	| reader |
	reader := [ :input | 
		(NeoJSONReader on: input readStream) 
			for: Symbol customDo: [ :mapping |
				mapping decoder: [ :string | string asSymbol ] ];
			nextAs: Symbol ].
	self assert: (reader value: ' "foo" ') equals: #foo.
	self assert: (reader value: ' "FOO-1" ') equals: #'FOO-1'