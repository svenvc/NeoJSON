testing
testFloats
	| reader |
	reader := [ :string |
		(NeoJSONReader on: string readStream) next ].
	self assert: ((reader value: '123.0') closeTo: 123.0).
	self assert: ((reader value: '-123.0') closeTo: -123.0).
	self assert: ((reader value: '123.0e0') closeTo: 123.0).
	self assert: ((reader value: '123e6') closeTo: 123e6).
	self assert: ((reader value: '123e+6') closeTo: 123e6).
	self assert: ((reader value: '123e-6') closeTo: 123e-6).
	self assert: ((reader value: '123E6') closeTo: 123e6).
	self assert: ((reader value: '123E+6') closeTo: 123e6).
	self assert: ((reader value: '123E-6') closeTo: 123e-6).
	self assert: ((reader value: '-123e6') closeTo: -123e6).
	self assert: ((reader value: '-123e-6') closeTo: -123e-6).
	self assert: ((reader value: '-123E6') closeTo: -123e6).
	self assert: ((reader value: '-123E-6') closeTo: -123e-6).
	self assert: ((reader value: '3.14159') closeTo: Float pi).
	self assert: ((reader value: '0.123e6') closeTo: 0.123e6).
	self assert: ((reader value: '0.123e-6') closeTo: 0.123e-6).
	self assert: ((reader value: '-0.123E6') closeTo: -0.123e6).
	self assert: ((reader value: '-0.123E-6') closeTo: -0.123e-6).
