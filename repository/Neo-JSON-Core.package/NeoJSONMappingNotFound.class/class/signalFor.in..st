instance creation
signalFor: anObject in: aCollection
	"Create and signal an exception for anObject in aCollection."

	^ self new
		object: anObject;
		collection: aCollection;
		signal