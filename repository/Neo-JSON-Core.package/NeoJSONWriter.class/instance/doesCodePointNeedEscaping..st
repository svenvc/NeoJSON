private
doesCodePointNeedEscaping: code
	code < 32 ifTrue: [ ^ true ].
	( code = 34 or: [ code = 92 ]) ifTrue: [ ^ true ].
	^ asciiOnly and: [ code > 126 ]	