public
read
	^ (NeoJSONReader on: json readStream) next
