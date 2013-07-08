writing
writeMap: keyValueCollection
	self writeMapStreamingDo: [ :jsonMapWriter |
		keyValueCollection keysAndValuesDo: [ :key :value |
			jsonMapWriter writeKey: key value: value ] ]