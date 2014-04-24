instance creation
example1
	^ super example1
		data: (String new: 8 withAll: $a);
		color: 'red';
		transparent: true;
		yourself