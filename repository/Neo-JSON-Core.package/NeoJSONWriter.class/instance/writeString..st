writing
writeString: string
	writeStream nextPut: $".
	string do: [ :each |
		self encodeChar: each ].
	writeStream nextPut: $"