mapping
mapProperty: propertyName getter: readBlock setter: writeBlock
	| propertyMapping |
	propertyMapping := NeoJSONPropertyMapping new.
	propertyMapping 
		propertyName: propertyName;
		getter: readBlock;
		setter: writeBlock.
	properties at: propertyName put: propertyMapping.
	^ propertyMapping 