testing
testPreservePropertyOrder
	| writer testObject |
	(testObject := NeoJSONTestObject2 new)
		id: 123;
		width: 100;
		height: 50;
		data: 'test'.
	writer := [ :object | 
		String streamContents: [ :stream |
			(NeoJSONWriter on: stream) 
				for: NeoJSONTestObject2 do: [ :mapping | mapping mapInstVars: #(id width height data) ];
				nextPut: object ] ].
	self assert: (writer value: testObject) equals: '{"id":123,"width":100,"height":50,"data":"test"}'.
	writer := [ :object | 
		String streamContents: [ :stream |
			(NeoJSONWriter on: stream) 
				for: NeoJSONTestObject2 do: [ :mapping | mapping mapInstVars: #(width height data id) ];
				nextPut: object ] ].
	self assert: (writer value: testObject) equals: '{"width":100,"height":50,"data":"test","id":123}'.
	writer := [ :object | 
		String streamContents: [ :stream |
			(NeoJSONWriter on: stream) 
				for: NeoJSONTestObject2 do: [ :mapping | mapping mapInstVars: #(data id height width) ];
				nextPut: object ] ].
	self assert: (writer value: testObject) equals: '{"data":"test","id":123,"height":50,"width":100}'.
