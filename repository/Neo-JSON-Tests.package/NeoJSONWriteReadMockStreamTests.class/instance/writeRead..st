private
writeRead: object
	| json |
	json := String streamContents: [ :stream |
		(NeoJSONWriter on: (NeoJSONMockStream on: stream))
			prettyPrint: true;
			nextPut: object ].
	^ (NeoJSONReader on: (NeoJSONMockStream on: json readStream)) next 