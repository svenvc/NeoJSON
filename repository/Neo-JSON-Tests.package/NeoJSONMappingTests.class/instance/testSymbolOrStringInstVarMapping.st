testing
testSymbolOrStringInstVarMapping
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