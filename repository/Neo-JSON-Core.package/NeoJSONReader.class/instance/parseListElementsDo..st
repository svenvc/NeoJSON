parsing
parseListElementsDo: block
	self parseListDo: [ 
		block value: self parseValue ]