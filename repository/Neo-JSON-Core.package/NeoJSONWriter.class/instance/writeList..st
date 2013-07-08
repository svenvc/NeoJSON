writing
writeList: collection
	self writeListStreamingDo: [ :jsonListWriter |
		collection do: [ :each |
			jsonListWriter writeElement: each ] ]