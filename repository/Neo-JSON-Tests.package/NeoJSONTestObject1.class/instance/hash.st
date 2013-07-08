comparing
hash
	^ id hash bitXor: (name hash bitXor: (timestamp hash bitXor: (points hash bitXor: bytes hash)))