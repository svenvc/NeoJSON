accessing
propertyNamed: propertyName ifAbsent: block
	^ properties detect: [ :each | each propertyName = propertyName ] ifNone: block