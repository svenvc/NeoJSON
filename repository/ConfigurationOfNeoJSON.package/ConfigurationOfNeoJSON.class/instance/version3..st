versions
version3: spec
	<version: '3' imports: #('1-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #release;
			package: 'Neo-JSON-Core' with: 'Neo-JSON-Core-SvenVanCaekenberghe.20';
			package: 'Neo-JSON-Tests' with: 'Neo-JSON-Tests-SvenVanCaekenberghe.16' ]