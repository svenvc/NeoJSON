comparing
= anObject
	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ id = anObject id
		and: [
			name = anObject name
				and: [
					timestamp = anObject timestamp
						and: [
							points = anObject points
								and: [ bytes = anObject bytes ] ] ] ]