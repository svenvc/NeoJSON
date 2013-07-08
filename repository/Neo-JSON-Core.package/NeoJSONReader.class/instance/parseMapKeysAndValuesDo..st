parsing
parseMapKeysAndValuesDo: block
	self parseMapKeysDo: [ :key |
		block value: key value: self parseValue ]