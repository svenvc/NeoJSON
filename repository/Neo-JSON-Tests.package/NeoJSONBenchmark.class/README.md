I am NeoJSONBenchmark.
I hold 1000 objects of the form Dictionary('color'->'green' 'enabled'->false 'id'->1 'name'->'Name-1' 'value'->0.002 ) in an Array.
I hold the JSON serialization of that as a String of the form '[{"value":0.002,"enabled":false,"name":"Name-1","color":"green","id":1}, ...

| benchmark |
benchmark := NeoJSONBenchmark new.
[benchmark read] bench.

| benchmark |
benchmark := NeoJSONBenchmark new.
[benchmark write] bench.

| benchmark |
benchmark := NeoJSONBenchmark new.
[benchmark read] timeToRun.

| benchmark |
benchmark := NeoJSONBenchmark new.
[benchmark write] timeToRun.