mapping
mapWithValueSchema: valueSchema
	"Set the reader to a block that will create an instance of the
	standard mapClass while reading values of type valueSchema,
	with standard keys"

	self reader: [ :jsonReader | | map |
		map := jsonReader mapClass new.
		jsonReader parseMapKeysDo: [ :key | | value |
				value := jsonReader nextAs: valueSchema.
				map at: key put: value ].
		map ]
	"we do not set a writer, #neoJsonOn: should be sufficient"
