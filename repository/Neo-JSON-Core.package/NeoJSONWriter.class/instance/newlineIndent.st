private
newlineIndent
	prettyPrint
		ifTrue: [ 
			writeStream nextPutAll: newLine.
			level timesRepeat: [ writeStream nextPut: Character tab ] ]