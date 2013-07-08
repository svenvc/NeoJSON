comparing
= anObject
	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ id = anObject id
		and: [
			height = anObject height
				and: [
					width = anObject width
						and: [
							data = anObject data ] ] ]