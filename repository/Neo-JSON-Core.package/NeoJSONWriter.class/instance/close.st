initialize-release
close
	"Close the stream that I write to"
	
	writeStream ifNotNil: [
		writeStream close.
		writeStream := nil ]