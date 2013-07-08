mapping
mapInstVar: instVarName to: propertyName
	| index |
	index := subjectClass 
		instVarIndexFor: instVarName 
		ifAbsent: [ self error: 'Inst var not found: ', instVarName printString ].
	^ self 
		mapProperty: propertyName
		getter: [ :object | object instVarAt: index ]
		setter: [ :object :value | object instVarAt: index put: value ] 