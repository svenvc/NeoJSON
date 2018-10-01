mapping
mapProperty: propertyName getter: readBlock setter: writeBlock
	| propertyMapping |
	propertyMapping := NeoJSONPropertyMapping new.
	propertyMapping 
		propertyName: propertyName;
		getter: readBlock;
		setter: writeBlock.
	properties removeAllSuchThat: [ :each | each propertyName = propertyMapping propertyName ].
	properties addLast: propertyMapping.
	^ propertyMapping 