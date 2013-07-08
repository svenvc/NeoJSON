instance creation
on: writeStream
	"Initialize on writeStream, which should be a character stream that 
	implements #nextPut:, #nextPutAll:, #space and (optionally) #close."

	^ self new
		on: writeStream;
		yourself