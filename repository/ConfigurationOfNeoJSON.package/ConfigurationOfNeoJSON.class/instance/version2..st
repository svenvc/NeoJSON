versions
version2: spec
	<version: '2' imports: #('1-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #release;
			package: 'Neo-JSON-Core' with: 'Neo-JSON-Core-SvenVanCaekenberghe.19';
			package: 'Neo-JSON-Tests' with: 'Neo-JSON-Tests-SvenVanCaekenberghe.16' ]