testing
testNonBMPCharacterEncoding
	"Characters not in the Basic Multilingual Plane are encoded as a UTF-16 surrogate pair"

	| string json |
	string := 16r1D11E asCharacter asString. "MUSICAL SYMBOL G CLEF"
	json := String streamContents: [ :out |
		(NeoJSONWriter on: out) asciiOnly: true; nextPut: string ].
	self assert: json equals: '"\uD834\uDD1E"'