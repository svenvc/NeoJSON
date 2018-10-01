testing
testSpecials
	| objects |
	objects := Array with: true with: false with: nil.
	self 
		assert: (self writeRead: objects)
		equals: objects