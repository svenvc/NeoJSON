instance creation
example1
	^ self new
		id: 13;
		width: 250;
		height: 110;
		data: (String new: 512 withAll: $a);
		yourself