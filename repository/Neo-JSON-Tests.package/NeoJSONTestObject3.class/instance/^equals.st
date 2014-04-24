comparing
= anObject
	^ super = anObject 
		and: [ color = anObject color
			and: [ transparent = anObject transparent ] ]