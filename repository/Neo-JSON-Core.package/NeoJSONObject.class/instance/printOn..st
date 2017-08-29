printing
printOn: stream
	"I use my JSON representation when printing myself"
	
	(NeoJSONWriter on: stream) nextPut: self