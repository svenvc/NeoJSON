I am NeoJSONObject.
I am a Dictionary.

I behave more like a JavaScript object. I return nil for missing keys. I allow any property to be read or set by using a normal accessor message.

The following are equivalent:

	self foo.
	self at: #foo.

As are the following

	self foo: 1. 
	self at: #foo put: 1.
	
I can optionally be used by NeoJSONReader as mapClass (see #mapClass:).

For output, I act just like my superclass (it is thus not necessary to do any conversions).

Example:

	NeoJSONObject fromString: '{"foo":1,"bar":-2}'.
	
I use JSON as my printed representation.