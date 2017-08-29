testing
testJSON
	| data  json object |
	data := { #foo->1. #bar->2. #str->'Str!'. #bool->true. #flt->1.5 } as: NeoJSONObject.
	json := NeoJSONWriter toString: data .
	object := NeoJSONObject fromString: json.
	self assert: object class equals: NeoJSONObject.
	self assert: object equals: data.
	json := (NeoJSONWriter toString: object).
	self assert: (NeoJSONObject fromString: json) equals: object