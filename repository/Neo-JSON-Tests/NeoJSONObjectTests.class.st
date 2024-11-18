"
I am NeoJSONObjectTests, I hold unit tests for NeoJSONObject.

"
Class {
	#name : #NeoJSONObjectTests,
	#superclass : #TestCase,
	#category : #'Neo-JSON-Tests'
}

{ #category : #accessing }
NeoJSONObjectTests >> exampleJSONSchema [
	^ NeoJSONObject fromString: '{
  "$id" : "https://example.com/schemas/address",
  "type" : "object",
  "properties" : {
    "street_address" : { "$anchor" : "street_address", "type" : "string" },
    "city" : { "type" : "string" },
    "state" : { "type" : "string" }
  }, 
  "required" : ["street_address", "city", "state"],
  "$defs" : {
    "country" : { "type" : "object", "$anchor" : "country", "enum" : ["us","canada","gb"] }
  }
}'
]

{ #category : #testing }
NeoJSONObjectTests >> testArray [
	| jsonArray array |
	jsonArray := '[1,2,3]'.
	array := NeoJSONObject fromString: jsonArray.
	self assert: array asString equals: jsonArray.
	self assertCollection: array hasSameElements: #(1 2 3).
	array at: 1 add: 0.
	array at: #- add: 4.
	self assertCollection: array hasSameElements: #(0 1 2 3 4).
	array removeKey: 5.
	array removeKey: 1.
	self assertCollection: array hasSameElements: #(1 2 3)
]

{ #category : #testing }
NeoJSONObjectTests >> testAtAt [
	| object |
	object := NeoJSONObject new.
	self assert: (object at: #foo) isNil.
	self assert: (object at: #foo at: #bar) isNil.
	object at: #foo at: #bar put: 123.
	self assert: (object at: #foo) notNil.
	self assert: (object at: #foo at: #bar) equals: 123.
	self assert: object foo bar equals: 123.
	object at: #foo at: #bar put: -1.
	self assert: (object at: #foo at: #bar) equals: -1.
	self assert: (object at: #foo at: #foo) isNil
]

{ #category : #testing }
NeoJSONObjectTests >> testAtPath [
	| object |
	object := NeoJSONObject newFrom:  (Array with:  #one -> ( NeoJSONObject newFrom:  (Array with:  #two -> ( NeoJSONObject newFrom: (Array with:  #three -> 42) ) ) )).
	self assert: (object atPath: #(one two three)) equals: 42.
	self assert: (object atPath: #(one two three)) equals: object one two three.	
	self assert: (object atPath: #(missing)) equals: nil.
	self assert: (object atPath: #(one missing)) equals: nil.
	self assert: (object atPath: #(one two missing)) equals: nil.
	self assert: (object atPath: #(one two missing)) equals: object one two missing.
	
	object := NeoJSONObject newFrom:  (Array with: #foo -> 42).
	self assert: (object atPath: #(foo)) equals: 42.
	self assert: (object atPath: #(foo)) equals: object foo.
	self assert: (object atPath: #(foo)) equals: (object at: #foo).
	self assert: (object atPath: #()) equals: object.
	

]

{ #category : #testing }
NeoJSONObjectTests >> testAtPathPut [
	| object |
	object := NeoJSONObject new.
	object atPath: #(one test) put: 42.
	self assert: (object atPath: #(one test)) equals: 42.
	self assert: object one test equals: 42.
	object atPath: #(one two three) put: #foo.
	self assert: (object atPath: #(one two three)) equals: #foo.
	self assert: object one two three equals: #foo.
	object atPath: #(one two threeBis) put: #bar.
	self assert: (object atPath: #(one two threeBis)) equals: #bar.
	self assert: object one two threeBis equals: #bar.
	
	self assert: object foo isNil.
	self assert: (object atPath: #() put: 1) equals: object.
	self assert: (object atPath: #(foo) put: 1) equals: 1.
	self assert: (object atPath: #(foo)) equals: 1.
	self assert: object foo equals: 1
	 

]

{ #category : #testing }
NeoJSONObjectTests >> testCRUD [
	| object |
	object := NeoJSONObject new.
	self assert: object isEmpty.
	self assert: object foo equals: nil.
	object foo: 123.
	self assert: object foo equals: 123.
	self assert: object printString equals: '{"foo":123}'.
	object name: 'test'.
	object value: Float pi.
	self assert: object name equals: 'test'.
	self assert: (object value closeTo: Float pi).
	self assert: object keys asSet equals: #(foo name value) asSet.
	object removeKey: #foo.
	self assert: object foo equals: nil.
	object removeAll.
	self assert: object isEmpty
]

{ #category : #testing }
NeoJSONObjectTests >> testFindPath [
	| json path |
	json := self exampleJSONSchema.
	
	path := json findPath: [ :object | object isDictionary and: [ (object at: '$anchor') = 'street_address' ] ].
	self deny: path isNil.
	self assert: path equals: #(properties street_address).
	self assert: ((json atPath: path) at: '$anchor') equals: 'street_address'.
		
	path := json findPath: [ :object | object isDictionary and: [ (object at: 'foo') = 'bar' ] ].
	self assert: path isNil.
	
	path := json findPath: [ :object | object isDictionary and: [ (object at: '$anchor') = 'country' ] ].
	self deny: path isNil.
	self assert: path equals: #('$defs' country).
	self assert: ((json atPath: path) at: '$anchor') equals: 'country'.
	
	json := NeoJSONObject new at: '$anchor' put: 'top'; yourself.
	self 
		assert: (json findPath: [ :object | object isDictionary and: [ (object at: '$anchor') = 'top' ] ])
		equals: #(())
]

{ #category : #testing }
NeoJSONObjectTests >> testFindPaths [
	| json paths |
	json := self exampleJSONSchema.
	
	paths := json findPaths: [ :object | object isDictionary and: [ object includesKey: '$anchor' ] ].
	self deny: paths isEmpty.
	self assert: paths asArray equals: #((properties street_address) ('$defs' country)).
	self assert: ((json atPath: paths first) at: '$anchor') equals: 'street_address'.
	self assert: ((json atPath: paths second) at: '$anchor') equals: 'country'.
			
	paths := json findPaths: [ :object | object isDictionary and: [ (object at: 'foo') = 'bar' ] ].
	self assert: paths isEmpty.
	
	paths := json findPaths: [ :object | object isDictionary and: [ object includesKey: #type ] ].
	self deny: paths isEmpty.
	paths do: [ :path |
		self assert: (#(string object) includes: ((json atPath: path) at: #type)) ].
		
	paths := json findPaths: [ :_ | true ].
	paths do: [ :each | 
		self assert: (json atPath: each) notNil ]
]

{ #category : #testing }
NeoJSONObjectTests >> testJSON [
	| data  json object |
	data := NeoJSONObject newFrom: (Array with: #foo->1 with: #bar->2 with: #str->'Str!' with: #bool->true with: #flt->1.5).
	json := NeoJSONWriter toString: data .
	object := NeoJSONObject fromString: json.
	self assert: object class equals: NeoJSONObject.
	self assert: object equals: data.
	json := (NeoJSONWriter toString: object).
	self assert: (NeoJSONObject fromString: json) equals: object
]

{ #category : #testing }
NeoJSONObjectTests >> testPathAccess [
	| data |
	data := NeoJSONObject fromString: '{"foo":1,"bar":2,"array":[{"a":1},{"b":2}]}'.
	self assert: (data atPath: #(array 1 a)) equals: 1.
	self assert: (data atPath: #(array 2 b)) equals: 2.
	self assert: (data atPath: #(missing 1)) equals: nil.
	data atPath: #(missing) put: 7.
	self assert: (data atPath: #(missing)) equals: 7.
	self assert: (data atPath: #(array 3)) equals: nil.
	data := NeoJSONObject fromString: '[{"c":1},{"c":2},{"c":3}]'.
	self assert: (data atPath: #(2 c)) equals: 2.
	self assert: (data atPath: #(10 c)) equals: nil.
	self assert: (data atPath: #(3 missing)) equals: nil.
	data atPath: #(3 missing) put: #found.
	self assert: (data atPath: #(3 missing)) equals: #found.
	(data at: 3) removeKey: #missing.
	self assert: (data atPath: #(3 missing)) equals: nil.
	data atPath: #(3 missing x) put: #found.
	self assert: (data atPath: #(3 missing x)) equals: #found.
]
