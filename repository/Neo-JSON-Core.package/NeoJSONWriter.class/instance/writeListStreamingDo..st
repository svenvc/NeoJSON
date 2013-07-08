writing
writeListStreamingDo: block
	writeStream nextPut: $[.
	self writeStreamingDo: block.
	writeStream nextPut: $]