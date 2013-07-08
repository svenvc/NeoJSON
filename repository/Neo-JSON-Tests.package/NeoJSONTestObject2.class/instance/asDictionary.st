converting
asDictionary
	^ Dictionary new
		at: #id put: id;
		at: #height put: height;
		at: #width put: width;
		at: #data put: data;
		yourself