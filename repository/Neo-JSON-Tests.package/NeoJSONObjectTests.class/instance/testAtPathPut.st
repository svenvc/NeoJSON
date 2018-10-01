testing
testAtPathPut
	| object |
	object := NeoJSONObject new.
	object atPath: #(one test) put: 42.
	self assert: (object atPath: #(one test)) equals: 42.
	self assert: object one test equals: 42.
	object atPath: #(one two three) put: #foo.
	self assert: (object atPath: #(one two three)) equals: #foo.
	self assert: object one two three equals: #foo.
	object atPath: #(one two threeBis) put: #bar.
	self assert: (object atPath: #(one two threeBis)) equals: #bar.
	self assert: object one two threeBis equals: #bar.
	
	self assert: object foo isNil.
	self assert: (object atPath: #() put: 1) equals: object.
	self assert: (object atPath: #(foo) put: 1) equals: 1.
	self assert: (object atPath: #(foo)) equals: 1.
	self assert: object foo equals: 1
	 
