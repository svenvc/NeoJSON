testing
testFloats
	| objects |
	objects := OrderedCollection new add: Float pi; add: 1.0; add: -1.0; add: 0.0; add: 1.5e6; add: -1.5e6; add: 1.5e-6; add: -1.5e-6; yourself.
	(self writeRead: objects) 
		with: objects 
		do: [ :first :second | self assert: (first closeTo: second) ]