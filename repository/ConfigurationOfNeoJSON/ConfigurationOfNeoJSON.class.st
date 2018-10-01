"
I am ConfigurationOfNeoJSON, a Metacello configuration for NeoJSON.

NeoJSON is a flexible and efficient reader and writer for JSON.
"
Class {
	#name : #ConfigurationOfNeoJSON,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : 'ConfigurationOfNeoJSON'
}

{ #category : #'development support' }
ConfigurationOfNeoJSON class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfNeoJSON class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #accessing }
ConfigurationOfNeoJSON class >> catalogContactInfo [
	^ 'Written and maintained by Sven Van Caekenberghe (http://stfx.eu) and the community. Discussions on the Pharo mailing lists.'
]

{ #category : #accessing }
ConfigurationOfNeoJSON class >> catalogDescription [
	^ 'JSON (JavaScript Object Notation) is a popular data-interchange format. NeoJSON is an elegant and efficient standalone Smalltalk framework to read and write JSON converting to or from Smalltalk objects.'
]

{ #category : #accessing }
ConfigurationOfNeoJSON class >> catalogKeywords [
	^ #(format input output json serialization encoding text javascript)
]

{ #category : #private }
ConfigurationOfNeoJSON class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfNeoJSON class >> ensureMetacelloBaseConfiguration [

	Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			| repository version |
			repository := MCHttpRepository location: 'http://seaside.gemstone.com/ss/metacello' user: '' password: ''.
			repository
				versionReaderForFileNamed: 'Metacello-Base-DaleHenrichs.2.mcz'
				do: [ :reader | 
					version := reader version.
					version load.
					version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfNeoJSON class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfNeoJSON class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfNeoJSON class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfNeoJSON class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfNeoJSON class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfNeoJSON class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfNeoJSON >> baseline1: spec [
	<version: '1-baseline'>
	
	spec for: #common do: [
		spec 
			blessing: #baseline;
			repository: 'http://mc.stfx.eu/Neo';
			package: 'Neo-JSON-Core';
			package: 'Neo-JSON-Tests' with: [ spec requires: 'Neo-JSON-Core' ];
			group: 'default' with: #('Neo-JSON-Core' 'Neo-JSON-Tests');
			group: 'Core' with: #('Neo-JSON-Core');
			group: 'Tests' with: #('Neo-JSON-Tests') ]
]

{ #category : #baselines }
ConfigurationOfNeoJSON >> baseline2: spec [
	<version: '2-baseline'>
	spec
		for: #common
		do: [ 
			spec
				blessing: #baseline;
				repository: 'http://mc.stfx.eu/Neo';
				package: 'Neo-JSON-Core';
				package: 'Neo-JSON-Tests' with: [ spec requires: 'Neo-JSON-Core' ];
				group: 'default' with: #('Neo-JSON-Core' 'Neo-JSON-Tests');
				group: 'Core' with: #('Neo-JSON-Core');
				group: 'Tests' with: #('Neo-JSON-Tests') ].
	spec
		for: #gemstone
		do: [ 
			spec
				baseline: 'NeoJSON' with: [ spec repository: 'github://GsDevKit/NeoJSON:master/repository' ];
				import: 'NeoJSON' ]
]

{ #category : #baselines }
ConfigurationOfNeoJSON >> baseline3: spec [
	<version: '3-baseline'>
	spec
		for: #common
		do: [ 
			spec
				blessing: #baseline;
				repository: 'http://mc.stfx.eu/Neo';
				package: 'Neo-JSON-Core';
				package: 'Neo-JSON-Tests' with: [ spec requires: 'Neo-JSON-Core' ];
				group: 'default' with: #('Core' 'Tests');
				group: 'Core' with: #('Neo-JSON-Core');
				group: 'Tests' with: #('Neo-JSON-Tests') ].
			
	
	spec
		for: #pharo
		do: [
			
			spec 
				package: 'Neo-JSON-Pharo-Examples' with: [ spec requires: 'Neo-JSON-Core' ];
				group: 'Examples' with: #('Neo-JSON-Pharo-Examples').
			
			"So far, it only contains Pharo-Specific extensions" 
			spec
				package: 'Neo-JSON-Pharo-Core' with: [ spec requires: #( 'Neo-JSON-Core') ];
				package: 'Neo-JSON-Pharo-Tests' with: [ spec requires: #( 'Neo-JSON-Tests') ];
				group: 'Core' with: #('Neo-JSON-Core' 'Neo-JSON-Pharo-Core').
			
			"CoreVASTExport group is used when we are exporting code to be later imported in VAST/ENVY via Monticello Importer. 'Neo-JSON-VASTMock' should not be imported in ENVY....its goal is that in 'Neo-JSON-VAST-Core' we can define extension methods to classes defined in VAST but not existing in Pharo. So in 'Neo-JSON-VASTMock' we simply create dummy classes with the sole purpose of being able to define extension methods for it. "
			spec	
				package: 'Neo-JSON-VASTMock';
				package: 'Neo-JSON-VAST-Core' with: [ spec requires: #('Neo-JSON-VASTMock' 'Neo-JSON-Core') ];
				package: 'Neo-JSON-VAST-Tests' with: [ spec requires: #( 'Neo-JSON-Tests') ];
				group: 'CoreVASTExport' with: #('Neo-JSON-Core' 'Neo-JSON-VAST-Core' 'Tests' 'Neo-JSON-VAST-Tests' ).
		].
			
	spec
		for: #gemstone
		do: [ 
			spec
				baseline: 'NeoJSON' with: [ spec repository: 'github://GsDevKit/NeoJSON:master/repository' ];
				import: 'NeoJSON' ]
]

{ #category : #'symbolic versions' }
ConfigurationOfNeoJSON >> bleedingEdge: spec [
	<symbolicVersion: #'bleedingEdge'>
]

{ #category : #'symbolic versions' }
ConfigurationOfNeoJSON >> development: spec [
	<symbolicVersion: #'development'>
]

{ #category : #accessing }
ConfigurationOfNeoJSON >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		(self class baseConfigurationClassIfAbsent: []) ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfNeoJSON >> stable: spec [
	<symbolicVersion: #'stable'>
	
	spec for: #common version: '17'.
	
	spec for: #gemstone version: '13'.
]

{ #category : #versions }
ConfigurationOfNeoJSON >> version10: spec [
	<version: '10' imports: #('1-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #release;
			package: 'Neo-JSON-Core' with: 'Neo-JSON-Core-SvenVanCaekenberghe.29';
			package: 'Neo-JSON-Tests' with: 'Neo-JSON-Tests-SvenVanCaekenberghe.26' ]
]

{ #category : #versions }
ConfigurationOfNeoJSON >> version11: spec [
	<version: '11' imports: #('1-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #release;
			package: 'Neo-JSON-Core' with: 'Neo-JSON-Core-SvenVanCaekenberghe.30';
			package: 'Neo-JSON-Tests' with: 'Neo-JSON-Tests-SvenVanCaekenberghe.30' ]
]

{ #category : #versions }
ConfigurationOfNeoJSON >> version12: spec [
	<version: '12' imports: #('1-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #release;
			package: 'Neo-JSON-Core' with: 'Neo-JSON-Core-SvenVanCaekenberghe.31';
			package: 'Neo-JSON-Tests' with: 'Neo-JSON-Tests-SvenVanCaekenberghe.31' ]
]

{ #category : #versions }
ConfigurationOfNeoJSON >> version13: spec [
	<version: '13' imports: #('1-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #release;
			package: 'Neo-JSON-Core' with: 'Neo-JSON-Core-SvenVanCaekenberghe.33';
			package: 'Neo-JSON-Tests' with: 'Neo-JSON-Tests-SvenVanCaekenberghe.33' ]
]

{ #category : #versions }
ConfigurationOfNeoJSON >> version14: spec [
	<version: '14' imports: #('1-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #release;
			package: 'Neo-JSON-Core' with: 'Neo-JSON-Core-SvenVanCaekenberghe.37';
			package: 'Neo-JSON-Tests' with: 'Neo-JSON-Tests-SvenVanCaekenberghe.35' ]
]

{ #category : #versions }
ConfigurationOfNeoJSON >> version15: spec [
	<version: '15' imports: #('1-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #release;
			package: 'Neo-JSON-Core' with: 'Neo-JSON-Core-SvenVanCaekenberghe.37';
			package: 'Neo-JSON-Tests' with: 'Neo-JSON-Tests-SvenVanCaekenberghe.36' ]
]

{ #category : #versions }
ConfigurationOfNeoJSON >> version16: spec [
	<version: '16' imports: #('1-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #release;
			package: 'Neo-JSON-Core' with: 'Neo-JSON-Core-SvenVanCaekenberghe.42';
			package: 'Neo-JSON-Tests' with: 'Neo-JSON-Tests-SvenVanCaekenberghe.39' ]
]

{ #category : #versions }
ConfigurationOfNeoJSON >> version17: spec [
	<version: '17' imports: #('1-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #release;
			package: 'Neo-JSON-Core' with: 'Neo-JSON-Core-SvenVanCaekenberghe.46';
			package: 'Neo-JSON-Tests' with: 'Neo-JSON-Tests-SvenVanCaekenberghe.44' ]
]

{ #category : #versions }
ConfigurationOfNeoJSON >> version1: spec [
	<version: '1' imports: #('1-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #release;
			package: 'Neo-JSON-Core' with: 'Neo-JSON-Core-SvenVanCaekenberghe.17';
			package: 'Neo-JSON-Tests' with: 'Neo-JSON-Tests-SvenVanCaekenberghe.15' ]
]

{ #category : #versions }
ConfigurationOfNeoJSON >> version2: spec [
	<version: '2' imports: #('1-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #release;
			package: 'Neo-JSON-Core' with: 'Neo-JSON-Core-SvenVanCaekenberghe.19';
			package: 'Neo-JSON-Tests' with: 'Neo-JSON-Tests-SvenVanCaekenberghe.16' ]
]

{ #category : #versions }
ConfigurationOfNeoJSON >> version30: spec [
	<version: '30' imports: #('3-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #development ]
]

{ #category : #versions }
ConfigurationOfNeoJSON >> version3: spec [
	<version: '3' imports: #('1-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #release;
			package: 'Neo-JSON-Core' with: 'Neo-JSON-Core-SvenVanCaekenberghe.20';
			package: 'Neo-JSON-Tests' with: 'Neo-JSON-Tests-SvenVanCaekenberghe.16' ]
]

{ #category : #versions }
ConfigurationOfNeoJSON >> version4: spec [
	<version: '4' imports: #('1-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #release;
			package: 'Neo-JSON-Core' with: 'Neo-JSON-Core-SvenVanCaekenberghe.23';
			package: 'Neo-JSON-Tests' with: 'Neo-JSON-Tests-SvenVanCaekenberghe.18' ]
]

{ #category : #versions }
ConfigurationOfNeoJSON >> version5: spec [
	<version: '5' imports: #('1-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #release;
			package: 'Neo-JSON-Core' with: 'Neo-JSON-Core-SvenVanCaekenberghe.24';
			package: 'Neo-JSON-Tests' with: 'Neo-JSON-Tests-SvenVanCaekenberghe.19' ]
]

{ #category : #versions }
ConfigurationOfNeoJSON >> version6: spec [
	<version: '6' imports: #('1-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #release;
			package: 'Neo-JSON-Core' with: 'Neo-JSON-Core-SvenVanCaekenberghe.24';
			package: 'Neo-JSON-Tests' with: 'Neo-JSON-Tests-SvenVanCaekenberghe.20' ]
]

{ #category : #versions }
ConfigurationOfNeoJSON >> version7: spec [
	<version: '7' imports: #('1-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #release;
			package: 'Neo-JSON-Core' with: 'Neo-JSON-Core-SvenVanCaekenberghe.24';
			package: 'Neo-JSON-Tests' with: 'Neo-JSON-Tests-SvenVanCaekenberghe.21' ]
]

{ #category : #versions }
ConfigurationOfNeoJSON >> version8: spec [
	<version: '8' imports: #('1-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #release;
			package: 'Neo-JSON-Core' with: 'Neo-JSON-Core-SvenVanCaekenberghe.24';
			package: 'Neo-JSON-Tests' with: 'Neo-JSON-Tests-SvenVanCaekenberghe.22' ]
]

{ #category : #versions }
ConfigurationOfNeoJSON >> version9: spec [
	<version: '9' imports: #('1-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #release;
			package: 'Neo-JSON-Core' with: 'Neo-JSON-Core-SvenVanCaekenberghe.27';
			package: 'Neo-JSON-Tests' with: 'Neo-JSON-Tests-SvenVanCaekenberghe.24' ]
]
