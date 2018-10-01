I am NeoJSONValidation, a set of tests to validate NeoJSON against some external rules.

Both positive & negative tests are includes.
Some of these are implementation choices.

http://seriot.ch/parsing_json.php
https://github.com/nst/JSONTestSuite
https://github.com/nst/JSONTestSuite.git
  test_parsing
  test_transform

https://github.com/miloyip/nativejson-benchmark
https://github.com/miloyip/nativejson-benchmark.git
  data/jsonchecker
  data/roundtrip

This can only be run with the correct setup (checkout/config).

  NeoJSONValidation new runNativeJsonBenchmarkRoundTrip.
  NeoJSONValidation new runNativeJsonBenchmarkJsonCheckerPasses.
  NeoJSONValidation new runNativeJsonBenchmarkJsonCheckerFailures.

  NeoJSONValidation new runJsonTestSuiteTestParsingPasses.
  NeoJSONValidation new runJsonTestSuiteTestParsingFailures.
  NeoJSONValidation new runJsonTestSuiteTestParsingInfo.

Logging goes to a file, neo-json-validation.log