testing
testAtPath
	| object |
	object := NeoJSONObject newFrom:  (Array with:  #one -> ( NeoJSONObject newFrom:  (Array with:  #two -> ( NeoJSONObject newFrom: (Array with:  #three -> 42) ) ) )).
	self assert: (object atPath: #(one two three)) equals: 42.
	self assert: (object atPath: #(one two three)) equals: object one two three.	
	self assert: (object atPath: #(missing)) equals: nil.
	self assert: (object atPath: #(one missing)) equals: nil.
	self assert: (object atPath: #(one two missing)) equals: nil.
	self assert: (object atPath: #(one two missing)) equals: object one two missing.
	
	object := NeoJSONObject newFrom:  (Array with: #foo -> 42).
	self assert: (object atPath: #(foo)) equals: 42.
	self assert: (object atPath: #(foo)) equals: object foo.
	self assert: (object atPath: #(foo)) equals: (object at: #foo).
	self assert: (object atPath: #()) equals: object.
	
