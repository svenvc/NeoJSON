parsing
parseNumberInteger
	| number |
	number := nil.
	[ readStream atEnd not and: [ readStream peek isDigit ] ] 
		whileTrue: [ 
			number := 10 * (number ifNil: [ 0 ]) + readStream next digitValue ].
	number ifNil: [ self error: 'Integer digit expected' ].
	^ number