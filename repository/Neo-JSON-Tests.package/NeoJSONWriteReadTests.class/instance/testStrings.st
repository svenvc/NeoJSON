testing
testStrings
	| objects |
	objects := { 'foo'. 'Foo BAR'. ''. '	\\'''. 'élève en Français' }.
	self 
		assert: (self writeRead: objects)
		equals: objects