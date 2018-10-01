private
log: message
	self ensureLog.
	logStream nextPutAll: message; lf; flush
