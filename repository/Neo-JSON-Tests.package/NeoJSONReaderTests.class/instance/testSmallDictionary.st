testing
testSmallDictionary
	| json map smallDictionaryClass |
	json := '{ "x" : true, "y" : false, "key-1" : 1 }'.
	smallDictionaryClass := Smalltalk at: #SmallDictionary ifAbsent: [ Dictionary ].
	map := (NeoJSONReader on: json readStream) 
		mapClass: smallDictionaryClass;
		next.
	self 
		assert: map 
		equals: (smallDictionaryClass new at: #x put: true; at: #y put: false; at: #'key-1' put: 1; yourself).
	self 
		assert: map class 
		equals: smallDictionaryClass