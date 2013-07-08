parsing
readObject: anObject from: jsonReader
	| value |
	value := jsonReader nextAs: valueSchema.
	setter value: anObject value: value