running
runJsonTestSuiteTestParsingFailures
	^ self
		validateFiles: self jsonTestSuiteTestParsingFailFiles 
		usingTest: [ :file | 
			| data success |
			success := false.
			[ data := file readStreamDo: [ :in | (NeoJSONReader on: in) next; failIfNotAtEnd ] ]
				on: NeoJSONParseError
				do: [ :exception | self log: exception printString. success := true ].
			success ]