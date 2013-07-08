mapping
encoder: block
	"Set a encoder block that accepts the next object to be written 
	and converts it into the actual representation to be written."

	self writer: [ :jsonWriter :anObject | | representation |
		representation := block value: anObject.
		jsonWriter nextPut: representation ]