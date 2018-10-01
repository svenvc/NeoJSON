private
ensureLog
	logStream ifNil: [ 
		logStream := self logFile ensureDelete; writeStream. 
		logStream setToEnd ]
	