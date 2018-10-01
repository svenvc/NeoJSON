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
		map ].
	self writer: [ :jsonWriter :map | 
		jsonWriter writeMapStreamingDo: [ :mapWriter |
			map keysAndValuesDo: [ :key :value | 
				mapWriter writeKey: key value: value as: valueSchema ] ] ]