writing
writeObject: anObject on: jsonWriter
	jsonWriter writeMapStreamingDo: [ :jsonMapWriter |
		properties do: [ :each |
			each writeObject: anObject on: jsonMapWriter ] ]