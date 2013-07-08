testing
testSmallDictionary
	| json map |
	json := '{ "x" : true, "y" : false, "key-1" : 1 }'.
	map := (NeoJSONReader on: json readStream) 
		mapClass: SmallDictionary;
		next.
	self 
		assert: map 
		equals: (SmallDictionary new at: #x put: true; at: #y put: false; at: #'key-1' put: 1; yourself).
	self 
		assert: map class 
		equals: SmallDictionary