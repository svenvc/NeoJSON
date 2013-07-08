printing
standardMessageText
	^ String streamContents: [ :stream |
		stream << 'No mapping found for '.
		stream print: self object.
		stream << ' in '.
		stream print: self collection class ]