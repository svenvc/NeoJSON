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
	self error: 'invalid escape character \' , (String with: char)