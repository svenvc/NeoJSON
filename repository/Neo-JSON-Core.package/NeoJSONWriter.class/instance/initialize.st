initialize-release
initialize
	super initialize.
	self newLine: String cr.
	self prettyPrint: false.
	self asciiOnly: false.
	self writeNil: false.
	level := 0