accessing
propertyNamed: propertyName ifAbsent: block
	| symbolPropertyName |
	symbolPropertyName := propertyName asSymbol.
	^ properties detect: [ :each | each propertyName = symbolPropertyName ] ifNone: block