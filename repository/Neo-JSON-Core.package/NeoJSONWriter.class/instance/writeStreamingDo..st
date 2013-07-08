writing
writeStreamingDo: block
	| mapWriter |
	mapWriter := NeoJSONStreamingWriter on: self.
	self indentedDo: [
		block value: mapWriter ].
	mapWriter wasUsed
		ifTrue: [ self newlineIndent ]
		ifFalse: [ self prettyPrintSpace ]