parsing
parseMapKeysDo: block
	self parseMapDo: [ | key |
		key := self parsePropertyName.
		self expectChar: $:.
		block value: key ]