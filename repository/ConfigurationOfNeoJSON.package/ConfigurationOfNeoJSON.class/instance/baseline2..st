baselines
baseline2: spec
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