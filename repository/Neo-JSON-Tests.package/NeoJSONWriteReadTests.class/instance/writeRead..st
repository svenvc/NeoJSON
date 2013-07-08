private
writeRead: object
	| json |
	json := String streamContents: [ :stream |
		(NeoJSONWriter on: stream) nextPut: object ].
	^ (NeoJSONReader on: json readStream) next 