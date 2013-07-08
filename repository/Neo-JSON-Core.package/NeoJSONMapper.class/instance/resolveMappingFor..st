private
resolveMappingFor: class
	(class respondsTo: #neoJsonMapping:)
		ifTrue: [ 
			class perform: #neoJsonMapping: with: self ]