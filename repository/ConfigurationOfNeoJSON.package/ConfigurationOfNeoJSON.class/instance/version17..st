versions
version17: spec
	<version: '17' imports: #('1-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #release;
			package: 'Neo-JSON-Core' with: 'Neo-JSON-Core-SvenVanCaekenberghe.46';
			package: 'Neo-JSON-Tests' with: 'Neo-JSON-Tests-SvenVanCaekenberghe.44' ]