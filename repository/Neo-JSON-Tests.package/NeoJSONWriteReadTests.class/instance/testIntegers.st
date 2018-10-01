testing
testIntegers
	| objects |
	objects := Array with: 1 with: -1 with: 0 with: 123467890 with: -1234567890.
	self 
		assert: (self writeRead: objects)
		equals: objects