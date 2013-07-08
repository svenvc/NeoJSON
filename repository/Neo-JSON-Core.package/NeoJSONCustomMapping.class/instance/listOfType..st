mapping
listOfType: collectionClass
	"Set the reader to a block that will create an instance of collectionClass 
	using #streamContents: while reading a list of elements"

	self reader: [ :jsonReader |
		collectionClass streamContents: [ :stream |
			jsonReader parseListDo: [ | element |
				element := jsonReader next.
				stream nextPut: element ] ] ]
	"we do not set a writer, #neoJsonOn: should be sufficient"
