private
newlineIndent
	prettyPrint
		ifTrue: [ 
			self newline.
			level timesRepeat: [ writeStream nextPut: Character tab ] ]