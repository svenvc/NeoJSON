accessing
at: key
	"I return nil for missing keys.
	My superclass would signal a KeyNotFound."
	
	^ self at: key ifAbsent: [ nil ]