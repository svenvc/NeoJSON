I am NeoJSONReader.
I am a NeoJSONMapper.
I parse a JSON representation from a textual stream into Smalltalk objects.

Primitive types are automatically mapped to their Smalltalk counterpart: Numbers, Strings, Booleans and UndefinedObject.
When parsing using #next, lists normally become Arrays and maps become Dictionaries.
An alternative listClass or mapClass can be specified.

When parsing using #nextAs: a schema can be specified. This schema defines a mapping to be used.

Here are some examples:

	NeoJSONReader fromString: ' [ 1,2,3 ] '.
	NeoJSONReader fromString: ' [ 3.14159, true, false, null, "string" ] '.
	NeoJSONReader fromString: ' { "x" : 1, "y" : 2 } '.
	
	(NeoJSONReader on: ' { "x" : 1, "y" : 2 } ' readStream)
		mapInstVarsFor: Point;
		nextAs: Point.	
			
	(NeoJSONReader on: '[ { "x" : 1, "y" : 2 }, { "x" : 3, "y" : 4 } ]' readStream)
		mapInstVarsFor: Point;
		for: #ArrayOfPoints customDo: [ :mapping |
			mapping listOfElementSchema: Point ];
		nextAs: #ArrayOfPoints.