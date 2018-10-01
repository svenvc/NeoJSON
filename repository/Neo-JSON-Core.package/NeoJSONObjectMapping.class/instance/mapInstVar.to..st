mapping
mapInstVar: instVarName to: propertyName
	| index |
	index := 
		"For portability reasons, do not use instVarIndexFor:ifAbsent: 
		(it doesn't exist in all Smalltalk dialects) but the below approach.
		Also, convert to symbols for portability reasons"
		(subjectClass allInstVarNames collect: [ :each | each asSymbol ]) 
			indexOf: instVarName asSymbol 
			ifAbsent: [ self error: 'Inst var not found: ', instVarName printString ].
	^ self 
		mapProperty: propertyName asString
		getter: [ :object | object instVarAt: index ]
		setter: [ :object :value | object instVarAt: index put: value ] 
	
