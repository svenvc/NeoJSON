parsing
parseMap
	| map |
	map := self mapClass new.
	self parseMapKeysAndValuesDo: [ :key :value |
		map at: key put: value ].
	^ map