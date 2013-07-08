testing
testMaps
	| objects |
	objects := { 
		Dictionary new.
		Dictionary with: 'x' -> 1.
		Dictionary newFromPairs: #( 'foo' true 'bar' false 'zero' 0 'null' nil 'string' 'Hello World!' ) }.
	self 
		assert: (self writeRead: objects)
		equals: objects