running
runJsonTestSuiteTestParsingPasses
	^ self
		validateFiles: self jsonTestSuiteTestParsingPassFiles 
		usingTest: [ :file | 
			| data success |
			success := true.
			[ data := file readStreamDo: [ :in | (NeoJSONReader on: in) next ] ]
				on: NeoJSONParseError
				do: [ :exception | self log: exception printString. success := false ].
			success ]