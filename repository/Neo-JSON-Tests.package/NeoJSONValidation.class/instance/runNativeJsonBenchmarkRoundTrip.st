running
runNativeJsonBenchmarkRoundTrip
	^ self 
		validateFiles: self nativeJsonBenchmarkRoundTripFiles
		usingTest: [ :file |
			| data json |
			data := file readStreamDo: [ :in | (NeoJSONReader on: in) next ].
			json := NeoJSONWriter toString: data.
			json = file contents ]