testing
testOrderedCollection
	| json list |
	json := '[ 1, 2, 3 ]'.
	list := (NeoJSONReader on: json readStream) 
		listClass: OrderedCollection;
		next.
	self 
		assert: list 
		equals: (OrderedCollection with: 1 with: 2 with: 3).
	self 
		assert: list class 
		equals: OrderedCollection