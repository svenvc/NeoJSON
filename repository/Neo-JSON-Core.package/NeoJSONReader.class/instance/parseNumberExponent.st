parsing
parseNumberExponent
	| number negated |
	number := 0.
	(negated := readStream peekFor: $-)
		ifFalse: [ readStream peekFor: $+ ].
	(readStream atEnd or: [ readStream peek isDigit not ])
		ifTrue: [ self error: 'number exponent expected' ].
	[ readStream atEnd not and: [ readStream peek isDigit ] ]
		whileTrue: [ number := 10 * number + readStream next digitValue ].
	negated
		ifTrue: [ number := number negated ].
	number positive 
		ifTrue: [ number > Float emax ifTrue: [ self error: 'number exponent too large' ] ]
		ifFalse: [ number < Float emin ifTrue: [ self error: 'number exponent too small' ] ].
	^ 10 raisedTo: number