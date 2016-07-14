private
escapeChar: code
	code = 34
		ifTrue: [ ^ writeStream nextPutAll: '\"' ].
	code = 92
		ifTrue: [ ^ writeStream nextPutAll: '\\' ].
	code = 47
		ifTrue: [ ^ writeStream nextPutAll: '\/' ].
	code = 8
		ifTrue: [ ^ writeStream nextPutAll: '\b' ].
	code = 12
		ifTrue: [ ^ writeStream nextPutAll: '\f' ].		
	code = 10
		ifTrue: [ ^ writeStream nextPutAll: '\n' ].		
	code = 13
		ifTrue: [ ^ writeStream nextPutAll: '\r' ].		
	code = 9
		ifTrue: [ ^ writeStream nextPutAll: '\t' ].		
	self escapeUnicode: code