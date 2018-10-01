private
closeLog
	logStream ifNotNil: [ 
		logStream close.
		logStream := nil ].
	^ self logFile exists
		ifTrue: [ self logFile contents ] 
		ifFalse: [ 'log file is empty' ]