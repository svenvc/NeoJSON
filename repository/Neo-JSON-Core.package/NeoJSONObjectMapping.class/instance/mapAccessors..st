mapping
mapAccessors: accessors
	^ accessors collect: [ :each | self mapAccessor: each ]