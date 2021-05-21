"
I am NeoJSONFloatPrinter.

I print Float numbers in a compact, human friendly format.

The following (default) parameters are used:
 - base 10 - hardcoded (for now)
 - precision 5 digits
 - decimal point - hardcoded (for now)
 - exponent e - hardcoded (for now)
 - NaN, Inf and -Inf - hardcoded (for now)
 - lower 1e-4
 - upper 1e6
 - decimal notation for abs values inside abs [ lower, upper ]
 - scientific notation for abs values outside [ lower, upper ]
 - no padding, no trailing zeros in fraction part
 - only negative sign, never a positive sign
 - no thousands separators
 - no engineering notation

See my class side for configuration examples.

My public interface is in the printing protocol.

"
Class {
	#name : #NeoJSONFloatPrinter,
	#superclass : #Object,
	#instVars : [
		'precision',
		'lower',
		'upper',
		'base'
	],
	#category : #'Neo-JSON-Core'
}

{ #category : #'instance creation' }
NeoJSONFloatPrinter class >> lowPrecision [
	^ self new
		precision: 2;
		lower: 1e-2;
		upper: 1e5;
		yourself
]

{ #category : #'instance creation' }
NeoJSONFloatPrinter class >> scientificOnly [
	^ self new
		lower: 0;
		upper: 0;
		yourself
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

{ #category : #'initialize-release' }
NeoJSONFloatPrinter >> initialize [
	super initialize.
	base := 10.
	precision := 5.
	lower := 1e-4.
	upper := 1e6
]

{ #category : #'initialize-release' }
NeoJSONFloatPrinter >> lower: number [
	lower := number
]

{ #category : #constants }
NeoJSONFloatPrinter >> nan [
	^ 'NaN'
]

{ #category : #'initialize-release' }
NeoJSONFloatPrinter >> precision: numberOfDigits [
	self assert: (numberOfDigits between: 1 and: 20).
	precision := numberOfDigits
]

{ #category : #printing }
NeoJSONFloatPrinter >> print: float [
	^ String new: 16 streamContents: [ :out | 
			self print: float on: out ]
]

{ #category : #private }
NeoJSONFloatPrinter >> print: float decimalOn: stream [
	stream print: float asInteger.
	stream nextPut: self decimalPoint.
	self 
		print: (float fractionPart * (base raisedTo: precision)) rounded 
		fractionOn: stream
]

{ #category : #private }
NeoJSONFloatPrinter >> print: fractionPart fractionOn: stream [
	| zeros |
	zeros := 0. "leading zeros are significant, trailing zeros are not printed"
	precision to: 1 by: -1 do: [ :position | | digit |
		digit := fractionPart digitAt: position base: base.
		digit = 0
			ifTrue: [ zeros := zeros +1 ]
			ifFalse: [
				zeros > 0 ifTrue: [ 
					zeros timesRepeat: [ stream nextPut: $0 ]. 
					zeros := 0 ].
				stream nextPut: digit asCharacterDigit ] ]
]

{ #category : #printing }
NeoJSONFloatPrinter >> print: float on: stream [
	| int abs |
	(float isZero or: [ float isFinite not ])
		ifTrue: [ ^ self print: float specialOn: stream ].
	self print: float signOn: stream.
	((abs := float abs) between: lower and: upper)
		ifTrue: [ 
			(int := abs asInteger) = abs 
				ifTrue: [ int printOn: stream ]
				ifFalse: [ self print: abs decimalOn: stream ] ]
		ifFalse: [ self print: abs scientificOn: stream ]
]

{ #category : #private }
NeoJSONFloatPrinter >> print: float scientificOn: stream [
	| exponent mantissa |
	exponent := (float ln / base ln) floor.
	mantissa := float / (base raisedTo: exponent).
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

{ #category : #'initialize-release' }
NeoJSONFloatPrinter >> upper: number [
	upper := number
]
