private
encodeKey: key value: value as: valueSchema
	self nextPut: key.
	self prettyPrintSpace.
	writeStream nextPut: $:.
	self prettyPrintSpace.
	self nextPut: value as: valueSchema