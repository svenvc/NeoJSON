I am NeoJSONTestObject1.

I repesent a domain model object.
I have the following properties:

- id <Integer>
- name <String>
- timestamp <DateAndTime>
- points <Array of: Point>
- bytes <ByteArray>

My JSON representation is like this:

- id <Number>
- name <String>
- created-at <ISO8601 String>
- points <Array of: <Map x,y>
- bytes <Array of: Number>
