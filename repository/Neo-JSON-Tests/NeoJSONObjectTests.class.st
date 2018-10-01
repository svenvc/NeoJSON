"
I am NeoJSONObjectTests, I hold unit tests for NeoJSONObject.

"
Class {
	#name : #NeoJSONObjectTests,
	#superclass : #TestCase,
	#category : 'Neo-JSON-Tests'
}

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
