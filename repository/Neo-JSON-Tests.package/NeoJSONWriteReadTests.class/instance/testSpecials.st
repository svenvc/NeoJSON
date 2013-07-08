testing
testSpecials
	| objects |
	objects := { true. false. nil }.
	self 
		assert: (self writeRead: objects)
		equals: objects