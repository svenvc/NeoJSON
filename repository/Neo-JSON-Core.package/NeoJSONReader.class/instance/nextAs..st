accessing
nextAs: schema
	"Secondary interface to parse JSON.
	Return objects according to schema."
	
	| mapping |
	schema ifNil: [ ^ self next ].
	self consumeWhitespace.
	mapping := self mappingFor: schema.
	^ mapping readFrom: self