versions
version1: spec
	<version: '1' imports: #('1-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #release;
			package: 'Neo-JSON-Core' with: 'Neo-JSON-Core-SvenVanCaekenberghe.17';
			package: 'Neo-JSON-Tests' with: 'Neo-JSON-Tests-SvenVanCaekenberghe.15' ]