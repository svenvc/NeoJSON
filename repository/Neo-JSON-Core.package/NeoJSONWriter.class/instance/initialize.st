initialize-release
initialize
	super initialize.
	"For portability reasons use `Character cr asString` rather than `String cr`"
	self newLine: Character cr asString.
	self prettyPrint: false.
	self asciiOnly: false.
	self writeNil: false.
	level := 0