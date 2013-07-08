accessing
mapClass
	"Return the collection type to use for JSON maps"
	
	^ mapClass ifNil: [ Dictionary ]