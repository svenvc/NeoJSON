running
runNativeJsonBenchmarkJsonCheckerPasses
	^ self
		validateFiles: self nativeJsonBenchmarkJsonCheckerPassFiles
		usingTest: [ :file | 
			| data success |
			success := true.
			[ data := file readStreamDo: [ :in | (NeoJSONReader on: in) next ] ]
				on: NeoJSONParseError
				do: [ :exception | self log: exception printString. success := false ].
			success ]