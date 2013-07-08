mapping
mapAccessor: accessor to: propertyName
	^ self 
		mapProperty: propertyName
		getter: [ :object | object perform: accessor ]
		setter: [ :object :value | object perform: accessor asMutator with: value ] 