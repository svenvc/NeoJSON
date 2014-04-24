accessing
nextPut: anObject as: schema
	"Secondary interface to write JSON.
	Write objects according to schema."
	
	| mapping |
	schema ifNil: [ ^ self nextPut: anObject ].
	mapping := self mappingFor: schema.
	^ mapping writeObject: anObject on: self