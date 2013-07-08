accessing
listClass
	"Return the collection type to use for JSON lists"
	
	^ listClass ifNil: [ Array ]