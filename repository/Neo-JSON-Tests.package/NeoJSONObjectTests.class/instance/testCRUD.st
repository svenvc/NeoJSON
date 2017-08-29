testing
testCRUD
	| object |
	object := NeoJSONObject new.
	self assert: object isEmpty.
	self assert: object foo equals: nil.
	object foo: 123.
	self assert: object foo equals: 123.
	self assert: object printString equals: '{"foo":123}'.
	object name: 'test'.
	object value: Float pi.
	self assert: object name equals: 'test'.
	self assert: (object value closeTo: Float pi).
	self assert: object keys asSet equals: #(foo name value) asSet.
	object removeKey: #foo.
	self assert: object foo equals: nil.
	object removeAll.
	self assert: object isEmpty