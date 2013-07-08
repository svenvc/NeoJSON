private
stringStreamContents: block
	"Like String streamContents: block
	but reusing the underlying buffer for improved efficiency"
	
	stringStream 
		ifNil: [ 
			stringStream := (String new: 32) writeStream ].
	stringStream reset.
	block value: stringStream.
	^ stringStream contents