convenience
fromString: string as: schema
	^ (self on: string readStream) nextAs: schema