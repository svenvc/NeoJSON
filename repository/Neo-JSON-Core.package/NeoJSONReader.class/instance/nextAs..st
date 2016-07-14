accessing
nextAs: schema
	"Secondary interface to parse JSON.
	Return an object according to schema.
	If schema is nil, act like #next"
	
	| mapping |
	schema ifNil: [ ^ self next ].
	self consumeWhitespace.
	mapping := self mappingFor: schema.
	^ mapping readFrom: self