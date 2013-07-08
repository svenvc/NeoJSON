mapping
decoder: block
	"Set a decoder block that accepts the next object representation read 
	and converts it into the actual object to be returned."

	self reader: [ :jsonReader | | representation |
		representation := jsonReader next.
		block value: representation ]