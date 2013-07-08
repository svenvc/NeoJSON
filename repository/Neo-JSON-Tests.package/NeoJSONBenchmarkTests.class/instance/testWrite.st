testing
testWrite
	| benchmark |
	benchmark := NeoJSONBenchmark new.
	"Make sure that we can render at least 10k 5-element maps per second"
	self 
		should: [ benchmark write ]
		notTakeMoreThanMilliseconds: 100