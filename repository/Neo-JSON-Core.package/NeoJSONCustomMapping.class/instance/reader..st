accessing
reader: block
	"Set the reader to block, a 1 argument block that when given 
	a jsonReader as argument reads the object that I represent.
	When there is no reader block, the default #next will be used."
	
	reader := block