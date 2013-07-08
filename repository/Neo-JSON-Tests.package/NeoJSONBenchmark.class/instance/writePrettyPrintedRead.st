public
writePrettyPrintedRead
	| output |
	output := String streamContents: [ :stream |
		(NeoJSONWriter on: stream) 
			prettyPrint: true;
			nextPut: objects ].
	^ (NeoJSONReader on: output readStream) 
		next