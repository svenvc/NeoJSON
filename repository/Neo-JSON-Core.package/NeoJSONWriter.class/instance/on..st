initialize-release
on: aWriteStream
	"Initialize on aWriteStream, which should be a character stream that 
	implements #nextPut:, #nextPutAll:, #space and (optionally) #close."

	writeStream := aWriteStream
