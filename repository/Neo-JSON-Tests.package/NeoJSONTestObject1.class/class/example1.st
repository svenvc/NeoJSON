instance creation
example1
	^ self new
		id: 123;
		name: 'Example1';
		timestamp: (DateAndTime year: 2012 month: 06 day: 08 hour: 14 minute: 30 second: 15 offset: 1 hour);
		points: { 1@2. 3@4 };
		bytes: #[ 2 4 6 8 ];
		yourself