private
encodeChar: char
	| code |
	code := char codePoint.
	(self doesCodePointNeedEscaping: code)
		ifTrue: [ self escapeChar: code ]
		ifFalse: [ writeStream nextPut: char ]