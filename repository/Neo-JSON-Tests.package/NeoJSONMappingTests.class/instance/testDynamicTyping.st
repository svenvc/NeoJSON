testing
testDynamicTyping
	| data customMapping json result |
	data := Array with: 'foo'->1 with: #('foo' 2).
	"The idea is to map a key value combination as either a classic association or a simple pair, 
	using key & value properties as well as a type property to distinguish between the two"
	customMapping := [ :mapper |
		mapper 
			for: #AssocOrPair customDo: [ :mapping |
				mapping
					encoder: [ :x | 
						x isArray 
							ifTrue: [ Dictionary new at: 'type' put: 'pair'; at: 'key' put: x first; at: 'value' put: x second; yourself ] 
							ifFalse: [ Dictionary new at: 'type' put: 'assoc'; at: 'key' put: x key; at: 'value' put: x value; yourself ] ];
					decoder: [ :x |
						(x at: 'type') = 'pair'
							ifTrue: [ Array with: (x at: 'key') with: (x at: 'value') ]
							ifFalse: [ (x at: 'key') -> (x at: 'value')] ] ];
			for: #ArrayOfAssocOrPair customDo: [ :mapping |
				mapping listOfType: Array andElementSchema: #AssocOrPair ];
			yourself ].
	json := String streamContents: [ :out |
		(customMapping value: (NeoJSONWriter on: out)) nextPut: data as: #ArrayOfAssocOrPair ].
	result := (customMapping value: (NeoJSONReader on: json readStream)) nextAs: #ArrayOfAssocOrPair.
	self assert: result equals: data