I am NeoJSONObjectMapping.
I describe how instances of a Smalltalk class are mapped to a JSON map.

I do this using set of NeoJSONPropertyMappings.

I know the Smalltalk class that I am a mapping for. This class is the schema identifier and is used to instanciate new objects.

A mapping can be based on any combination of instance variables or accessors (getter/setter pairs). 

I offer a builder interface to constuct property mappings.