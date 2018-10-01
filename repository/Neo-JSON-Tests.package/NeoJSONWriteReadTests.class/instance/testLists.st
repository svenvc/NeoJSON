testing
testLists
	| objects |
	objects := Array with: #(1 2 3) with: #() with: #( 'foo' 'bar').
	self 
		assert: (self writeRead: objects)
		equals: objects