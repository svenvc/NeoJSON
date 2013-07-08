initialize-release
on: aReadStream
	"Initialize on aReadStream, which should be a character stream that 
	implements #next, #peek, #atEnd and (optionally) #close."
	
	readStream := aReadStream