reflective operations
doesNotUnderstand: message
	"Overwritten so that 'self foo' becomes 'self at: #foo'
	and 'self foo: 1' becomes 'self at: #foo put: 1'"
	
	| key |
	key := message selector.
	key isUnary
		ifTrue: [ ^ self at: key ].
	^ (key isKeyword and: [ key numArgs = 1 ])
		ifTrue: [ self at: key allButLast asSymbol put: message arguments first ]
		ifFalse: [ super doesNotUnderstand: message ]