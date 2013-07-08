mapping
listOfType: collectionClass andElementSchema: elementSchema
	"Set the reader to a block that will create an instance of collectionClass 
	using #streamContents: while reading a list of elements of type elementSchema"

	self reader: [ :jsonReader |
		collectionClass streamContents: [ :stream |
			jsonReader parseListDo: [ | element |
				element := jsonReader nextAs: elementSchema.
				stream nextPut: element ] ] ]
	"we do not set a writer, #neoJsonOn: should be sufficient"
