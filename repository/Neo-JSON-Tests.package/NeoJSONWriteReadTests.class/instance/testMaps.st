testing
testMaps
	| objects |
	objects := Array 
		with: Dictionary new
		with: (Dictionary with: 'x' -> 1)
		with: (Dictionary newFromPairs: #( 'foo' true 'bar' false 'zero' 0 'null' nil 'string' 'Hello World!' )).
	self 
		assert: (self writeRead: objects)
		equals: objects