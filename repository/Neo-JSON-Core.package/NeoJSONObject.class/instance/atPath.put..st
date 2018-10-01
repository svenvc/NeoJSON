accessing
atPath: keyCollection put: newValue
	"Use each key in keyCollection recursively, create new levels when needed"
	
	| target |
	keyCollection ifEmpty: [ ^ self ].
	target := self.
	keyCollection allButLastDo: [ :each |
		(target at: each)
			ifNil: [ target := target at: each put: target species new ]
			ifNotNil: [ :subValue | target := subValue ] ].
	^ target at: keyCollection last put: newValue