I am NeoJSONWriter.
I am a NeoJSONMapper.
I write a JSON representation of Smalltalk objects to a textual stream.

Objects implementing #neoJsonOn: can be encoded.
A number of primitive types, like Strings, Numbers, Booleans and UndefinedObject are treated specially.
Collection are encoded as lists, except for Dictionaries that are encoded as maps.

All other objects need a mapping to help in doing the encoding.

Here are some examples:

	NeoJSONWriter toString: #(1 2 3).
	NeoJSONWriter toString: { Float pi. true. false. 'string' }.
	NeoJSONWriter toStringPretty: (Dictionary new at: #x put: 1; at: #y put: 2; yourself).
	
	String streamContents: [ :stream |
		(NeoJSONWriter on: stream)
			prettyPrint: true;
			mapInstVarsFor: Point;
			nextPut: (Array with: 1@3 with: -1@3) ].
	