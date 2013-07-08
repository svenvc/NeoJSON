parsing
parsePropertyName
	| name |
	name := self parseValue.
	^ name isString
		ifTrue: [ 
			propertyNamesAsSymbols 
				ifTrue: [ name asSymbol ]
				ifFalse: [ name ] ]
		ifFalse: [ 
			self error: 'property name must be a string, not ', name asString ]