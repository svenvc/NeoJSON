testing
testNonBMPCharacterDecoding
	"Characters not in the Basic Multilingual Plane are encoded as a UTF-16 surrogate pair"

	| string object |
	string := 16r1D11E asCharacter asString. "MUSICAL SYMBOL G CLEF"
	object := (NeoJSONReader fromString: '"\uD834\uDD1E"').
	self assert: object equals: string