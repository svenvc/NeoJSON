private
encodeChar: char
	| code |
	code := char codePoint.
	(code < 32 or: [ code = 34 or: [ code = 92 ] ])
		ifTrue: [ self escapeChar: code ]
		ifFalse: [ writeStream nextPut: char ]