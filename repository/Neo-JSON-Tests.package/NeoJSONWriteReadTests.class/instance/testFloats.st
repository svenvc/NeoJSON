testing
testFloats
	| objects |
	objects := { Float pi . 1.0 . -1.0 . 0.0 . 1.5e6 . -1.5e6 . 1.5e-6 . -1.5e-6 }.
	(self writeRead: objects) 
		with: objects 
		do: [ :first :second | self assert: (first closeTo: second) ]