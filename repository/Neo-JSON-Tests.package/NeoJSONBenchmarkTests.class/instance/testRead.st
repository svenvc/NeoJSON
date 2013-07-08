testing
testRead
	| benchmark |
	benchmark := NeoJSONBenchmark new.
	"Make sure that we can parse at least 10k 5-element maps per second"
	self 
		should: [ benchmark read ]
		notTakeMoreThanMilliseconds: 100