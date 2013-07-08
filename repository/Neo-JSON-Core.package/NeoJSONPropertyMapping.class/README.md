I am NeoJSONPropertyMapping.
I describe how a property of a Smalltalk class maps to a JSON property.

A property is either an instance variable or getter/setter pair.
I hold a getter and setter block to do the actual work. The property name is used in JSON.

Optionally, the schema for the value of my property can be specified. This is then used recursively.