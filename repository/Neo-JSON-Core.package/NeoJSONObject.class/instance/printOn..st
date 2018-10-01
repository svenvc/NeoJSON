printing
printOn: stream
	"I use my JSON representation when printing myself"

	[ (NeoJSONWriter on: stream) nextPut: self ]
		on: Error
		do: [ :exception | 
			stream
				nextPutAll: ' Error printing JSON: ';
				nextPutAll: exception printString ]