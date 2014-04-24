converting
asDictionary
	^ super asDictionary
		at: #color put: color;
		at: #transparent put: transparent;
		yourself