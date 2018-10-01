running
runNativeJsonBenchmarkJsonCheckerFailures
	^ self
		validateFiles: self nativeJsonBenchmarkJsonCheckerFailFiles
		usingTest: [ :file | 
			| data success |
			success := false.
			[ data := file readStreamDo: [ :in | (NeoJSONReader on: in) next; failIfNotAtEnd ] ]
				on: NeoJSONParseError
				do: [ :exception | self log: exception printString. success := true ].
			success ]