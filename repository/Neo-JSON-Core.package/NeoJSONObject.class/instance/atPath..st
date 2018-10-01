accessing
atPath: keyCollection
	"Use each key in keyCollection recursively, stop when nil is encountered"
	
	| value |
	value := self.
	keyCollection do: [ :each |
		value := value at: each.
		value ifNil: [ ^ nil ] ].
	^ value 