private
unescapeChar: char
	"Handle one of the named character escapes, b, f, n, r or t. Else fail."
	
	char = $b
		ifTrue: [ ^ Character backspace ].
	char = $f
		ifTrue: [ ^ Character newPage ].
	char = $n
		ifTrue: [ ^ Character lf ].
	char = $r
		ifTrue: [ ^ Character cr ].
	char = $t
		ifTrue: [ ^ Character tab ].
	self error: 'Unknown escape char: ', (String with: char)