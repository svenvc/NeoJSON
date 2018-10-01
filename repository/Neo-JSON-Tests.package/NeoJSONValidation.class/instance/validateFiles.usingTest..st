private
validateFiles: files usingTest: block
	| total succeeded failed |
	total := succeeded := failed := 0.
	files do: [ :file | 
		| success |
		self log: 'Running ' , file pathString.
		self log: ([ file contents contractTo: 64 ] on: Error do: [ :exception | exception printString ]).
		success := [ block value: file ]
			on: Error
			do: [ :exception | self log: '  Errored. ' , exception printString. false ].
		total := total + 1.
		success
			ifTrue: [ succeeded := succeeded + 1 ]
			ifFalse: [ failed := failed + 1 ].
		self log: (success ifTrue: [ '  Succeeded' ] ifFalse: [ '  Failed' ]); log: '' ].
	self log: ('{1} total = {2} succeeded + {3} failed' format: (Array with: total with: succeeded with: failed) ).
	^ self closeLog