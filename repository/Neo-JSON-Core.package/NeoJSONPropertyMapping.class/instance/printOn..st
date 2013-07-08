printing
printOn: stream
	super printOn: stream.
	stream nextPut: $(; print: propertyName; nextPut: $)