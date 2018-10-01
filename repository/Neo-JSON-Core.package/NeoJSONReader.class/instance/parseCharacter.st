parsing
parseCharacter
	| char |
	(char := readStream next) = $\ 
		ifFalse: [ ^ char ].
	('/"\' includes: (char := readStream next))
		ifTrue: [ ^ char ].
	('bfnrt' includes: char)
		ifTrue: [ ^ self unescapeChar: char ].
	char = $u
		ifTrue: [ ^ self parseCharacterHex ].
	char 
		ifNil: [ self error: 'invalid escape, end of file' ]
		ifNotNil: [ self error: 'invalid escape character \' , char asString ]