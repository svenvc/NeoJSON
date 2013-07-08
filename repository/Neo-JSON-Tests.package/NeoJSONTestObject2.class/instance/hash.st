comparing
hash
	^ id hash bitXor: (width hash bitXor: (height hash bitXor: data hash))