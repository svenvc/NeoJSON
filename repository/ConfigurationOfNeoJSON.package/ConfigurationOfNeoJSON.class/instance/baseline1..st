baselines
baseline1: spec
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