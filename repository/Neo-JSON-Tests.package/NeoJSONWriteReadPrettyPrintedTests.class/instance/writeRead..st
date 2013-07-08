private
writeRead: object
	| json |
	json := String streamContents: [ :stream |
		(NeoJSONWriter on: stream) 
			prettyPrint: true;
			nextPut: object ].
	^ (NeoJSONReader on: json readStream) next 