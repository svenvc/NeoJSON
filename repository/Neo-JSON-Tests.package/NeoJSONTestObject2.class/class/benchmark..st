testing
benchmark: count
	"self benchmark: 1000"
	
	| collection json size |
	collection := Array new: count withAll: self example1.
	size := 2 + (count * (NeoJSONWriter toString: self example1) size) + count - 1.
	Transcript 
		cr;
		<< ('Serializing {1} objects took ms ' format: { count });
		show: [ json := String new: size streamContents: [ :stream |
								(NeoJSONWriter on: stream) nextPut: collection ] ] timeToRun.
	Transcript 
		cr;
		<< ('Deserializing {1} objects took ms ' format: { count });
		show: [ NeoJSONReader fromString: json ] timeToRun.