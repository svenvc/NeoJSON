testing
testLists
	| objects |
	objects := { #(1 2 3). #(). #( 'foo' 'bar') }.
	self 
		assert: (self writeRead: objects)
		equals: objects