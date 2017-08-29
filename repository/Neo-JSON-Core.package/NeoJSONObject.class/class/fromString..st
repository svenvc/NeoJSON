convenience
fromString: string
	"Parse string as JSON, so that maps become instances of me"

	^ (NeoJSONReader on: string readStream)
			mapClass: NeoJSONObject;
			propertyNamesAsSymbols: true;
			next