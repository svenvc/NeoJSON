testing
testStrings
	| objects |
	objects := OrderedCollection new
		add: 'foo'; add: 'Foo BAR'; add: ''; add: '	\\'''; 
		add: 'élève en Français';
		add: (Character codePoint: 12354) asString; "HIRAGANA LETTER A" 
		yourself;
		asArray.
	self 
		assert: (self writeRead: objects)
		equals: objects