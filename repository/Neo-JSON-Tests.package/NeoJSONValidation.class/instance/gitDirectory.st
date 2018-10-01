accessing
gitDirectory
	^ gitDirectory ifNil: [ gitDirectory := FileLocator home / #Develop / #git ]