testing
testPrettyPrinted
	| benchmark |
	benchmark := NeoJSONBenchmark new.
	self
		assert: benchmark writePrettyPrintedRead
		equals: benchmark read.
	"Make sure that we can pretty print and parse at least 5k 5-element maps per second"
	self 
		should: [ benchmark writePrettyPrintedRead ]
		notTakeMoreThanMilliseconds: 200