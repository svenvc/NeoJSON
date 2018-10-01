testing
testVirtualTransferObject
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