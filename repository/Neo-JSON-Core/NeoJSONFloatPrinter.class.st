"
I am NeoJSONFloatPrinter.

I can print Float numbers is a compact, human friendly format.

The following are hardcoded (for now):

 - base 10
 - precision 5 digits
 - decimal point
 - exponent e
 - NaN, Inf and -Inf
 - lower 1e-4
 - upper 1e6
 - decimal notation for abs values inside abs [ lower, upper ]
 - scientific notation for abs values outside [ lower, upper ]
 - no padding, no trailing zeros in fraction part
 - only negative sign, never a positive sign
 - no thousands separators
 - no engineering notation

"
Class {
	#name : #NeoJSONFloatPrinter,
	#superclass : #Object,
	#category : #'Neo-JSON-Core'
}

{ #category : #constants }
NeoJSONFloatPrinter >> base [
	^ 10
]

{ #category : #constants }
NeoJSONFloatPrinter >> decimalPoint [
	^ $.
]

{ #category : #constants }
NeoJSONFloatPrinter >> exponent [
	^ $e
]

{ #category : #constants }
NeoJSONFloatPrinter >> infinite [
	^ 'Inf'
]

{ #category : #constants }
NeoJSONFloatPrinter >> lower [
	^ self base raisedTo: (self precision - 1) negated
]

{ #category : #constants }
NeoJSONFloatPrinter >> nan [
	^ 'NaN'
]

{ #category : #constants }
NeoJSONFloatPrinter >> precision [
	^ 5
]

{ #category : #printing }
NeoJSONFloatPrinter >> print: float [
	^ String new: 16 streamContents: [ :out | 
			self print: float on: out ]
]

{ #category : #private }
NeoJSONFloatPrinter >> print: fractionPart asFractionOn: stream [
	| zeros |
	zeros := 0. "leading zeros are significant, trailing zeros are not printed"
	self precision to: 1 by: -1 do: [ :position | | digit |
		digit := fractionPart digitAt: position base: self base.
		digit = 0
			ifTrue: [ zeros := zeros +1 ]
			ifFalse: [
				zeros > 0 ifTrue: [ 
					zeros timesRepeat: [ stream nextPut: $0 ]. 
					zeros := 0 ].
				stream nextPut: digit asCharacterDigit ] ]
]

{ #category : #private }
NeoJSONFloatPrinter >> print: float decimalOn: stream [
	| fractionPart zeros |
	stream print: float asInteger.
	stream nextPut: self decimalPoint.
	fractionPart := (float fractionPart * (self base raisedTo: self precision)) rounded.
	zeros := 0.
	self precision to: 1 by: -1 do: [ :position | | digit |
		digit := fractionPart digitAt: position base: self base.
		digit = 0
			ifTrue: [ zeros := zeros +1 ]
			ifFalse: [
				zeros > 0 ifTrue: [ zeros timesRepeat: [ stream nextPut: $0 ]. zeros := 0 ].
				stream nextPut: digit asCharacterDigit ] ]
]

{ #category : #printing }
NeoJSONFloatPrinter >> print: float on: stream [
	| int abs |
	(float isZero or: [ float isFinite not ])
		ifTrue: [ ^ self print: float specialOn: stream ].
	self print: float signOn: stream.
	((abs := float abs) between: self lower and: self upper)
		ifTrue: [ 
			(int := abs asInteger) = abs 
				ifTrue: [ int printOn: stream ]
				ifFalse: [ self print: abs decimalOn: stream ] ]
		ifFalse: [ self print: abs scientificOn: stream ]
]

{ #category : #private }
NeoJSONFloatPrinter >> print: float scientificOn: stream [
	| exponent mantissa |
	exponent := (float ln / self base ln) floor.
	mantissa := float / (self base raisedTo: exponent).
	self print: mantissa decimalOn: stream.
	stream
		nextPut: self exponent;
		print: exponent
]

{ #category : #private }
NeoJSONFloatPrinter >> print: float signOn: stream [
	float sign = -1
		ifTrue: [ stream nextPut: $- ]
]

{ #category : #private }
NeoJSONFloatPrinter >> print: float specialOn: stream [
	float isZero
		ifTrue: [ 
			stream nextPut: $0 ]
		ifFalse: [
			float isNaN 
				ifTrue: [ 
					stream nextPutAll: self nan ]
				ifFalse: [
					self print: float signOn: stream.
					stream nextPutAll: self infinite ] ]
]

{ #category : #printing }
NeoJSONFloatPrinter >> printFloat: float on: stream [
	self print: float on: stream
]

{ #category : #constants }
NeoJSONFloatPrinter >> upper [
	^ self base raisedTo: (self precision + 1)
]
