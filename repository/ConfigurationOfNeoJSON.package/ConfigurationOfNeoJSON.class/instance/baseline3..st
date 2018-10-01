baselines
baseline3: spec
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