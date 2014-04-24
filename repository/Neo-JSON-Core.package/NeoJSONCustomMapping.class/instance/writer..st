accessing
writer: block
	"Set the writer to block, a 2 argument block that when given: a jsonWriter 
	and the object to write will write the object that I represent.
	When there is no writer block, the default #neoJsonOn: will be used."
	
	writer := block