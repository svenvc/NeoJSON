writing
writeObject: anObject on: jsonWriter
	jsonWriter writeMapStreamingDo: [ :jsonMapWriter |
		properties valuesDo: [ :each |
			each writeObject: anObject on: jsonMapWriter ] ]