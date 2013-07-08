writing
writeMapStreamingDo: block
	writeStream nextPut: ${.
	self writeStreamingDo: block.
	writeStream nextPut: $}