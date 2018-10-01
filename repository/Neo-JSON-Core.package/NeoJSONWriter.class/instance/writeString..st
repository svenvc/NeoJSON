writing
writeString: string
	writeStream nextPut: $".
	1 to: string size do: [ :index |
		self encodeChar: (string at: index) ].
	writeStream nextPut: $"