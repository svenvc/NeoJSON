testing
testListsExtra
	| writer |
	writer := [ :object | 
		String streamContents: [ :stream |
			(NeoJSONWriter on: stream) nextPut: object ] ].
	#( OrderedCollection LinkedList ByteArray IntegerArray SortedCollection ) do: [ :each |
		Smalltalk at: each ifPresent: [ :collectionClass |
			self assert: (writer value: (collectionClass withAll: #(1 2 3))) equals: '[1,2,3]'.
			self assert: (writer value: collectionClass new) equals: '[]' ] ]
