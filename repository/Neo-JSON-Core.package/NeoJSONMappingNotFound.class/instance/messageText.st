accessing
messageText
	"Overwritten with standard text. To ease portability to other Smalltalk dialects we do not access the instVar 'messageText' as not all dialects have it. Not caching the value on the instVar shouldn't bring any performance hit in this case. "
	
	^ self standardMessageText 