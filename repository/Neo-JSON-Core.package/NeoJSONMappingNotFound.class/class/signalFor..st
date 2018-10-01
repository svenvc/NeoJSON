instance creation
signalFor: anObject
	"Create and signal an exception for anObject in the default receiver."
	
	^ self new
		object: anObject;
		signal