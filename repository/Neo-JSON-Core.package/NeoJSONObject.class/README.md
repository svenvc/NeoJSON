I am NeoJSONObject.
I am a Dictionary.

I behave more like a JavaScript object. I return nil for missing keys. I allow any property to be read or set by using a normal accessor message.

The following are equivalent:

	self foo.
	self at: #foo.

As are the following

	self foo: 1. 
	self at: #foo put: 1.
	
Except that in the first case, self is returned.

I can optionally be used by NeoJSONReader as mapClass (see #mapClass:).

For output, I act just like my superclass (it is thus not necessary to do any conversions).

Example:

	NeoJSONObject fromString: '{"foo":1,"bar":-2}'.
	NeoJSONObject new foo: 1; bar: -2.
	{ #x -> 100. #y -> 200 } as: NeoJSONObject.
	(NeoJSONObject new data: (NeoJSONObject new id: #sensor1; value: 37.5)) asString.

I use JSON as my printed representation. To convert me to JSON, use #printString or #asString.

Additionally, I support path access for nested instances of me, using #atPath: and #atPath:put:

The first is special because it returns nil as soon as a key is missing. The second is special because it creates extra levels (instances of me) as needed to follow the path of keys.

	NeoJSONObject new atPath: #(one two three) put: 42; yourself.
	NeoJSONObject new atPath: #(one two three) put: 42; atPath: #(one two three).
		