testing
testIntegers
	| objects |
	objects := { 1. -1. 0. 123467890. -1234567890 }.
	self 
		assert: (self writeRead: objects)
		equals: objects