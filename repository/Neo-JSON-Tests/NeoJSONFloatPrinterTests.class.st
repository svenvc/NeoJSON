"
I am NeoJSONFloatPrinterTests, the collection of unit tests for NeoJSONFloatPrinter.
"
Class {
	#name : #NeoJSONFloatPrinterTests,
	#superclass : #TestCase,
	#instVars : [
		'printer'
	],
	#category : #'Neo-JSON-Tests'
}

{ #category : #running }
NeoJSONFloatPrinterTests >> setUp [
	super setUp.
	printer := NeoJSONFloatPrinter new
]

{ #category : #tests }
NeoJSONFloatPrinterTests >> testDecimalNotation [
	self assert: (printer print: 1.5) equals: '1.5'.
	self assert: (printer print: -1.5) equals: '-1.5'.
	self assert: (printer print: 0.5) equals: '0.5'.
	self assert: (printer print: -0.5) equals: '-0.5'.
	self assert: (printer print: (1/3) asFloat) equals: '0.33333'.
	self assert: (printer print: (-1/3) asFloat) equals: '-0.33333'.
	self assert: (printer print: 0.00123) equals: '0.00123'.
	self assert: (printer print: -0.00123) equals: '-0.00123'.
	self assert: (printer print: 0.00012) equals: '0.00012'.
	self assert: (printer print: -0.00012) equals: '-0.00012'.
	self assert: (printer print: 123456.12345) equals: '123456.12345'.
	self assert: (printer print: -123456.12345) equals: '-123456.12345'.

]

{ #category : #tests }
NeoJSONFloatPrinterTests >> testInteger [
	self assert: (printer print: 1.0) equals: '1'.
	self assert: (printer print: 0.0) equals: '0'.
	self assert: (printer print: -1.0) equals: '-1'.
	self assert: (printer print: 123.0) equals: '123'.
	self assert: (printer print: 123456.0) equals: '123456'.
	
]

{ #category : #tests }
NeoJSONFloatPrinterTests >> testLowPrecision [
	printer := NeoJSONFloatPrinter lowPrecision.
	self assert: (printer print: (4/3) asFloat) equals: '1.33'.
	self assert: (printer print: 12345.66) equals: '12345.66'.
	self assert: (printer print: -123456.77) equals: '-1.23e5'.
	self assert: (printer print: Float pi) equals: '3.14'.
	self assert: (printer print: Float e negated) equals: '-2.72'.
	"the earth's mass in kg"
	self assert: (printer print: 5.9724e24) equals: '5.97e24'.
	"mass of electron in kg"
	self assert: (printer print: 9.10938356e-31) equals: '9.11e-31'.
]

{ #category : #tests }
NeoJSONFloatPrinterTests >> testScientificNotation [
	self assert: (printer print: 1234567.5) equals: '1.23457e6'. "note the rounding"
	self assert: (printer print: -1234567.5) equals: '-1.23457e6'. "note the rounding"
	self assert: (printer print: 0.0000123) equals: '1.23e-5'.
	self assert: (printer print: -0.0000123) equals: '-1.23e-5'.

]

{ #category : #tests }
NeoJSONFloatPrinterTests >> testScientificOnly [
	printer := NeoJSONFloatPrinter scientificOnly.
	self assert: (printer print: (4/3) asFloat) equals: '1.33333e0'.
	self assert: (printer print: 12345.66) equals: '1.23457e4'.
	self assert: (printer print: Float pi) equals: '3.14159e0'.
	self assert: (printer print: Float e negated) equals: '-2.71828e0'.
	"the earth's mass in kg"
	self assert: (printer print: 5.9724e24) equals: '5.9724e24'.
	"mass of electron in kg"
	self assert: (printer print: 9.10938356e-31) equals: '9.10938e-31'.
]

{ #category : #tests }
NeoJSONFloatPrinterTests >> testSpecialValues [
	self assert: (printer print: Float zero) equals: '0'.
	self assert: (printer print: Float nan) equals: 'NaN'.
	self assert: (printer print: Float infinity) equals: 'Inf'.
	self assert: (printer print: Float infinity negated) equals: '-Inf'.
]

{ #category : #tests }
NeoJSONFloatPrinterTests >> testWellKnownConstants [
	self assert: (printer print: Float pi) equals: '3.14159'.
	self assert: (printer print: Float e) equals: '2.71828'.
	"the earth's mass in kg"
	self assert: (printer print: 5.9724e24) equals: '5.9724e24'.
	"mass of electron in kg"
	self assert: (printer print: 9.10938356e-31) equals: '9.10938e-31'.
	"planck's constant in Js"
	self assert: (printer print: 1.05457e-34) equals: '1.05457e-34'.
	"speed of light in m/s"
	self assert: (printer print: 2.99792e8) equals: '2.99792e8'.
	"charge of electron in C"
	self assert: (printer print: -1.60218e-19) equals: '-1.60218e-19'.
	"boltzmann's constant in J/K"
	self assert: (printer print: 1.38065e-23) equals: '1.38065e-23'.

]
