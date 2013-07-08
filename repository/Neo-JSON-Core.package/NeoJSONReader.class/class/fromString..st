convenience
fromString: string
	^ (self on: string readStream) next