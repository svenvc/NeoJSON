testing
testPrettyPrinted
	| benchmark |
	benchmark := NeoJSONBenchmark new.
	self
		assert: benchmark writePrettyPrintedRead
		equals: benchmark read