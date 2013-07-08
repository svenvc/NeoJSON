accessing
next
	"Primary interface to parse a JSON value.
	Return either primitives, a listClass or a mapClass instance."
	
	^ self 
		consumeWhitespace; 
		parseValue