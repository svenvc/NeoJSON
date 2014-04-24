initialize-release
initialize
	super initialize.
	self newLine: String cr.
	self prettyPrint: false.
	self asciiOnly: false.
	level := 0