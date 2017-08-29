accessing
nextListAs: schema
	"Secondary interface to parse JSON.
	Return a list of objects, each element according to schema."
	
	^ self listClass streamContents: [ :stream |
			self parseListDo: [ 
				stream nextPut: (self nextAs: schema) ] ]