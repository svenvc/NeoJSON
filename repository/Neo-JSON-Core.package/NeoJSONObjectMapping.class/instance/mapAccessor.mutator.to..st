mapping
mapAccessor: accessor mutator: mutator to: propertyName
	^ self 
		mapProperty: propertyName
		getter: [ :object | object perform: accessor ]
		setter: [ :object :value | object perform: mutator with: value ] 