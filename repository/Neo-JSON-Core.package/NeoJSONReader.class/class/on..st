instance creation
on: readStream
	"Initialize on readStream, which should be a character stream that 
	implements #next, #peek, #atEnd and (optionally) #close."

	^ self new
		on: readStream;
		yourself