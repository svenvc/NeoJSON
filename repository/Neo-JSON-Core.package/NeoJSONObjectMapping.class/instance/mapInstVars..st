mapping
mapInstVars: instVarNames
	^ instVarNames collect: [ :each | self mapInstVar: each ]