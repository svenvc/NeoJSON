# NeoJSON

NeoJSON is an elegant and efficient standalone Smalltalk framework to read and write JSON converting to or from Smalltalk objects.

[![CI](https://github.com/svenvc/NeoJSON/actions/workflows/CI.yml/badge.svg)](https://github.com/svenvc/NeoJSON/actions/workflows/CI.yml)

MIT Licensed.

Go ahead and read the [NeoJSON paper](https://github.com/svenvc/docs/blob/master/neo/neo-json-paper.md).

Basically, NeoJSONWriter is used to write a JSON representation of Smalltalk objects to a textual stream.
Similary, NeoJSONReader is used to parse a JSON representation from a textual stream into Smalltalk objects.

http://www.json.org
https://en.wikipedia.org/wiki/JSON

## Installation

You can load NeoJSON using Metacello

```Smalltalk
Metacello new
  repository: 'github://svenvc/NeoJSON/repository';
  baseline: 'NeoJSON';
  load.
```

You can use the following dependency from your own Metacello configuration or baseline

```Smalltalk
spec baseline: 'NeoJSON' with: [ spec repository: 'github://svenvc/NeoJSON/repository' ].
```
