I am NeoJSONMapper.
I hold a mapping from schema identifiers to objects that known how to read or write instances from or to JSON.

Schema identifiers are either Smalltalk classes or Symbols.

I offer a builder interface to construct mappings. 

The standard object mapping represents a Smalltalk object as a map, mapping some or all instance variables, or a set of accessors (getter/setter methods). Furthermore, for each value an optional schema can be specified.

Using a custom mapping, a reader and/or writer block can deal with special cases such as specific collection types with an optional schema for the elements, or a direct mapping of semi primitive types such as Date or DateAndTime.

A mapping can be specified explicitely on a mapper, or can be resolved using the #neoJsonMapping: class method.

Here are some examples:

	mapper mapAllInstVarsFor: Point.
	mapper for: TestObject do: [ :mapping |
		mapping mapInstVars: #(id name).
		(mapping mapInstVar: #timestamp to: 'created-at') valueSchema: DateAndTime.
		(mapping mapInstVar: #points) valueSchema: #ArrayOfPoints.
		(mapping mapInstVar: #bytes) valueSchema: ByteArray ].
	mapper for: DateAndTime customDo: [ :mapping |
		mapping decoder: [ :string | DateAndTime fromString: string ].
		mapping encoder: [ :dateAndTime | dateAndTime printString ] ].
	mapper for: #ArrayOfPoints customDo: [ :mapping |
		mapping listOfElementSchema: Point ].  
	mapper for: ByteArray customDo: [ :mapping |
		mapping listOfType: ByteArray ]
