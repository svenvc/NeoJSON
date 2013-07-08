testing
testByteArray
	| reader |
	reader := [ :string | 
		(NeoJSONReader on: string readStream) 
			for: ByteArray customDo: [ :mapping |
				mapping listOfType: ByteArray ];
			nextAs: ByteArray ].
	self assert: (reader value: '[ 1, 2, 3 ]') equals: #[1 2 3].
	self assert: (reader value: '[ ]') equals: ByteArray new