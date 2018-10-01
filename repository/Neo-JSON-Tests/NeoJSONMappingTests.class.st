"
I am NeoJSONMappingTests, testing more exotic kinds of mapping constructs.
"
Class {
	#name : #NeoJSONMappingTests,
	#superclass : #TestCase,
	#category : 'Neo-JSON-Tests'
}

{ #category : #testing }
NeoJSONMappingTests >> testDynamicTyping [
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
]

{ #category : #testing }
NeoJSONMappingTests >> testSymbolOrStringInstVarMapping [
	| data out1 out2 result1 result2 |
	data := Array with: 1@2 with: 3@4.
	out1 := String streamContents: [ :out |
		(NeoJSONWriter on: out)
			for: Point do: [ :mapping | mapping mapInstVars: #(x y) ];
			nextPut: data ].
	result1 := (NeoJSONReader on: out1 readStream)
		for: Point do: [ :mapping | mapping mapInstVars: #(x y) ];
		nextListAs: Point.
	self assert: result1 equals: data.
	out2 := String streamContents: [ :out |
		(NeoJSONWriter on: out)
			for: Point do: [ :mapping | mapping mapInstVars: #('x' 'y') ];
			nextPut: data ].
	result2 := (NeoJSONReader on: out1 readStream)
		for: Point do: [ :mapping | mapping mapInstVars: #('x' 'y') ];
		nextListAs: Point.
	self assert: result2 equals: data
]

{ #category : #testing }
NeoJSONMappingTests >> testVirtualTransferObject [
	| data customMapping extraJson json result |
	data := NeoJSONObject new data: (Array with: 1@1 with: 2@2).
	extraJson := '{"foo":1,"data":[{"x":1,"y":1},{"x":2,"y":2,"z":-1}]}'.
	"The idea here is that we are not interested in the top level object just in its data property, 
	which should be of a specific type, hence we create a virtual transfer object"
	customMapping := [ :mapper |
		mapper
			for: Point do: [ :mapping |
				mapping mapInstVars: #(x y) ];
			for: #ArrayOfPoints customDo: [ :mapping |
				mapping listOfElementSchema: Point ];
			for: #TransferObject do: [ :mapping |
				mapping subjectClass: NeoJSONObject.
				(mapping mapAccessor: #data) valueSchema: #ArrayOfPoints ];
			yourself ].
	"By using NeoJSONObject accessors (#data & #data:) are translated to generic #at:[put:] messages.
	A longer alternative is 
	(mapping mapProperty: #data getter: [ :obj | obj at: #data ] setter: [ :obj :x | obj at: #data put: x]) valueSchema: #ArrayOfPoints
	where the blocks give you the flexibility to use a plain Dictionary for example"
	result := (customMapping value: (NeoJSONReader on: extraJson readStream)) nextAs: #TransferObject.
	self assert: result equals: data.
	json := String streamContents: [ :out |
		(customMapping value: (NeoJSONWriter on: out)) nextPut: data as: #TransferObject ].
	result := (customMapping value: (NeoJSONReader on: json readStream)) nextAs: #TransferObject.
	self assert: result equals: data
]
