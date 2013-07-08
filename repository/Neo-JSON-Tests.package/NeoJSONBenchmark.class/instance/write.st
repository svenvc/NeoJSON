public
write
	^ String streamContents: [ :stream |
		(NeoJSONWriter on: stream) nextPut: objects ]
