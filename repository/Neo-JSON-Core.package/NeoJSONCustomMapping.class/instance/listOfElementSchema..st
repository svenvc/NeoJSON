mapping
listOfElementSchema: elementSchema
	"Set the reader to a block that will create an instance of the
	standard listClass while reading a list of elements of type elementSchema"

	self reader: [ :jsonReader |
		jsonReader listClass streamContents: [ :stream |
			jsonReader parseListDo: [ | element |
				element := jsonReader nextAs: elementSchema.
				stream nextPut: element ] ] ]
	"we do not set a writer, #neoJsonOn: should be sufficient"
