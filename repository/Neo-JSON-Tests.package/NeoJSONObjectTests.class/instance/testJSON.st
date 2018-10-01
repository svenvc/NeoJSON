testing
testJSON
	| data  json object |
	data := NeoJSONObject newFrom: (Array with: #foo->1 with: #bar->2 with: #str->'Str!' with: #bool->true with: #flt->1.5).
	json := NeoJSONWriter toString: data .
	object := NeoJSONObject fromString: json.
	self assert: object class equals: NeoJSONObject.
	self assert: object equals: data.
	json := (NeoJSONWriter toString: object).
	self assert: (NeoJSONObject fromString: json) equals: object