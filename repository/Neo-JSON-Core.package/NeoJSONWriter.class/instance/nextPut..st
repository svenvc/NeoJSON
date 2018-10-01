accessing
nextPut: anObject
	"Primary interface. Write a JSON representation of anObject to my stream."
	
	anObject neoJsonOn: self