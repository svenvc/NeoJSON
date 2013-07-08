mapping
mapInstVars: instVarNames
	instVarNames do: [ :each |
		self mapInstVar: each ]